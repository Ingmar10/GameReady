# GameReady 🏀

A youth basketball training and community app built in FlutterFlow. Train like a pro, track your grind, and connect with the community.

---

## What It Is

GameReady is a mobile-first app for young basketball players (ages 10–20) that combines sport-specific workout programming, gamified achievement tracking, and a tight-knit community feed. Basketball first — more sports coming.

---

## Core Features

### Training
- Position-based training paths (PG, SG, SF, PF, C)
- Drill library with video/GIF demonstrations
- Active workout tracker (sets, reps, timers)
- Skill progression levels: Rookie → Varsity → Elite

### Achievements
- XP points and player level system
- Unlockable badges for milestones and streaks
- Personal records tracking (shooting %, vertical, speed drills)
- Weekly streak counter

### Community
- Social feed (posts, likes, comments)
- Clip sharing (short skill videos)
- Team/Squad creation and management
- Weekly challenges with leaderboards

### Profile
- Player card (position, level, XP bar, stats)
- Achievement showcase
- Social links (Instagram, TikTok, X)
- Activity history

---

## Tech Stack

| Layer | Tool |
|---|---|
| UI / App Builder | FlutterFlow |
| Backend | Firebase (Firestore, Auth, Storage, FCM) |
| Auth | Firebase Auth (Google, Apple, Email) |
| Database | Cloud Firestore |
| Media Storage | Firebase Storage |
| Push Notifications | Firebase Cloud Messaging |
| Drill Content | Self-hosted in Firestore + Storage |
| Analytics | Firebase Analytics |

---

## Design Principles

1. **Dark mode first** — looks premium, saves battery, youth prefers it
2. **Gamified everything** — XP, badges, levels, streaks make training addictive
3. **Mobile-native feel** — bottom nav, swipe gestures, haptic feedback
4. **Basketball culture** — language, imagery, and references that resonate
5. **Speed** — cached data, skeleton loaders, optimistic UI updates

---

## Project Docs

- [`docs/data_model.md`](docs/data_model.md) — Firestore collections and schema
- [`docs/screen_flow.md`](docs/screen_flow.md) — Every screen, every state
- [`docs/flutterflow_components.md`](docs/flutterflow_components.md) — FlutterFlow build guide
- [`docs/design_system.md`](docs/design_system.md) — Colors, type, components
- [`docs/basketball_content.md`](docs/basketball_content.md) — Drill library and content structure

---

## Roadmap

- [ ] v1 — Basketball: Training + Achievements + Profile
- [ ] v1.1 — Community feed + Clip sharing
- [ ] v1.2 — Teams/Squads + Weekly Challenges
- [ ] v2 — Add second sport (Soccer or Football)
- [ ] v2.1 — Coach/Parent dashboard
- [ ] v3 — In-app recruiting profile for HS players
