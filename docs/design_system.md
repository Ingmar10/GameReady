# Design System — GameReady

## Brand Identity

**Vibe:** Pro-level aesthetics meets street basketball energy. Dark, premium, fast. Feels like a game, not a fitness app.

**References:** Nike Training Club UI + NBA 2K player card aesthetic + TikTok feed mechanics

---

## Color Palette

### Base (Dark Mode First)

| Name | Hex | Usage |
|---|---|---|
| `background` | `#0A0A0F` | App background |
| `surface` | `#13131A` | Cards, bottom sheets |
| `surfaceElevated` | `#1C1C28` | Modals, elevated cards |
| `border` | `#2A2A3A` | Card borders, dividers |

### Brand Accent

| Name | Hex | Usage |
|---|---|---|
| `orange` | `#FF6B1A` | Primary CTA, XP bar, streak |
| `orangeGlow` | `#FF6B1A33` | Glow effects, shadow |
| `electricBlue` | `#3D9EFF` | Secondary actions, links |
| `neonGreen` | `#00E676` | Success, completed states |
| `purple` | `#8B5CF6` | Epic/Legend rarity badges |

### Text

| Name | Hex | Usage |
|---|---|---|
| `textPrimary` | `#FFFFFF` | Headlines, primary body |
| `textSecondary` | `#A0A0B8` | Subtitles, metadata |
| `textMuted` | `#4A4A62` | Disabled, placeholder |

### Status

| Name | Hex |
|---|---|
| `success` | `#00E676` |
| `warning` | `#FFB300` |
| `error` | `#FF3D57` |

### Rarity Colors

| Rarity | Color |
|---|---|
| Common | `#A0A0B8` |
| Rare | `#3D9EFF` |
| Epic | `#8B5CF6` |
| Legend | `#FFB300` (gold glow) |

---

## Typography

**Primary Font:** `Inter` (clean, modern, legible at small sizes)
**Display Font:** `Barlow Condensed` (bold headers, stat numbers, level displays)

### Scale

| Token | Font | Size | Weight | Usage |
|---|---|---|---|---|
| `displayXL` | Barlow Condensed | 48px | 800 | Level number, XP total |
| `displayL` | Barlow Condensed | 36px | 700 | Screen heroes, XP gain |
| `displayM` | Barlow Condensed | 28px | 700 | Section headers |
| `headingL` | Inter | 22px | 700 | Card titles |
| `headingM` | Inter | 18px | 600 | Sub-headers |
| `headingS` | Inter | 16px | 600 | Labels, tabs |
| `bodyL` | Inter | 16px | 400 | Body copy |
| `bodyM` | Inter | 14px | 400 | Card body, descriptions |
| `bodyS` | Inter | 12px | 400 | Captions, metadata |
| `labelM` | Inter | 13px | 500 | Chips, badges |

---

## Spacing System

Base unit: **4px**

| Token | Value |
|---|---|
| `xs` | 4px |
| `sm` | 8px |
| `md` | 16px |
| `lg` | 24px |
| `xl` | 32px |
| `2xl` | 48px |
| `3xl` | 64px |

**Card padding:** 16px
**Screen horizontal padding:** 20px
**Bottom nav height:** 72px (with safe area)

---

## Border Radius

| Token | Value | Usage |
|---|---|---|
| `none` | 0 | Full-bleed images |
| `sm` | 8px | Chips, small badges |
| `md` | 12px | Standard cards |
| `lg` | 16px | Large cards, modals |
| `xl` | 24px | Hero cards, featured |
| `full` | 999px | Pills, avatars, circular |

---

## Component Specs

### Cards

**Standard Card**
- Background: `surface` (#13131A)
- Border: 1px `border` (#2A2A3A)
- Border radius: `md` (12px)
- Padding: 16px
- Shadow: none (border defines separation in dark mode)

**Featured Card (e.g. Today's Workout)**
- Background: gradient — `#1C1C28` to `#0F0F1A`
- Border: 1px `orange` with 40% opacity
- Left accent bar: 4px wide `orange`
- Border radius: `lg` (16px)

**Drill Card (grid)**
- Thumbnail: 16:9 ratio with overlay gradient
- Title: `headingS` white
- Meta row: duration chip + XP chip
- Skill dot: colored circle (green=Rookie, blue=Varsity, orange=Elite)

### Buttons

**Primary Button**
- Background: `orange` (#FF6B1A)
- Text: white, `headingS`, uppercase
- Height: 52px
- Border radius: `md` (12px)
- Pressed state: brightness 80%
- Disabled: `border` background, `textMuted` text

**Secondary Button**
- Background: transparent
- Border: 1.5px `orange`
- Text: `orange`, `headingS`
- Same sizing as primary

**Ghost Button**
- Background: `surfaceElevated`
- Text: `textSecondary`
- No border

**Icon Button**
- 44x44px tap target
- 24px icon
- Background: `surfaceElevated` circle

### XP Progress Bar
- Track: `border` (#2A2A3A), height 8px, full radius
- Fill: gradient `#FF6B1A` → `#FFB300`
- Glow effect: 0px 0px 8px `orangeGlow`
- Animated fill on load (ease-out, 600ms)

### Badges
- Circle shape (64px profile, 80px achievement page, 120px badge detail)
- Common: grey tint
- Rare: blue glow border
- Epic: purple glow border
- Legend: gold gradient + animated pulse glow

### Streak Flame
- SF Symbol or custom SVG flame icon
- Color: `orange` to `#FFB300` gradient
- Counter: `displayM` Barlow Condensed
- Pulse animation when active

### Level Badge
- Pill shape, uppercase text
- Background: level-color gradient
- Levels 1-5: grey, 6-10: blue, 11-15: purple, 16-20: orange, 21-25: gold
- Shown next to username everywhere

### Chips / Tags
- Height: 28px
- Padding: 8px 12px
- Border radius: `full`
- Selected: `orange` bg, white text
- Unselected: `surfaceElevated` bg, `textSecondary` text
- Font: `labelM`

---

## Iconography

Use **Phosphor Icons** (available in FlutterFlow) — they're sharp, modern, and have consistent weight options.

Key icons:
- Home: `house-fill`
- Train: `barbell-fill`
- Achievements: `trophy-fill`
- Community: `users-three-fill`
- Profile: `user-circle-fill`
- Streak: `fire-fill`
- XP: `lightning-fill`
- Like: `heart-fill` / `heart`
- Comment: `chat-circle`
- Share: `share-network`

---

## Animation Guidelines

**Principle:** Fast in, slow out. Celebrate achievements hard. Keep navigation snappy.

| Interaction | Animation | Duration |
|---|---|---|
| Screen transition | Slide up (modal), Fade (tab switch) | 200ms |
| XP bar fill | Ease-out width animation | 600ms |
| Badge unlock | Scale + fade + glow pulse | 800ms |
| XP gain overlay | Scale in + float up + fade | 1500ms total |
| Streak milestone | Bounce + shake + particle burst | 1000ms |
| Card press | Scale down to 0.97 | 100ms |
| Like button tap | Quick scale 1.0 → 1.3 → 1.0 | 300ms |
| Skeleton loader | Shimmer sweep left-to-right | Loop 1200ms |

---

## Gradient Recipes

**App hero gradient (background overlay):**
```
LinearGradient(
  begin: top-center,
  end: bottom-center,
  colors: [transparent, #0A0A0F]
)
```

**Orange brand gradient:**
```
LinearGradient(
  colors: [#FF6B1A, #FFB300],
  angle: 135°
)
```

**Court texture overlay (subtle):**
```
Semi-transparent basketball court line pattern at 5% opacity
```

**Card glow (featured items):**
```
BoxShadow: 0 0 20px #FF6B1A22, 0 4px 24px #00000066
```
