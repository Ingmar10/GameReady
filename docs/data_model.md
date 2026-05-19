# Firestore Data Model

## Collections Overview

```
users/
drills/
workoutPlans/
workoutLogs/
achievements/
userAchievements/
posts/
comments/
teams/
challenges/
challengeEntries/
notifications/
```

---

## `users/{userId}`

```
{
  uid: string,                    // Firebase Auth UID
  username: string,               // @handle, unique
  displayName: string,
  avatarUrl: string,              // Firebase Storage URL
  bio: string,
  position: enum[PG, SG, SF, PF, C],
  skillLevel: enum[Rookie, Varsity, Elite],
  sport: string,                  // "basketball" for v1
  age: number,
  city: string,
  xp: number,
  level: number,                  // computed from xp
  streakDays: number,
  lastActiveDate: timestamp,
  following: string[],            // userId array
  followers: string[],            // userId array
  teamId: string | null,
  socials: {
    instagram: string,
    tiktok: string,
    twitter: string
  },
  stats: {
    totalDrillsCompleted: number,
    totalWorkoutsCompleted: number,
    totalMinutesTrained: number,
    personalRecords: map           // drillId -> best value
  },
  createdAt: timestamp,
  updatedAt: timestamp
}
```

---

## `drills/{drillId}`

```
{
  title: string,
  description: string,
  category: enum[BallHandling, Shooting, Defense, Athleticism, IQ],
  targetPositions: string[],      // [PG, SG, ...] or ["all"]
  skillLevel: enum[Rookie, Varsity, Elite],
  duration: number,               // seconds
  sets: number | null,
  reps: number | null,
  mediaUrl: string,               // video or GIF in Storage
  thumbnailUrl: string,
  coachingPoints: string[],       // bullet tips shown during drill
  xpReward: number,
  equipment: string[],            // ["none"] | ["cones", "ball", ...]
  tags: string[],
  createdAt: timestamp
}
```

---

## `workoutPlans/{planId}`

```
{
  title: string,
  description: string,
  targetPosition: string,         // or "all"
  skillLevel: string,
  durationWeeks: number,
  daysPerWeek: number,
  weeks: [
    {
      weekNumber: number,
      days: [
        {
          dayNumber: number,
          label: string,           // "Day 1 - Ball Handling Focus"
          drills: [
            {
              drillId: string,
              order: number,
              sets: number,
              reps: number | null,
              duration: number | null
            }
          ]
        }
      ]
    }
  ],
  totalXpReward: number,
  thumbnailUrl: string,
  createdAt: timestamp
}
```

---

## `workoutLogs/{logId}`

```
{
  userId: string,
  planId: string | null,          // null if free-form
  drillsCompleted: [
    {
      drillId: string,
      completedAt: timestamp,
      duration: number,           // actual seconds
      setsCompleted: number,
      notes: string
    }
  ],
  totalDuration: number,          // seconds
  xpEarned: number,
  date: timestamp,
  mood: enum[Fire, Solid, Okay],  // post-workout emoji rating
  createdAt: timestamp
}
```

---

## `achievements/{achievementId}`

```
{
  title: string,
  description: string,
  badgeImageUrl: string,
  category: enum[Training, Streak, Community, Challenge, Milestone],
  xpReward: number,
  condition: {
    type: enum[drillCount, workoutCount, streakDays, postCount, followCount, challengeWin, xpTotal],
    threshold: number
  },
  rarity: enum[Common, Rare, Epic, Legend],
  createdAt: timestamp
}
```

---

## `userAchievements/{userId}/earned/{achievementId}`

```
{
  achievementId: string,
  earnedAt: timestamp,
  showcased: boolean              // pinned to profile card
}
```

---

## `posts/{postId}`

```
{
  authorId: string,
  authorUsername: string,
  authorAvatarUrl: string,
  content: string,
  mediaUrl: string | null,        // image or short video
  mediaType: enum[none, image, video] | null,
  tags: string[],                 // ["shooting", "ballhandling"]
  likeCount: number,
  commentCount: number,
  likedBy: string[],              // userId array (cap at 500, then subcollection)
  teamId: string | null,
  challengeId: string | null,     // links post to a challenge entry
  createdAt: timestamp
}
```

---

## `posts/{postId}/comments/{commentId}`

```
{
  authorId: string,
  authorUsername: string,
  authorAvatarUrl: string,
  content: string,
  likeCount: number,
  likedBy: string[],
  createdAt: timestamp
}
```

---

## `teams/{teamId}`

```
{
  name: string,
  description: string,
  avatarUrl: string,
  bannerUrl: string,
  captainId: string,              // userId
  members: string[],             // userId array
  memberCount: number,
  city: string,
  isPublic: boolean,
  inviteCode: string,             // 6-char code for joining
  totalTeamXp: number,
  createdAt: timestamp
}
```

---

## `challenges/{challengeId}`

```
{
  title: string,
  description: string,
  drillId: string | null,         // linked drill, or open-ended
  metric: enum[count, duration, score, video],
  startDate: timestamp,
  endDate: timestamp,
  xpReward: number,
  badgeId: string | null,         // badge awarded to top performers
  scope: enum[global, team],
  teamId: string | null,
  entryCount: number,
  createdAt: timestamp
}
```

---

## `challengeEntries/{entryId}`

```
{
  challengeId: string,
  userId: string,
  username: string,
  avatarUrl: string,
  value: number,                  // score/count/seconds
  mediaUrl: string | null,        // clip submission
  rank: number | null,            // computed after challenge ends
  xpAwarded: number,
  submittedAt: timestamp
}
```

---

## `notifications/{userId}/items/{notifId}`

```
{
  type: enum[like, comment, follow, badge, challenge, teamInvite, streak],
  fromUserId: string | null,
  fromUsername: string | null,
  fromAvatarUrl: string | null,
  referenceId: string | null,     // postId, challengeId, etc.
  message: string,
  isRead: boolean,
  createdAt: timestamp
}
```

---

## XP & Level Thresholds

| Level | Name | XP Required |
|---|---|---|
| 1 | Rookie | 0 |
| 5 | Baller | 1,000 |
| 10 | Varsity | 3,500 |
| 15 | All-Star | 8,000 |
| 20 | Elite | 15,000 |
| 25 | Legend | 25,000 |

---

## Firestore Security Rules (Summary)

- Users can only write their own `users/` document
- `drills/` and `workoutPlans/` are read-only for all auth'd users
- `posts/` writable by author only; readable by all auth'd users
- `teams/` writable by captain; members can read
- `notifications/` readable/writable by the owning userId only
- All reads require `request.auth != null`
