/**
 * GameReady — Firestore Seed Data Importer
 *
 * USAGE:
 *   node import_to_firestore.js --project=YOUR_PROJECT_ID
 *
 * PREREQUISITES:
 *   1. Install dependencies:
 *        npm install firebase-admin
 *
 *   2. Authenticate via one of these methods:
 *      a) Service account key (recommended for CI/scripts):
 *           export GOOGLE_APPLICATION_CREDENTIALS="/path/to/serviceAccountKey.json"
 *      b) Application Default Credentials (if you're already logged into gcloud):
 *           gcloud auth application-default login
 *
 *   3. Run from the seed_data/ directory (or adjust DATA_DIR below):
 *        node import_to_firestore.js --project=gameready-dev
 *
 * WHAT IT DOES:
 *   Reads each JSON file in this directory and batch-imports every object into
 *   the corresponding Firestore collection, using each object's `id` field as
 *   the Firestore document ID. Firestore batch writes are capped at 500 ops,
 *   so large collections are automatically chunked.
 *
 * COLLECTIONS IMPORTED:
 *   drills.json          → drills/
 *   achievements.json    → achievements/
 *   workout_plans.json   → workoutPlans/
 *   challenges.json      → challenges/
 */

const admin = require("firebase-admin");
const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------------------
// Parse CLI args
// ---------------------------------------------------------------------------
const args = Object.fromEntries(
  process.argv
    .slice(2)
    .filter((a) => a.startsWith("--"))
    .map((a) => {
      const [key, ...rest] = a.slice(2).split("=");
      return [key, rest.join("=") || true];
    })
);

const projectId = args.project;
if (!projectId) {
  console.error(
    "ERROR: --project flag is required.\n  Usage: node import_to_firestore.js --project=YOUR_PROJECT_ID"
  );
  process.exit(1);
}

// ---------------------------------------------------------------------------
// Initialise Firebase Admin SDK
// ---------------------------------------------------------------------------
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  projectId,
});

const db = admin.firestore();

// ---------------------------------------------------------------------------
// Configuration: map each JSON file to a Firestore collection name
// ---------------------------------------------------------------------------
const DATA_DIR = path.resolve(__dirname);

const IMPORT_MANIFEST = [
  { file: "drills.json", collection: "drills" },
  { file: "achievements.json", collection: "achievements" },
  { file: "workout_plans.json", collection: "workoutPlans" },
  { file: "challenges.json", collection: "challenges" },
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/**
 * Splits an array into chunks of at most `size` elements.
 * Firestore batch writes are limited to 500 operations per batch.
 */
function chunkArray(arr, size = 499) {
  const chunks = [];
  for (let i = 0; i < arr.length; i += size) {
    chunks.push(arr.slice(i, i + size));
  }
  return chunks;
}

/**
 * Reads a JSON file and parses it as an array.
 * Throws a descriptive error if the file is missing or malformed.
 */
function readJsonArray(filePath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`File not found: ${filePath}`);
  }
  const raw = fs.readFileSync(filePath, "utf8");
  let parsed;
  try {
    parsed = JSON.parse(raw);
  } catch (e) {
    throw new Error(`JSON parse error in ${filePath}: ${e.message}`);
  }
  if (!Array.isArray(parsed)) {
    throw new Error(
      `Expected an array in ${filePath}, got ${typeof parsed}`
    );
  }
  return parsed;
}

/**
 * Imports one collection from a JSON array using batched Firestore writes.
 * Each document must have a top-level `id` string field which becomes the
 * Firestore document ID. The `id` field is removed from the stored document
 * payload to keep the data clean (it's already encoded in the doc path).
 */
async function importCollection(collectionName, documents) {
  const colRef = db.collection(collectionName);
  const now = admin.firestore.FieldValue.serverTimestamp();

  const chunks = chunkArray(documents);
  let totalWritten = 0;

  for (let chunkIndex = 0; chunkIndex < chunks.length; chunkIndex++) {
    const chunk = chunks[chunkIndex];
    const batch = db.batch();

    for (const doc of chunk) {
      if (!doc.id || typeof doc.id !== "string") {
        throw new Error(
          `Document in collection "${collectionName}" is missing a string "id" field: ${JSON.stringify(
            doc
          ).slice(0, 120)}`
        );
      }

      const { id, ...payload } = doc;
      const docRef = colRef.doc(id);

      // Attach server-side timestamps so every seeded document has them
      batch.set(docRef, {
        ...payload,
        createdAt: now,
        updatedAt: now,
      });
    }

    await batch.commit();
    totalWritten += chunk.length;

    const chunkLabel =
      chunks.length > 1
        ? ` (batch ${chunkIndex + 1}/${chunks.length})`
        : "";
    console.log(
      `  ✓ Wrote ${chunk.length} documents to "${collectionName}"${chunkLabel}`
    );
  }

  return totalWritten;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------
async function main() {
  console.log(`\nGameReady Firestore Seed Importer`);
  console.log(`Project: ${projectId}`);
  console.log(`Data directory: ${DATA_DIR}`);
  console.log(`${"─".repeat(52)}\n`);

  let grandTotal = 0;
  const errors = [];

  for (const { file, collection } of IMPORT_MANIFEST) {
    const filePath = path.join(DATA_DIR, file);
    console.log(`Importing "${file}" → Firestore collection "${collection}" …`);

    try {
      const documents = readJsonArray(filePath);
      console.log(`  Found ${documents.length} document(s).`);
      const written = await importCollection(collection, documents);
      grandTotal += written;
      console.log(`  Collection "${collection}" complete.\n`);
    } catch (err) {
      console.error(`  ERROR importing "${file}": ${err.message}\n`);
      errors.push({ file, error: err.message });
    }
  }

  console.log(`${"─".repeat(52)}`);

  if (errors.length === 0) {
    console.log(
      `\nAll done! ${grandTotal} document(s) imported across ${IMPORT_MANIFEST.length} collection(s).\n`
    );
  } else {
    console.log(
      `\nCompleted with ${errors.length} error(s). ${grandTotal} document(s) imported.\n`
    );
    console.log("Errors:");
    for (const { file, error } of errors) {
      console.log(`  • ${file}: ${error}`);
    }
    console.log();
    process.exit(1);
  }
}

main().catch((err) => {
  console.error("Fatal error:", err);
  process.exit(1);
});
