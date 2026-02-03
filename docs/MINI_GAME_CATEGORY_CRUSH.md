# Category Crush: Block Match Arena - Mini-Game Spec

## Overview

| Property | Value |
|----------|-------|
| Game Name | Category Crush: Block Match Arena |
| Platform | Roblox |
| Genre | 3D Tetris-style Puzzle |
| Target Age | 6-12 years |
| Educational Focus | Food Groups, Emotions, Wellness, Coping Skills |

A 3D Tetris-style puzzle game where players match falling blocks by category.

---

## Core Mechanic

- 3D blocks fall from the sky into a vertical arena
- Each block represents an item from a category (displayed as emoji + text)
- Player moves blocks left/right and can speed up falling
- When **4+ blocks of the same category** align in a row or column, they burst and clear
- **Goal:** Clear the required number of items before the arena fills up

---

## Content Packs

### Pack 1: Food Groups 🍽️

| Category | Color | Items |
|----------|-------|-------|
| Proteins | Red | 🍗 Chicken, 🥩 Steak, 🐟 Fish, 🥚 Eggs, 🫘 Beans |
| Grains | Gold | 🍞 Bread, 🍚 Rice, 🥣 Oatmeal, 🌾 Wheat, 🥯 Bagel |
| Vegetables | Green | 🥦 Broccoli, 🥕 Carrot, 🥬 Spinach, 🌽 Corn, 🥒 Cucumber |
| Fruits | Orange | 🍎 Apple, 🍌 Banana, 🍇 Grapes, 🍊 Orange, 🫐 Berries |
| Dairy | White | 🥛 Milk, 🧀 Cheese, 🍦 Yogurt, 🧈 Butter, 🥛 Cream |

**Health Nuggets:**
- Proteins: "Proteins build strong muscles!"
- Grains: "Whole grains give lasting energy!"
- Vegetables: "Veggies are packed with vitamins!"
- Fruits: "Fruits have natural sweetness and fiber!"
- Dairy: "Dairy builds strong bones!"

### Pack 2: Emotions 😊

| Category | Color | Items |
|----------|-------|-------|
| Happy | Yellow | 😊 Joyful, 😄 Excited, 🥰 Loved, 😌 Content, 🤗 Grateful |
| Sad | Blue | 😢 Tearful, 😞 Disappointed, 💔 Heartbroken, 😔 Down, 🥺 Hurt |
| Angry | Red | 😠 Frustrated, 😤 Annoyed, 🤬 Furious, 😡 Mad, 💢 Irritated |
| Scared | Purple | 😨 Anxious, 😰 Worried, 😱 Terrified, 🫣 Nervous, 😬 Tense |
| Calm | Teal | 😌 Peaceful, 🧘 Relaxed, 😊 Serene, 💆 Soothed, 🌸 Gentle |

**Health Nuggets:**
- Happy: "It's okay to feel happy - share your joy!"
- Sad: "Sadness is normal - it's okay to cry!"
- Angry: "Anger is a signal - pause and breathe!"
- Scared: "Fear keeps us safe - talk about worries!"
- Calm: "Calm is a superpower you can practice!"

### Pack 3: Wellness 💪

| Category | Color | Items |
|----------|-------|-------|
| Exercise | Orange | 🏃 Running, 🚴 Biking, 🏊 Swimming, ⚽ Sports, 🧘 Yoga |
| Sleep | Purple | 🌙 Bedtime, 😴 Rest, 🛏️ Napping, ⭐ Dreams, 🌛 Night |
| Hygiene | Cyan | 🪥 Brushing, 🧼 Washing, 🚿 Showering, 🧴 Lotion, 💅 Grooming |
| Hydration | Blue | 💧 Water, 🥤 Drinks, 🍵 Tea, 🥛 Milk, 🧊 Ice Water |
| Relaxation | Pink | 📚 Reading, 🎵 Music, 🎨 Art, 🌿 Nature, 🧩 Games |

**Health Nuggets:**
- Exercise: "Moving your body makes you stronger!"
- Sleep: "Sleep helps your brain grow and learn!"
- Hygiene: "Clean habits keep germs away!"
- Hydration: "Water powers every cell in your body!"
- Relaxation: "Rest time recharges your mind!"

### Pack 4: Coping Skills 🌈

| Category | Color | Items |
|----------|-------|-------|
| Breathing | Light Blue | 🌬️ Deep Breath, 🎈 Balloon Breath, 🌊 Ocean Breath, ⭐ Star Breath, 🦋 Butterfly |
| Movement | Green | 🚶 Walking, 💃 Dancing, 🤸 Stretching, 🏃 Running, 🧘 Yoga |
| Creative | Yellow | 🎨 Drawing, ✍️ Writing, 🎵 Singing, 🎭 Acting, 📸 Photos |
| Social | Pink | 🤗 Hugging, 💬 Talking, 👋 Waving, 🤝 Helping, 💝 Sharing |
| Mindful | Purple | 🧘 Meditating, 👀 Noticing, 👂 Listening, 🌸 Grounding, 🙏 Gratitude |

**Health Nuggets:**
- Breathing: "Deep breaths calm your nervous system!"
- Movement: "Moving releases feel-good chemicals!"
- Creative: "Creating expresses what words can't!"
- Social: "Connection with others heals the heart!"
- Mindful: "Being present reduces worry!"

---

## Level Progression (20 Levels Per Pack)

| Level | Columns | Rows | Items Goal | Fall Speed | Categories | Special |
|-------|---------|------|------------|------------|------------|---------|
| 1 | 4 | 8 | 16 | 1200ms | 4 | - |
| 2 | 4 | 8 | 20 | 1100ms | 4 | - |
| 3 | 4 | 8 | 24 | 1050ms | 4 | - |
| 4 | 4 | 8 | 28 | 1000ms | 4 | - |
| 5 | 4 | 8 | 32 | 950ms | 4 | - |
| 6 | 4 | 9 | 36 | 900ms | 5 | 5th category |
| 7 | 4 | 9 | 40 | 850ms | 5 | - |
| 8 | 4 | 9 | 44 | 800ms | 5 | - |
| 9 | 4 | 9 | 48 | 750ms | 5 | - |
| 10 | 4 | 9 | 52 | 700ms | 5 | - |
| 11 | 4 | 10 | 56 | 650ms | 5 | Taller arena |
| 12 | 4 | 10 | 60 | 600ms | 5 | - |
| 13 | 4 | 10 | 64 | 550ms | 5 | - |
| 14 | 4 | 10 | 68 | 500ms | 5 | - |
| 15 | 4 | 10 | 72 | 450ms | 5 | - |
| 16 | 4 | 10 | 76 | 420ms | 5 | 💥 Distractors! |
| 17 | 4 | 10 | 80 | 400ms | 5 | 💥 Distractors |
| 18 | 4 | 10 | 84 | 380ms | 5 | 💥 Distractors |
| 19 | 4 | 10 | 88 | 360ms | 5 | 💥 Distractors |
| 20 | 4 | 10 | 92 | 350ms | 5 | 💥 Distractors |

---

## Distractor Blocks (Levels 16-20)

### Mechanic

- 💥 Bomb blocks appear every 4-5 regular blocks
- They have a visible countdown timer (15-20 seconds)
- Timer shown as shrinking ring around block
- When timer expires: **EXPLOSION!**
  - Destroys 2 blocks above and below
  - Screen shake effect
  - Lose 50 points

### Clearing Distractors

- Cannot be matched with categories
- Disappear when adjacent category blocks are cleared
- **Strategy:** Clear blocks next to bombs before they explode

---

## 3D Arena Design

```
        ╔═══════════════════════════════════╗
        ║         BLOCK SPAWN ZONE          ║  ← Blocks materialize here
        ╠═══════════════════════════════════╣
        ║                                   ║
        ║   ┌───┐ ┌───┐ ┌───┐ ┌───┐       ║
        ║   │   │ │   │ │   │ │   │       ║  ← 4 columns
        ║   └───┘ └───┘ └───┘ └───┘       ║
        ║   ┌───┐ ┌───┐ ┌───┐ ┌───┐       ║
        ║   │🍗│ │🥦│ │🍎│ │🧀│       ║  ← Falling blocks
        ║   └───┘ └───┘ └───┘ └───┘       ║
        ║   ┌───┐ ┌───┐ ┌───┐ ┌───┐       ║
        ║   │🥕│ │🍗│ │🍗│ │🍗│       ║  ← Match forming!
        ║   └───┘ └───┘ └───┘ └───┘       ║
        ║   ┌───┐ ┌───┐ ┌───┐ ┌───┐       ║
        ║   │🍌│ │🍞│ │🥛│ │🍎│       ║
        ║   └───┘ └───┘ └───┘ └───┘       ║
        ╠═══════════════════════════════════╣
        ║         DANGER ZONE               ║  ← Game over if blocks reach here
        ╚═══════════════════════════════════╝
```

---

## Controls

### Desktop

| Key | Action |
|-----|--------|
| A / Left Arrow | Move block left |
| D / Right Arrow | Move block right |
| S / Down Arrow | Speed up fall |
| Space | Instant drop |

### Mobile

| Touch | Action |
|-------|--------|
| Swipe Left | Move block left |
| Swipe Right | Move block right |
| Swipe Down | Speed up fall |
| Tap | Instant drop |

---

## Scoring System

### Points

| Action | Points |
|--------|--------|
| Block placed | 0 |
| 4-match cleared | 100 (25 × 4) |
| 5-match cleared | 150 (30 × 5) |
| 6+ match cleared | 40 × blocks |
| Chain reaction | 1.5× multiplier per chain |
| Level complete | 200 bonus |
| Distractor explodes | -50 |

### XP Rewards

| Achievement | XP |
|-------------|-----|
| Complete level | 15 XP |
| Complete pack (20 levels) | 100 XP bonus |
| Perfect level (no overflow) | 25 XP |

### Combo System

```lua
local comboMultiplier = 1.0
local comboTimer = 0

function onMatchCleared(matchCount)
    comboMultiplier = comboMultiplier + 0.1
    comboTimer = 3.0 -- Reset combo timer

    local points = matchCount * 25 * comboMultiplier
    addScore(points)

    showComboText("Combo x" .. string.format("%.1f", comboMultiplier))
end
```

---

## UI Layout

### Game Screen

```
┌─────────────────────────────────────────────────┐
│  [←]  CATEGORY CRUSH: Food Groups    Level 5    │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────┐                    ┌───────────┐  │
│  │ SCORE    │                    │ PROGRESS  │  │
│  │  2,450   │                    │ 18/32     │  │
│  └──────────┘                    │ ████████░ │  │
│                                  └───────────┘  │
│                                                 │
│           ┌─────────────────────┐               │
│           │                     │               │
│           │    [GAME ARENA]     │               │
│           │                     │               │
│           │    Falling blocks   │               │
│           │    with emojis      │               │
│           │                     │               │
│           └─────────────────────┘               │
│                                                 │
│  ┌─────────────────────────────────────────┐    │
│  │ NEXT: 🍗 Chicken (Proteins)              │    │
│  └─────────────────────────────────────────┘    │
│                                                 │
│       [◄ LEFT]    [▼ DROP]    [RIGHT ►]         │
└─────────────────────────────────────────────────┘
```

### Level Complete Screen

```
┌─────────────────────────────────────────────────┐
│              ⭐ LEVEL COMPLETE! ⭐              │
├─────────────────────────────────────────────────┤
│                                                 │
│               🎉 Great Job! 🎉                   │
│                                                 │
│            Final Score: 3,250                   │
│            Items Cleared: 32/32                 │
│            Best Combo: x2.4                     │
│                                                 │
│  ┌─────────────────────────────────────────┐    │
│  │  💡 Did you know?                        │    │
│  │                                         │    │
│  │  "Proteins build strong muscles and     │    │
│  │   help your body repair itself!"        │    │
│  └─────────────────────────────────────────┘    │
│                                                 │
│            + 15 XP Earned!                      │
│                                                 │
│     [NEXT LEVEL]        [PACK SELECT]           │
└─────────────────────────────────────────────────┘
```

---

## Pack Completion Rewards

### Sticker System

| Pack | Sticker | Description |
|------|---------|-------------|
| Food Groups | 🏆 Nutrition Master | Gold trophy with fruits |
| Emotions | 💖 Feelings Expert | Heart with emotion faces |
| Wellness | ⭐ Wellness Champion | Star with health symbols |
| Coping Skills | 🌈 Coping Pro | Rainbow with calm clouds |

---

## Category Color Coding

```lua
local CATEGORY_COLORS = {
    -- Food Groups
    Proteins = Color3.fromRGB(220, 80, 80),    -- Red
    Grains = Color3.fromRGB(255, 200, 50),     -- Gold
    Vegetables = Color3.fromRGB(80, 180, 80),  -- Green
    Fruits = Color3.fromRGB(255, 150, 50),     -- Orange
    Dairy = Color3.fromRGB(240, 240, 255),     -- White

    -- Emotions
    Happy = Color3.fromRGB(255, 220, 50),      -- Yellow
    Sad = Color3.fromRGB(100, 150, 220),       -- Blue
    Angry = Color3.fromRGB(220, 60, 60),       -- Red
    Scared = Color3.fromRGB(180, 100, 200),    -- Purple
    Calm = Color3.fromRGB(80, 200, 180),       -- Teal

    -- Wellness
    Exercise = Color3.fromRGB(255, 140, 50),   -- Orange
    Sleep = Color3.fromRGB(140, 100, 180),     -- Purple
    Hygiene = Color3.fromRGB(80, 200, 220),    -- Cyan
    Hydration = Color3.fromRGB(80, 150, 220),  -- Blue
    Relaxation = Color3.fromRGB(255, 150, 180),-- Pink

    -- Coping Skills
    Breathing = Color3.fromRGB(150, 200, 255), -- Light Blue
    Movement = Color3.fromRGB(100, 200, 100),  -- Green
    Creative = Color3.fromRGB(255, 220, 80),   -- Yellow
    Social = Color3.fromRGB(255, 150, 180),    -- Pink
    Mindful = Color3.fromRGB(180, 120, 200),   -- Purple
}
```

---

## Match Detection Algorithm

```lua
function checkForMatches()
    local matches = {}

    -- Check horizontal matches (4 in a row)
    for row = 1, ROWS do
        local streak = 1
        local currentCategory = nil
        for col = 1, COLS do
            local block = grid[row][col]
            if block and block.category == currentCategory then
                streak = streak + 1
            else
                if streak >= 4 then
                    for i = col - streak, col - 1 do
                        table.insert(matches, {row = row, col = i})
                    end
                end
                streak = 1
                currentCategory = block and block.category
            end
        end
        if streak >= 4 then
            for i = COLS - streak + 1, COLS do
                table.insert(matches, {row = row, col = i})
            end
        end
    end

    -- Check vertical matches (4 in a column)
    for col = 1, COLS do
        local streak = 1
        local currentCategory = nil
        for row = 1, ROWS do
            local block = grid[row][col]
            if block and block.category == currentCategory then
                streak = streak + 1
            else
                if streak >= 4 then
                    for i = row - streak, row - 1 do
                        table.insert(matches, {row = i, col = col})
                    end
                end
                streak = 1
                currentCategory = block and block.category
            end
        end
        if streak >= 4 then
            for i = ROWS - streak + 1, ROWS do
                table.insert(matches, {row = i, col = col})
            end
        end
    end

    return matches
end
```

---

## Audio Design

| Event | Sound Description |
|-------|-------------------|
| Block placed | Soft "thunk" |
| Block moving | Quick "swoosh" |
| 4-match | Cheerful "ding-ding" |
| 5+ match | Ascending chime |
| Chain x2 | "Excellent!" voice |
| Chain x3+ | "Amazing!" voice |
| Bomb tick | Ticking clock (speeds up) |
| Bomb explode | "Boom" with rumble |
| Level complete | Victory fanfare |
| Game over | Gentle "aww" tone |

---

## Accessibility Options

- **Color-blind mode:** Adds pattern/symbol to blocks
- **Reduced motion:** Disables particle effects
- **Larger text:** Scales UI 1.5x
- **Audio cues:** Distinct sounds per category

### Color-Blind Block Patterns

```lua
local CATEGORY_PATTERNS = {
    Proteins = "●●●",     -- Dots
    Grains = "═══",       -- Lines
    Vegetables = "◆◆◆",   -- Diamonds
    Fruits = "★★★",       -- Stars
    Dairy = "○○○",        -- Circles
}
```

---

## File Structure (Roblox)

```
ServerScriptService/
├── CategoryCrushServer.lua
│   ├── PlayerDataManager
│   ├── LeaderboardManager
│   └── RewardHandler

ReplicatedStorage/
├── CategoryCrushData/
│   ├── ContentPacks.lua
│   │   ├── FoodGroups
│   │   ├── Emotions
│   │   ├── Wellness
│   │   └── CopingSkills
│   ├── LevelConfig.lua
│   ├── HealthNuggets.lua
│   └── CategoryColors.lua
├── CategoryCrushRemotes/
│   ├── StartGame
│   ├── PlaceBlock
│   ├── MatchCleared
│   ├── LevelComplete
│   └── GameOver

StarterGui/
├── CategoryCrushUI/
│   ├── PackSelectScreen
│   ├── LevelSelectScreen
│   ├── GameHUD
│   │   ├── ScoreDisplay
│   │   ├── ProgressBar
│   │   ├── ComboText
│   │   └── NextBlockPreview
│   ├── ControlButtons
│   ├── LevelCompleteScreen
│   ├── GameOverScreen
│   └── StickerCollection

Workspace/
├── CategoryCrushArena/
│   ├── ArenaFrame
│   ├── SpawnZone
│   ├── DangerZone
│   ├── BlockContainer
│   └── EffectsContainer
```

---

## Educational Integration

### Learning Moments

- **During Gameplay:** Category colors reinforce grouping concepts
- **On Match:** Brief health nugget appears (2 seconds)
- **Level Complete:** Expanded fact with visual
- **Pack Complete:** Summary of all categories learned

---

## Implementation Priority

### Phase 1: Core Mechanics
- Arena structure and grid system
- Block falling and placement
- Basic movement controls
- Match detection algorithm
- Block clearing with gravity

### Phase 2: Content & Progression
- All 4 content packs with items
- 20 levels per pack with scaling
- Health nuggets system
- Score and XP tracking
- Pack unlocking

### Phase 3: Polish
- Visual effects (particles, tweens)
- Audio integration
- Distractor blocks for hard levels
- Combo system
- Sticker rewards

### Phase 4: UI & Quality
- All UI screens
- Mobile controls optimization
- Accessibility options
- Data persistence
- Performance optimization
