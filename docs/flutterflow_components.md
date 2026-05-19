# FlutterFlow Build Guide

## Project Setup

### Firebase Integration
1. Create Firebase project: `gameready-app`
2. Enable: Authentication, Firestore, Storage, Cloud Messaging, Analytics
3. In FlutterFlow: Settings → Firebase → connect project
4. Enable auth providers: Google, Apple, Email/Password

### App Theme
- Set theme to **Dark** as default
- Import Google Fonts: `Inter`, `Barlow Condensed`
- Define all colors from design_system.md in Theme Colors
- Set `background` as scaffold background

---

## Page Architecture

### Bottom Navigation
- 5 tabs: Home, Train, Achievements, Community, Profile
- Use FlutterFlow's NavBar widget
- Custom icons from Phosphor (use icon font or SVG import)
- Active tab: `orange` icon, inactive: `textSecondary`
- Background: `surface` with top border 1px `border`

---

## Reusable Components (Custom Widgets)

### 1. `PlayerLevelCard`
**Used on:** Home dashboard, Profile header
**Fields:** avatarUrl, displayName, username, level, xp, xpToNextLevel, streakDays
**Structure:**
- Row: avatar (circle, 56px) | Column: name + username | level badge pill
- XP progress bar below (animated on load)
- Streak flame + count on right

**Page State:** none (data-driven)
**Firestore query:** `users/{currentUser.uid}`

---

### 2. `DrillCard` (grid variant)
**Used on:** Drill Library, Plan Day view
**Fields:** thumbnailUrl, title, category, duration, xpReward, skillLevel
**Structure:**
- 16:9 thumbnail with gradient overlay
- Title (headingS, bottom-left over image)
- Bottom row: duration chip | XP chip | skill dot
**On Tap:** navigate to Drill Detail page, passing drillId

---

### 3. `DrillCard` (list variant)
**Used on:** Active Workout, Search results
**Structure:**
- Horizontal row: thumbnail (80x60) | title + category + duration | XP reward

---

### 4. `BadgeCard`
**Used on:** Achievements grid
**Fields:** badgeImageUrl, name, rarity, earned (bool), earnedDate
**Structure:**
- Circle image (80px)
- Rarity glow border (conditional color by rarity)
- Name below (labelM)
- If not earned: overlay with 60% dark + lock icon
**On Tap:** open BadgeDetailModal

---

### 5. `PostCard`
**Used on:** Community feed
**Fields:** authorAvatarUrl, authorUsername, timeAgo, content, mediaUrl, mediaType, likeCount, commentCount, isLiked
**Structure:**
- Header: avatar + username + time ago + options (•••)
- Content text
- Media (conditional: image → FlutterFlow Image, video → VideoPlayer widget)
- Footer: like button (heart, animated) | comment button | share button
**On Like:** Firestore update likeCount +1, toggle `isLiked` local state

---

### 6. `XPGainOverlay`
**Used on:** Drill complete, badge earn, challenge submit
**Trigger:** page-level boolean state `showXPGain`
**Structure:**
- Full-screen transparent overlay
- Center: "+{xpAmount} XP" in displayL Barlow, orange
- Lottie animation: particle burst (upload to Storage)
- Auto-dismiss after 1500ms using Timer custom action

---

### 7. `BadgeEarnedModal`
**Used on:** When achievement unlocked
**Trigger:** push notification listener or post-workout check
**Structure:**
- Bottom sheet modal
- Badge image (animated scale in, 120px)
- Rarity chip
- Title + description
- "Share" + "Done" buttons

---

### 8. `WorkoutProgressHeader`
**Used on:** Active Workout screen
**Fields:** currentDrill, totalDrills, planTitle
**Structure:**
- "Drill {current} of {total}" in bodyM
- Linear progress bar (fill = current/total)
- Plan title as subtitle

---

### 9. `StatChip`
**Used on:** Profile stats row, challenge leaderboard
**Fields:** icon, label, value
**Structure:** Column — icon (24px) | value (headingM) | label (bodyS muted)

---

### 10. `LeaderboardRow`
**Used on:** Challenge leaderboard
**Fields:** rank, avatarUrl, username, value, isCurrentUser
**Structure:**
- Rank number (bold, colored gold/silver/bronze for 1-3)
- Avatar (32px circle)
- Username
- Value (right-aligned, bold)
- Highlighted background if isCurrentUser

---

## Key Firestore Queries

### Home — Today's Workout
```
Collection: workoutPlans
Filter: targetPosition == currentUser.position
       AND skillLevel == currentUser.skillLevel
Order: createdAt DESC
Limit: 1
```

### Drill Library
```
Collection: drills
Filter: (optional) category == selectedFilter
        AND skillLevel <= currentUser.skillLevel
Order: createdAt DESC
Limit: 20 (paginate)
```

### Community Feed
```
Collection: posts
Order: createdAt DESC
Limit: 20 (paginate with infinite scroll)
```

### My Achievements
```
Collection: userAchievements/{userId}/earned
(Fetch all, then cross-reference achievements collection for display data)
```

### Weekly Challenge Leaderboard
```
Collection: challengeEntries
Filter: challengeId == currentChallenge.id
Order: value DESC
Limit: 50
```

---

## Custom Actions (Dart)

### `calculateLevel(xp: int) → int`
```dart
int calculateLevel(int xp) {
  if (xp >= 25000) return 25;
  if (xp >= 15000) return 20;
  if (xp >= 8000) return 15;
  if (xp >= 3500) return 10;
  if (xp >= 1000) return 5;
  return 1;
}
```

### `awardXP(userId: string, amount: int)`
- Firestore transaction: read current XP, add amount, write back
- Check if new XP crosses a level threshold → trigger badge check
- Update `users/{userId}.xp`

### `checkStreakUpdate(userId: string)`
- Read `lastActiveDate` from user doc
- If today - lastActiveDate == 1 day: increment `streakDays`
- If today - lastActiveDate > 1 day: reset `streakDays` to 1
- If same day: no change
- Write updated values

### `checkAchievements(userId: string, eventType: string)`
- Called after: drill complete, post created, follower added, etc.
- Queries `achievements` for matching `condition.type`
- Checks if threshold met
- If met and not already in `userAchievements/{userId}/earned`: write achievement, award XP, trigger BadgeEarnedModal

### `generateShareCard(achievementId: string) → Uint8List`
- Uses `screenshot` Flutter package (add as custom dependency)
- Renders: GameReady logo, badge image, badge name, username
- Returns PNG bytes for share sheet

---

## App State Variables

| Variable | Type | Used For |
|---|---|---|
| `currentUser` | Document (users) | Global user data, cached |
| `activeWorkoutDrills` | List<Document> | Drills in current workout session |
| `activeWorkoutIndex` | int | Current drill index |
| `selectedFeedFilter` | string | Community feed active filter |
| `selectedDrillFilter` | string | Drill library active filter |
| `showXPGain` | bool | Trigger XP overlay |
| `pendingXPAmount` | int | XP to show in overlay |
| `unreadNotifCount` | int | Badge on notifications icon |

---

## Firebase Cloud Messaging (Push Notifications)

### Setup
1. Add FCM to Firebase project
2. In FlutterFlow: enable Push Notifications
3. Store FCM token in `users/{userId}.fcmToken` on login

### Notification Triggers (via Firebase Functions)
- **Streak reminder** — daily 6pm if no workout logged
- **New follower** — immediate
- **Post liked** — immediate (debounce 5 likes into 1 notif)
- **Challenge ending** — 24 hours before close
- **Badge earned** — immediate
- **Team invite** — immediate

---

## Deep Links / Share Flows

### Achievement Share
- Generate share card image (custom action)
- Native share sheet with image + text: "Just earned [Badge Name] on GameReady 🏀 #GameReady #Basketball"
- Include App Store / Play Store link

### Clip Share to Instagram/TikTok
- Download video to device gallery first
- Open Instagram/TikTok via URL scheme
- iOS: `instagram://library?AssetPath=...`
- Android: share intent to com.instagram.android

---

## COPPA / Youth Safety Checklist

- [ ] Age gate on signup — users under 13 require parental consent flow
- [ ] No direct messaging between users in v1
- [ ] Community posts moderation queue for flagged content
- [ ] Report/block functionality on all user-generated content
- [ ] Privacy default: under-13 accounts are private
- [ ] No display of last name or precise location
- [ ] Parental email verification for under-13 accounts
