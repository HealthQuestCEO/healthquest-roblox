# Energy Dash: Canyon Run - Mini-Game Spec

## Overview

| Property | Value |
|----------|-------|
| Game Name | Energy Dash: Canyon Run |
| Platform | Roblox |
| Genre | 3D Obstacle Course Runner |
| Target Age | 6-12 years |
| Educational Focus | Nutrition, Healthy Habits, Physical Activity |

Transform the 2D lane-based Energy Dash Runner into an immersive 3D canyon obstacle course where players run, jump, and collect healthy foods while avoiding junk food obstacles.

---

## Core Concept

Players control Lumo (or their avatar) running through a vibrant canyon environment. The goal is to:

1. **Collect healthy foods** floating along the path (+points, +health facts)
2. **Avoid junk food obstacles** (lose energy/lives)
3. **Grab power-ups** for special abilities
4. **Reach the finish line** to unlock educational summary

---

## Game Flow

```
┌─────────────────────────────────────────────────────────────┐
│  START SCREEN                                                │
│  • Play Button                                               │
│  • Difficulty Selection (Chill / Energized / Turbo)         │
│  • High Score Display                                        │
│  • Daily XP Progress Bar                                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  PRE-RUN SCREEN (3 seconds)                                  │
│  • "Ready... Set... DASH!"                                   │
│  • Quick tip: "Collect fruits & veggies for energy!"        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  GAMEPLAY (Canyon Run)                                       │
│  • 3-lane canyon path                                        │
│  • Collectibles spawn ahead                                  │
│  • Obstacles to dodge                                        │
│  • Power-ups for abilities                                   │
│  • HUD: Lives, Score, Streak, Active Effects                │
└─────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────────┐
│  GAME OVER              │     │  FINISH LINE REACHED        │
│  (0 lives remaining)    │     │  (Completed the course)     │
└─────────────────────────┘     └─────────────────────────────┘
              │                               │
              └───────────────┬───────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  RESULTS & EDUCATION SCREEN                                  │
│  • Final Score & XP Earned                                   │
│  • Items Collected Summary                                   │
│  • 3 Random Health Facts from collected items               │
│  • "Did You Know?" educational popup                        │
│  • Play Again / Exit buttons                                │
└─────────────────────────────────────────────────────────────┘
```

---

## Environment Design

### Canyon Setting

```
SIDE VIEW (Cross-section):

    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
   ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
  ▓░  CANYON WALLS (red/orange rock)        ░▓
 ▓░                                          ░▓
▓░    [🥦]        [🍟]         [💧]          ░▓
▓░     │           │            │            ░▓
▓░═════╬═══════════╬════════════╬════════════░▓  ← 3 Lanes
▓░   Lane 1      Lane 2       Lane 3         ░▓
▓░     ▲                                     ░▓
▓░   LUMO                                    ░▓
 ▓░  (Player)                               ░▓
  ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
```

### Visual Zones (Course Sections)

| Section | Distance | Theme | Visual Elements |
|---------|----------|-------|-----------------|
| Zone 1: Sunrise Canyon | 0-25% | Morning Desert | Orange rocks, rising sun, cacti |
| Zone 2: River Rapids | 25-50% | Blue Stream | Water features, bridges, mist |
| Zone 3: Crystal Caves | 50-75% | Underground | Glowing crystals, stalactites |
| Zone 4: Summit Sprint | 75-100% | Mountain Peak | Snow, clouds, finish arch |

### Lane Configuration

```
TOP-DOWN VIEW:

    ┌─────────────────────────────────────────┐
    │  LANE 1 (Left)    │  LANE 2 (Center)   │  LANE 3 (Right)  │
    │                   │                     │                   │
    │    [Collectible]  │                     │   [Obstacle]      │
    │                   │    [Power-up]       │                   │
    │                   │                     │                   │
    │         ▲         │                     │                   │
    │       LUMO        │                     │                   │
    └─────────────────────────────────────────┘

    Lane Width: 8 studs each
    Total Path Width: 24 studs
    Wall Height: 20 studs (prevents leaving path)
```

---

## Player Controls

| Input | Action | Animation |
|-------|--------|-----------|
| A / Left Arrow / Swipe Left | Move to left lane | Strafe left |
| D / Right Arrow / Swipe Right | Move to right lane | Strafe right |
| Space / Tap / W | Jump | Jump animation |
| S / Swipe Down | Slide (duck under obstacles) | Slide animation |

### Character Stats

```lua
LumoStats = {
    maxLives = 3,           -- Starting energy hearts
    laneChangeSpeed = 0.15, -- Seconds to switch lanes
    jumpHeight = 8,         -- Studs
    jumpDuration = 0.6,     -- Seconds
    slideDuration = 0.5,    -- Seconds
    invincibilityTime = 1.5 -- Seconds after hit
}
```

### Visual Feedback

| State | Visual Effect |
|-------|---------------|
| Normal | Lumo runs with bounce animation |
| Collecting | Green sparkles + size pulse |
| Hit by Obstacle | Red flash + knockback wobble |
| Shield Active | Blue bubble surrounds Lumo |
| Speed Boost | Yellow trail behind Lumo |
| Low Health (1 life) | Lumo flashes red periodically |

---

## Collectibles (Healthy Foods)

| ID | Emoji | Name | Points | Health Fact |
|----|-------|------|--------|-------------|
| broccoli | 🥦 | Broccoli | 100 | "Vitamin C keeps you healthy!" |
| spinach | 🥬 | Spinach | 100 | "Iron gives you energy!" |
| carrot | 🥕 | Carrot | 100 | "Beta-carotene for healthy eyes!" |
| sweet_potato | 🍠 | Sweet Potato | 100 | "Vitamin A for super eyesight!" |
| avocado | 🥑 | Avocado | 100 | "Fiber keeps your tummy happy!" |
| berries | 🫐 | Berries | 100 | "Antioxidants protect your cells!" |
| apple | 🍎 | Apple | 100 | "Fiber helps your digestion!" |
| banana | 🍌 | Banana | 100 | "Potassium keeps muscles strong!" |
| steak | 🥩 | Steak | 100 | "Red meat is rich in iron and B12!" |
| chicken | 🍗 | Chicken | 100 | "Lean protein builds muscles!" |
| salmon | 🐟 | Salmon | 100 | "Omega-3s power your brain!" |
| eggs | 🥚 | Eggs | 100 | "Protein builds strong muscles!" |
| beans | 🫘 | Beans | 100 | "Plant protein and fiber combo!" |
| shrimp | 🦐 | Shrimp | 100 | "Low-calorie protein powerhouse!" |
| nuts | 🥜 | Nuts | 100 | "Healthy fats fuel your body!" |

### Collectible Behavior

```lua
CollectibleConfig = {
    floatHeight = 3,           -- Studs above ground
    bobAmplitude = 0.5,        -- Vertical bob range
    bobSpeed = 2,              -- Bob cycles per second
    rotationSpeed = 90,        -- Degrees per second
    collectRadius = 4,         -- Touch detection radius
    spawnAheadDistance = 100,  -- Studs ahead of player
    despawnBehindDistance = 20 -- Remove when this far behind
}
```

### Collection Effects

```
When player touches collectible:
1. Play "ding" sound (ascending tone)
2. Particle burst (green sparkles)
3. Food item flies toward score UI
4. +100 points text pops up
5. Streak counter increments
6. Health fact queued for end screen
```

---

## Obstacles (Junk Foods)

| ID | Emoji | Name | Obstacle Type | Avoidance |
|----|-------|------|---------------|-----------|
| candy | 🍬 | Candy | Ground (small) | Jump over or dodge |
| chocolate | 🍫 | Chocolate Bar | Ground (medium) | Jump over or dodge |
| fries | 🍟 | French Fries | Ground (tall) | Slide under or dodge |
| soda | 🥤 | Soda | Ground (tall) | Slide under or dodge |
| cookie | 🍪 | Cookie | Floating (low) | Slide under |
| donut | 🍩 | Donut | Floating (mid) | Jump through hole or dodge |
| icecream | 🍦 | Ice Cream | Ground (medium) | Jump over or dodge |
| cake | 🍰 | Cake | Ground (wide) | Must change lanes |

### Obstacle Configurations

```lua
ObstacleTypes = {
    GROUND_SMALL = {
        height = 2,
        width = 3,
        avoidance = {"jump", "lane_change"}
    },
    GROUND_MEDIUM = {
        height = 4,
        width = 4,
        avoidance = {"jump", "lane_change"}
    },
    GROUND_TALL = {
        height = 6,
        width = 3,
        avoidance = {"slide", "lane_change"}
    },
    FLOATING_LOW = {
        height = 3,
        floatHeight = 2,
        avoidance = {"slide", "lane_change"}
    },
    LANE_BLOCKER = {
        height = 8,
        width = 8,
        avoidance = {"lane_change"}  -- Must switch lanes
    }
}
```

### Collision Effects

```
When player hits obstacle:
1. Play "oof" sound
2. Screen shake (small)
3. Lumo knockback animation
4. Red vignette flash
5. -1 Life
6. 1.5 second invincibility
7. Random hit message: "Oof!", "Ouch!", "Yikes!"
```

---

## Power-Ups

| ID | Emoji | Name | Effect | Duration | Visual |
|----|-------|------|--------|----------|--------|
| water | 💧 | Water | Speed Boost (1.25x) | 3 sec | Yellow speed lines |
| exercise | 👟 | Exercise | Speed Boost (1.25x) | 3 sec | Yellow speed lines |
| sleep | 🌙 | Sleep | Shield (blocks 1 hit) | Until hit | Blue bubble |
| mindfulness | 💜 | Mindfulness | Clears obstacles ahead | Instant | Purple wave |
| heart | ❤️ | Extra Life | +1 Life (max 3) | Instant | Red heart particle |

### Power-Up Spawn Rules

```lua
PowerUpConfig = {
    spawnChance = 0.10,        -- 10% of spawns
    minDistanceBetween = 50,   -- Studs between power-ups
    glowColor = Color3.new(1, 0.8, 0),  -- Golden glow
    floatHeight = 4,           -- Higher than regular items
    pulseScale = {1.0, 1.3},   -- Size pulse range
}
```

---

## Difficulty Levels

| Setting | Chill Mode | Energized Mode | Turbo Mode |
|---------|------------|----------------|------------|
| Run Speed | 30 studs/sec | 45 studs/sec | 60 studs/sec |
| Speed Increase | +5%/30sec | +10%/20sec | +15%/15sec |
| Max Speed | 45 studs/sec | 70 studs/sec | 100 studs/sec |
| Obstacle Density | Low | Medium | High |
| Power-Up Frequency | High | Medium | Low |
| Course Length | 500 studs | 750 studs | 1000 studs |
| XP Multiplier | 1.0x | 1.5x | 2.0x |

### Speed Progression

```lua
SpeedConfig = {
    chillMode = {
        baseSpeed = 30,
        maxSpeed = 45,
        increaseRate = 0.05,
        increaseInterval = 30
    },
    energizedMode = {
        baseSpeed = 45,
        maxSpeed = 70,
        increaseRate = 0.10,
        increaseInterval = 20
    },
    turboMode = {
        baseSpeed = 60,
        maxSpeed = 100,
        increaseRate = 0.15,
        increaseInterval = 15
    }
}
```

---

## Scoring System

### Points Breakdown

| Action | Points | Notes |
|--------|--------|-------|
| Collect healthy food | +100 | Base points per item |
| Streak bonus (every 5) | +50 | 5, 10, 15... streak milestones |
| Speed boost active | 1.5x | Multiplier while boosted |
| Near-miss dodge | +25 | Pass within 2 studs of obstacle |
| Zone completion | +200 | Bonus for each zone cleared |
| Perfect zone (no hits) | +500 | Bonus if zone cleared without damage |
| Course completion | +1000 | Finish line bonus |

### XP Conversion

```lua
XPConversion = {
    conversionRate = 0.1,      -- 100 points = 10 XP
    dailyCapFree = 350,        -- Free users
    dailyCapSubscriber = 700,  -- Subscribers
    minimumXP = 5              -- Minimum XP per run
}
```

### Streak System

```
Streak Counter:
• Increments with each food collected
• Resets to 0 when hit by obstacle
• Visual: Flame icon grows with streak
• Audio: Pitch increases with streak
• Milestones: 5, 10, 15, 20, 25...
```

---

## HUD (Heads-Up Display)

```
┌─────────────────────────────────────────────────────────────┐
│  ❤️❤️❤️          🔥 x12           ⭐ 2,450                   │
│  Lives           Streak           Score                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                      [GAMEPLAY AREA]                         │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│  💧 SPEED BOOST! ████████░░ 2s    │    Zone 2/4             │
│  [Active Effect + Timer]          │    [Progress]           │
└─────────────────────────────────────────────────────────────┘
```

---

## End Screen (Educational Summary)

```
┌─────────────────────────────────────────────────────────────┐
│                    🏁 GREAT RUN! 🏁                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│     FINAL SCORE: 4,250 points                               │
│     XP EARNED: +42 XP                                        │
│     COINS EARNED: +21 coins                                  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  ITEMS COLLECTED                                      │   │
│  │  🥦 x3  🍎 x2  🐟 x4  🥕 x2  🍌 x3                    │   │
│  │  Total: 14 healthy foods!                             │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│                    📚 DID YOU KNOW? 📚                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  🥦 "Vitamin C keeps you healthy!"                          │
│     Broccoli has as much Vitamin C as an orange!            │
│                                                              │
│  🐟 "Omega-3s power your brain!"                            │
│     Eating fish twice a week helps you think better!        │
│                                                              │
│  🍌 "Potassium keeps muscles strong!"                       │
│     Bananas help prevent muscle cramps after exercise!      │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│         [ 🔄 PLAY AGAIN ]      [ 🚪 EXIT ]                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Educational Content System

```lua
EducationalContent = {
    -- Show 3 random facts from collected items
    factsToShow = 3,

    -- Extended facts (shown on end screen)
    extendedFacts = {
        broccoli = {
            shortFact = "Vitamin C keeps you healthy!",
            extendedFact = "Broccoli has as much Vitamin C as an orange!",
            funFact = "Broccoli looks like tiny trees!"
        },
        salmon = {
            shortFact = "Omega-3s power your brain!",
            extendedFact = "Eating fish twice a week helps you think better!",
            funFact = "Salmon can jump up waterfalls!"
        },
        banana = {
            shortFact = "Potassium keeps muscles strong!",
            extendedFact = "Bananas help prevent muscle cramps after exercise!",
            funFact = "Bananas are actually berries!"
        },
        -- ... more for each food
    },

    -- Quiz question (optional bonus)
    endQuiz = {
        enabled = true,
        bonusXP = 25,
        question = "Which food you collected is best for your brain?",
        options = {"🥦 Broccoli", "🐟 Salmon", "🍌 Banana"},
        correctAnswer = 2,  -- Salmon
        explanation = "Salmon has Omega-3s that help your brain work better!"
    }
}
```

---

## Audio Design

| Event | Sound Description |
|-------|-------------------|
| Food collected | Bright "ding" (880Hz → 1320Hz) |
| Streak milestone | Ascending chime |
| Obstacle hit | Thud + "oof" |
| Power-up collected | Magical sparkle |
| Speed boost active | Whoosh loop |
| Zone transition | Triumphant horn |
| Course complete | Victory jingle |

---

## File Structure (Roblox)

```
EnergyDashCanyonRun/
├── ServerScriptService/
│   ├── EnergyDashServer.lua       # Server-side game logic
│   ├── DataManager.lua            # Save/load player data
│   └── LeaderboardManager.lua     # High score tracking
│
├── ReplicatedStorage/
│   ├── EnergyDashConfig.lua       # Shared configuration
│   ├── FoodData.lua               # Food items + facts
│   ├── ObstacleData.lua           # Obstacle definitions
│   ├── PowerUpData.lua            # Power-up definitions
│   └── RemoteEvents/
│       ├── GameStart
│       ├── GameEnd
│       ├── ItemCollected
│       └── ScoreUpdate
│
├── StarterGui/
│   ├── EnergyDashHUD/             # In-game HUD
│   ├── StartScreen/               # Menu UI
│   └── ResultsScreen/             # End screen + education
│
├── StarterPlayerScripts/
│   └── EnergyDashClient.lua       # Client controls + visuals
│
└── Workspace/
    ├── CanyonCourse/              # The physical course
    │   ├── Zone1_SunriseCanyon/
    │   ├── Zone2_RiverRapids/
    │   ├── Zone3_CrystalCaves/
    │   └── Zone4_SummitSprint/
    ├── SpawnPoints/               # Item spawn markers
    └── FinishLine/                # End of course
```

---

## Integration with HealthQuest

```lua
Integrations = {
    questProgress = true,     -- Track for Active Adventures quest
    barrierAssessment = true, -- Adjust difficulty based on assessment
    coinRewards = true,       -- Award coins for completion
    badgeUnlocks = true,      -- "Speed Demon", "Veggie Champion" etc.
    journalEntry = true       -- Log foods collected to player journal
}
```
