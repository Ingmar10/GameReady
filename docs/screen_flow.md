# Screen Flow — GameReady

## Navigation Structure

```
App
├── Onboarding (first launch only)
│   ├── Welcome
│   ├── Position Selector
│   ├── Skill Level
│   └── Profile Setup
│
└── Main App (Bottom Nav — 5 tabs)
    ├── 🏠 Home
    ├── 🏋️ Train
    ├── 🏆 Achievements
    ├── 🔥 Community
    └── 👤 Profile
```

---

## Onboarding Flow

### Screen 1 — Welcome
- Full-screen video/animation background (basketball court, slow-mo dribble)
- "GameReady" logo centered
- Tagline: *"Train Hard. Level Up. Ball Out."*
- CTA: "Let's Go" → Sign Up / Log In options
- Auth methods: Google, Apple, Email

### Screen 2 — Pick Your Position
- After auth, new users land here
- Header: *"What's your position?"*
- 5 large cards in a scroll row, each with:
  - Position abbreviation (PG, SG, SF, PF, C)
  - Full name (Point Guard, etc.)
  - Short description ("Floor general. The engine.")
  - Icon/silhouette illustration
- Single select, tap to highlight, Next button activates

### Screen 3 — Skill Level
- Header: *"Where are you at right now?"*
- 3 cards, full-width stacked:
  - **Rookie** — "Just getting started. Let's build the foundation."
  - **Varsity** — "I know the basics. Time to level up."
  - **Elite** — "I go hard. Give me the tough stuff."
- Single select

### Screen 4 — Profile Setup
- Display name input
- Username input (@ handle, validated unique)
- Optional: city
- Optional: profile photo (camera or gallery)
- Skip option available
- "Let's Ball" button → navigates to Home

---

## Tab 1 — Home

### Home Dashboard
**Purpose:** Daily motivation + quick access to training

**Top section — Player Card**
- Avatar + display name + @username
- Current level badge + XP progress bar to next level
- Today's streak flame icon + day count

**Middle section — Today's Workout**
- Card: recommended workout plan for today based on position/level
- Shows: workout title, estimated duration, XP reward, number of drills
- CTA: "Start Workout" button
- If none assigned: "Build Your Own" shortcut

**Section — Weekly Challenge**
- Highlighted card with countdown timer
- Challenge title, metric, current rank (if entered)
- CTA: "Join Challenge" or "View Leaderboard"

**Section — Community Highlights**
- Horizontal scroll of 3–4 recent community posts
- Tap → opens Community tab at that post

**Section — Keep Going (Streak)**
- If streak > 0: "🔥 X day streak! Don't break it."
- If no activity today: "Log a workout to keep your streak alive"

---

## Tab 2 — Train

### Training Home
- **My Plan** tab | **Drill Library** tab (top tab switcher)

#### My Plan Tab
- Active plan card (title, week X of Y, progress bar)
- Today's session breakdown: list of drills with checkboxes
- Completed sessions shown with green checkmarks
- "No Plan?" → browse plans CTA

#### Drill Library Tab
- Search bar at top
- Filter chips: All | Ball Handling | Shooting | Defense | Athleticism | IQ
- Grid of drill cards (2 columns):
  - Thumbnail + title + duration + XP reward + skill level dot

### Screen — Browse Plans
- Filter by: Position, Duration (weeks), Level
- Plan cards in list: title, target position, weeks, XP total, thumbnail
- Tap → Plan Detail

### Screen — Plan Detail
- Hero image/banner
- Title, description, position tag, level badge
- Week-by-week breakdown accordion
- "Start This Plan" button
- Reviews/ratings from community (optional v1.1)

### Screen — Active Workout
- Progress header: "Drill 2 of 5"
- Current drill card:
  - Video player (looping demo)
  - Drill title + coaching tip
  - Sets/reps display OR countdown timer
- Controls: Start Timer | Log Set | Skip
- Bottom: Previous | Next buttons
- Completion screen → XP animation, mood selector, share option

### Screen — Drill Detail
- Full video player
- Title, category badge, skill level
- Description
- Coaching points (bullet list)
- Equipment needed
- XP reward
- "Add to Workout" | "Mark Complete" buttons

---

## Tab 3 — Achievements

### Achievements Home
- **Top row:** XP total, Level badge, Streak days — horizontal stat cards
- **Section — Badges**
  - Filter tabs: All | Training | Streak | Community | Challenge | Milestone
  - Grid of badge cards (3 columns)
  - Earned: full color + earned date
  - Locked: greyed out with lock icon + unlock condition shown on tap
- **Section — Personal Records**
  - List of tracked metrics:
    - Most drills in a day
    - Longest streak
    - Fastest completion time (timed drills)
    - Most XP in a week
  - Each shows current PR + date achieved

### Screen — Badge Detail (modal)
- Badge image (large, animated if Legend rarity)
- Name + rarity chip
- Description + unlock condition
- XP it rewarded
- Date earned (or "Not yet earned")
- Share button (generates shareable graphic)

---

## Tab 4 — Community

### Feed Home
- Stories row at top (team highlights, challenge clips)
- Infinite scroll feed:
  - Post card: avatar + username + time ago
  - Content text
  - Media (image or video, autoplay muted)
  - Like button (with count) | Comment button | Share button
- FAB: Create Post

### Screen — Create Post
- Text input (280 char limit)
- Attach media: photo or video (max 60s)
- Tag selection: sport category tags
- Link to challenge (optional)
- Post button

### Screen — Post Detail
- Full post at top
- Comments list below
- Comment input at bottom (sticky)
- Like/comment/share actions

### Screen — Clip Player (full screen)
- Vertical swipe-based (TikTok-style for video posts)
- Overlay: username, drill tag, like/comment/share on right side
- Back swipe to return to feed

### Screen — Leaderboard (Weekly Challenge)
- Challenge banner at top
- Countdown timer
- Top 10 list with rank, avatar, username, value
- Your rank card (pinned at bottom if not in top 10)
- Submit Entry button

### Screen — Team Page
- Team banner + avatar + name
- Member count + city
- Member grid (avatars)
- Team feed (posts from members)
- Invite via code button
- Captain controls (manage members, edit info)

---

## Tab 5 — Profile

### My Profile
- Cover photo + avatar
- Display name, @username, city
- Bio text
- Position badge + Level badge
- Stats row: Workouts | Drills | Streak
- Showcased badges (up to 3, user-selected)
- Social links row (Instagram, TikTok, X icons)
- Recent activity feed (workout logs, achievements)
- Edit Profile button

### Screen — Edit Profile
- Avatar picker (camera/gallery)
- Cover photo picker
- Display name, username, bio, city fields
- Position selector
- Social links inputs
- Save Changes button

### Screen — Other User Profile
- Same as My Profile but:
  - Follow / Unfollow button instead of Edit
  - Message button (v1.1)
  - No edit access

### Screen — Settings
- Account (email, password, linked accounts)
- Notifications (toggle per type)
- Privacy (public/private account)
- Sport settings (position, skill level)
- About / Terms / Privacy Policy
- Log Out
- Delete Account

---

## Global / Overlay Screens

### XP Gain Animation (overlay)
- Triggered on: drill complete, badge earned, challenge submission
- Full-screen brief overlay: "+150 XP" with particle animation
- Auto-dismisses after 1.5s

### Badge Earned Modal
- Triggered when a badge unlocks
- Badge image zooms in with glow effect
- Badge name + rarity
- "Share" and "Done" buttons

### Streak Milestone Modal
- Triggered at 3, 7, 14, 30, 60, 100 day streaks
- Animated fire + streak count
- Badge if milestone has one

### Notification Center (slide-in from top or dedicated screen)
- List of all notifications
- Grouped by: Today, This Week, Earlier
- Tap to navigate to referenced content
- Mark all read button
