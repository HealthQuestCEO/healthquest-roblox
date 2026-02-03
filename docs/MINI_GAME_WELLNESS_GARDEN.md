# Wellness Garden - Mini-Game Spec

## Overview

| Property | Value |
|----------|-------|
| Game Name | Wellness Garden |
| Platform | Roblox |
| Location | Main Meadow (Hub Area) |
| Genre | Daily Habit Tracker / Virtual Garden |
| Target Age | 6-12 years |
| Educational Focus | Hydration, Sleep, Self-Care Habits |

A persistent garden area in the meadow where players grow flowers by logging healthy habits. Sunflowers grow with water intake, Moonflowers bloom with good sleep.

---

## Core Concept

The Wellness Garden is a daily habit tracker disguised as a magical garden. Players visit their personal garden plot to:

- **Log water cups** → Grow Sunflowers
- **Log sleep hours** → Grow Moonflowers
- **Collect bloomed flowers** → Add to weekly bouquet
- **Earn XP & Coins** → Rewards for consistent tracking
- **Learn health tips** → Educational content with each interaction

---

## Garden Layout

### Meadow Location

```
TOP-DOWN VIEW OF MAIN MEADOW:

    ┌─────────────────────────────────────────────────────────────┐
    │                                                              │
    │    🌳          MAIN MEADOW HUB           🌳                 │
    │                                                              │
    │         ┌─────────────────────────────┐                     │
    │         │                             │                     │
    │   🏠    │     WELLNESS GARDEN         │    🎮               │
    │  Nook   │      (Player Plot)          │   Games             │
    │         │                             │   Portal            │
    │         └─────────────────────────────┘                     │
    │                                                              │
    │    🚪                    🌸                    🚪            │
    │  Portal               Lumo                  Portal           │
    │  (World 1)           (NPC)                (World 2)         │
    │                                                              │
    └─────────────────────────────────────────────────────────────┘
```

### Garden Plot Structure

```
WELLNESS GARDEN PLOT (Per Player):

    ┌─────────────────────────────────────────────────────────────┐
    │                     🌤️ [Time of Day Sky]                    │
    │  ┌─────────────────────────────────────────────────────┐    │
    │  │                                                      │    │
    │  │   🌻          🌻          🌙          🌙            │    │
    │  │  Slot 1     Slot 2     Slot 3      Slot 4          │    │
    │  │                                                      │    │
    │  │  [Sunflower] [Sunflower] [Moonflower] [Moonflower]  │    │
    │  │   Bed         Bed         Bed          Bed          │    │
    │  │                                                      │    │
    │  │  ════════════════════════════════════════════════   │    │
    │  │                    [Garden Path]                     │    │
    │  │  ════════════════════════════════════════════════   │    │
    │  │                                                      │    │
    │  │        💧                         😴                │    │
    │  │    [Water Well]              [Moon Bench]           │    │
    │  │    (Log Water)               (Log Sleep)            │    │
    │  │                                                      │    │
    │  └─────────────────────────────────────────────────────┘    │
    │                                                              │
    │           🏺 [Weekly Bouquet Vase]                          │
    │                                                              │
    │      [ 🚿 Log Water ]        [ 🛏️ Log Sleep ]              │
    │                                                              │
    └─────────────────────────────────────────────────────────────┘
```

---

## Game Flow

```
┌─────────────────────────────────────────────────────────────┐
│  ENTER GARDEN                                                │
│  • Time-of-day themed (morning/afternoon/evening/night)     │
│  • Shows current flower growth status                        │
│  • Displays today's educational tip                          │
└─────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────────┐
│  LOG WATER              │     │  LOG SLEEP                  │
│  • Tap Water Well       │     │  • Tap Moon Bench           │
│  • Select cups (1-8)    │     │  • Select hours (4-12)      │
│  • Watch Sunflower grow │     │  • Watch Moonflower grow    │
│  • +5 XP per log        │     │  • +5 XP per log            │
└─────────────────────────┘     └─────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  FLOWER GROWTH                                               │
│  Stage 1: Seed (1-2 cups / 4-5 hours)        🌱              │
│  Stage 2: Sprout (3-4 cups / 6 hours)        🌿              │
│  Stage 3: Bud (5-6 cups / 7 hours)           🌷              │
│  Stage 4: Full Bloom (7-8 cups / 8+ hours)   🌸              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  COLLECT BLOOMED FLOWERS                                     │
│  • Tap bloomed flower to collect                            │
│  • Flower adds to weekly bouquet vase                       │
│  • +15 XP bonus for full bloom                              │
│  • +10 XP bonus if BOTH bloom same day                      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  WEEKLY BOUQUET REWARDS (Every 7 days)                       │
│  • 1-4 perfect days = 25 XP                                 │
│  • 5-8 perfect days = 50 XP                                 │
│  • 9-12 perfect days = 100 XP                               │
│  • 14/14 perfect = 150 XP + Special Badge                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Flower Mechanics

### Sunflower (Water Tracking)

| Growth Stage | Cups Needed | Visual | Emoji |
|--------------|-------------|--------|-------|
| Seed | 1-2 cups | Small mound with seed | 🌱 |
| Sprout | 3-4 cups | Green stem with leaves | 🌿 |
| Bud | 5-6 cups | Closed yellow bud | 🌷 |
| Full Bloom | 7-8 cups | Open sunflower | 🌻 |

**Daily Target:** 8 cups of water

#### Sunflower Colors (Random Daily)

| Color Name | Petal Color | Rarity |
|------------|-------------|--------|
| Sunny Yellow | #FCD34D | Common |
| Soft Pink | #F9A8D4 | Common |
| Warm Orange | #FDBA74 | Common |
| Peachy Coral | #FED7AA | Common |
| Ruby Red | #EF4444 | Rare (weekends) |

### Moonflower (Sleep Tracking)

| Growth Stage | Hours Needed | Visual | Emoji |
|--------------|--------------|--------|-------|
| Seed | 4-5 hours | Dark soil with seed | 🌱 |
| Sprout | 6 hours | Dark green vine | 🌿 |
| Bud | 7 hours | Closed white bud | 🌷 |
| Full Bloom | 8-12 hours | Open glowing flower | 🌙 |

**Daily Target:** 8-9 hours of sleep

#### Moonflower Colors (Based on Sleep Quality)

| Color Name | Hours | Petal Color | Special |
|------------|-------|-------------|---------|
| Pale Lavender | 5-6h | #DDD6FE | - |
| Soft Blue | 7h | #93C5FD | - |
| Deep Purple | 8h | #A78BFA | - |
| Silver White | 9+h | #F1F5F9 | Glows! |

---

## Time-of-Day Theming

The garden changes appearance based on real-world time:

| Time | Hours | Sky Color | Lighting | Special Effects |
|------|-------|-----------|----------|-----------------|
| Morning | 6am-12pm | Amber/Yellow | Bright sun | Dew drops sparkle |
| Afternoon | 12pm-5pm | Cyan/Green | Full daylight | Butterflies flutter |
| Evening | 5pm-8pm | Orange/Purple | Golden hour | Fireflies appear |
| Night | 8pm-6am | Indigo/Purple | Moonlight | Moonflowers glow |

### Time-Based Messages

```lua
TimeMessages = {
    morning = "Good morning! Start your day with water!",
    afternoon = "Stay hydrated this afternoon!",
    evening = "Golden hour in your garden!",
    night = "Moonflowers glow at night!"
}
```

---

## XP & Reward System

### Daily XP Rewards

| Action | XP | Notes |
|--------|-----|-------|
| Log water (any amount) | +5 | Once per day |
| Sunflower full bloom | +15 | Reach 8 cups |
| Log sleep (any amount) | +5 | Once per day |
| Moonflower full bloom | +15 | Reach 8 hours |
| Both blooms same day | +10 | Bonus for completing both |
| **Maximum Daily** | **50 XP** | |

### Weekly Bouquet Rewards

| Perfect Days | XP Reward | Badge |
|--------------|-----------|-------|
| 1-4 days | 25 XP | - |
| 5-8 days | 50 XP | - |
| 9-12 days | 100 XP | - |
| 14/14 (perfect week) | 150 XP | "Garden Guardian" badge |

**Perfect Day** = Both Sunflower AND Moonflower reach full bloom

### Coin Rewards

| Action | Coins | Notes |
|--------|-------|-------|
| First log of the day | +5 | Either water or sleep |
| Full bloom (each) | +10 | 20 max if both bloom |
| Perfect week | +50 | Bonus |

---

## Educational Content

### Water Tips (Shown When Logging Water)

```lua
WaterTips = {
    "Water helps your brain think better!",
    "Your body is made of more than half water!",
    "Water helps you run, jump, and play.",
    "Drinking water keeps your heart happy.",
    "Water helps your tummy break down food.",
    "When you feel tired, try drinking water!",
    "Water keeps your skin soft and healthy.",
    "Your muscles need water to stay strong."
}
```

### Sleep Tips (Shown When Logging Sleep)

```lua
SleepTips = {
    "Your brain cleans itself while you sleep!",
    "Sleep helps you remember what you learned today.",
    "Your body grows taller while you rest.",
    "Good sleep helps you feel happy.",
    "Sleep gives your heart a rest.",
    "Dreams help your brain sort out your day!",
    "Sleep helps your body fight germs.",
    "Rest helps your muscles get stronger."
}
```

### Fun Facts (Shown on Full Bloom)

```lua
SunflowerFacts = {
    "Sunflowers turn to face the sun as it moves across the sky!",
    "A sunflower can grow taller than a grown-up!",
    "Bees love sunflowers. Buzz buzz!",
    "Sunflower seeds are a yummy snack.",
    "Sunflowers can be yellow, red, orange, or even pink!"
}

MoonflowerFacts = {
    "Real moonflowers only bloom at night!",
    "Moonflowers open when the sun goes down.",
    "Moths visit moonflowers in the dark.",
    "Moonflowers smell sweet at night.",
    "In the morning, moonflowers close up to rest — just like you!",
    "Moonflowers glow white in the moonlight."
}
```

---

## UI Design

### Water Logging UI

```
┌─────────────────────────────────────────────────────────────┐
│                    💧 LOG YOUR WATER 💧                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│     How many cups of water did you drink today?             │
│                                                              │
│     ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐│
│     │ 1  │ │ 2  │ │ 3  │ │ 4  │ │ 5  │ │ 6  │ │ 7  │ │ 8  ││
│     │ 🥛 │ │ 🥛 │ │ 🥛 │ │ 🥛 │ │ 🥛 │ │ 🥛 │ │ 🥛 │ │ 🥛 ││
│     └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘│
│       ✓      ✓      ✓      ✓                                │
│                                                              │
│     Today: 4 cups  |  Goal: 8 cups                          │
│     ████████████░░░░░░░░░░░░  50%                           │
│                                                              │
│     💡 Tip: "Water helps your brain think better!"          │
│                                                              │
│                    [ ✓ Log Water ]                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Sleep Logging UI

```
┌─────────────────────────────────────────────────────────────┐
│                    🌙 LOG YOUR SLEEP 🌙                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│     How many hours did you sleep last night?                │
│                                                              │
│              ┌──────────────────────────┐                   │
│              │                          │                   │
│              │     😴    8 hours        │                   │
│              │                          │                   │
│              │    ◄──────●──────►       │                   │
│              │   4h              12h    │                   │
│              │                          │                   │
│              └──────────────────────────┘                   │
│                                                              │
│     Your sleep: 8 hours  |  Goal: 8-9 hours ✓               │
│                                                              │
│     💡 Tip: "Sleep helps you remember what you learned!"    │
│                                                              │
│                    [ ✓ Log Sleep ]                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Weekly Bouquet Display

```
┌─────────────────────────────────────────────────────────────┐
│                   🏺 WEEKLY BOUQUET 🏺                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                        🌻🌙🌻🌙                             │
│                       🌻🌙🌻🌙🌻                            │
│                        \  |  /                              │
│                         \_|_/                               │
│                         [___]                               │
│                                                              │
│     This Week's Flowers:                                    │
│     🌻 Sunflowers: 5/7                                      │
│     🌙 Moonflowers: 4/7                                     │
│                                                              │
│     Perfect Days: 4/7                                       │
│     ████████████░░░░░░░░  57%                               │
│                                                              │
│     Mon  Tue  Wed  Thu  Fri  Sat  Sun                       │
│      ✓    ✓    ✓    ✓    ○    ○    ○                        │
│                                                              │
│     Keep going! 3 more perfect days for bonus XP!           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Persistence

### Player Garden Data Structure

```lua
GardenData = {
    -- Today's progress
    today = {
        date = "2026-02-03",
        waterCups = 4,
        waterLogged = true,
        sleepHours = 8,
        sleepLogged = true,
        sunflowerCollected = false,
        moonflowerCollected = true,
        xpEarned = 25
    },

    -- Weekly tracking
    week = {
        startDate = "2026-01-27",
        perfectDays = 4,
        sunflowersCollected = 5,
        moonflowersCollected = 4,
        dailyLog = {
            ["2026-01-27"] = { water = 8, sleep = 9, perfect = true },
            ["2026-01-28"] = { water = 6, sleep = 8, perfect = false },
            -- ... etc
        }
    },

    -- Lifetime stats
    lifetime = {
        totalSunflowers = 127,
        totalMoonflowers = 98,
        perfectWeeks = 3,
        longestStreak = 12,
        currentStreak = 4,
        badgesEarned = {"Garden Guardian", "Hydration Hero"}
    },

    -- Garden customization (future)
    garden = {
        fenceStyle = "wood",
        pathStyle = "stone",
        decorations = {"butterfly_house", "birdbath"}
    }
}
```

---

## Badges & Achievements

| Badge | Requirement | XP Bonus |
|-------|-------------|----------|
| First Bloom | Grow first flower to full bloom | 25 |
| Hydration Hero | Log water 7 days in a row | 50 |
| Dream Weaver | Log 9+ hours sleep 5 times | 50 |
| Garden Guardian | Perfect week (14/14 blooms) | 150 |
| Rainbow Garden | Collect all sunflower colors | 100 |
| Silver Moon | Get a Silver White moonflower | 75 |
| 100 Flowers | Collect 100 total flowers | 200 |
| Year of Wellness | Track for 365 days | 500 |

---

## File Structure (Roblox)

```
WellnessGarden/
├── ServerScriptService/
│   ├── WellnessGardenServer.lua    # Server game logic
│   ├── GardenDataManager.lua       # Save/load player data
│   └── WeeklyResetHandler.lua      # Weekly bouquet rewards
│
├── ReplicatedStorage/
│   ├── GardenConfig.lua            # Shared configuration
│   ├── FlowerData.lua              # Flower types & growth
│   ├── TipsData.lua                # Educational tips
│   ├── TimeThemes.lua              # Time-of-day settings
│   └── RemoteEvents/
│       ├── LogWater
│       ├── LogSleep
│       ├── CollectFlower
│       └── GetBouquetReward
│
├── StarterGui/
│   ├── WaterLogUI/                 # Water logging popup
│   ├── SleepLogUI/                 # Sleep logging popup
│   ├── BouquetUI/                  # Weekly bouquet display
│   └── GardenHUD/                  # In-garden HUD
│
├── StarterPlayerScripts/
│   └── GardenClient.lua            # Client interactions
│
└── Workspace/
    └── WellnessGarden/
        ├── GardenPlot/             # Base garden structure
        ├── WaterWell/              # Interactive water well
        ├── MoonBench/              # Interactive sleep bench
        ├── BouquetVase/            # Weekly collection display
        ├── Flowers/
        │   ├── SunflowerSlot1/
        │   ├── SunflowerSlot2/
        │   ├── MoonflowerSlot1/
        │   └── MoonflowerSlot2/
        └── Decorations/            # Fence, path, extras
```

---

## Integration with HealthQuest

```lua
Integrations = {
    -- Connect to barrier assessment
    barrierAssessment = {
        enabled = true,
        adjustments = {
            -- If sleep barriers identified, show extra sleep tips
            sleepBarrier = "extra_sleep_tips",
            -- If hydration barriers, show water reminders
            hydrationBarrier = "water_reminders"
        }
    },

    -- Quest progress tracking
    questProgress = {
        activeAdventures = {
            -- Logging water counts toward "Move Your Body" quest
            waterLog = "physical_activity_quest",
            -- Logging sleep counts toward wellness quests
            sleepLog = "rest_recovery_quest"
        }
    },

    -- Main meadow connection
    meadowHub = {
        gardenLocation = Vector3.new(0, 0, 50),  -- Position in meadow
        visibleToAll = true,  -- Other players can see your garden
        visitFriends = true   -- Can visit friends' gardens
    },

    -- Notifications
    notifications = {
        dailyReminder = true,   -- "Your garden misses you!"
        streakWarning = true,   -- "Don't break your streak!"
        weeklyReward = true     -- "Collect your bouquet reward!"
    }
}
```

---

## Future Expansions

- **Garden Decorations** - Unlock birdbaths, butterflies, gnomes with coins
- **Friend Gardens** - Visit and water friends' flowers for bonus XP
- **Seasonal Events** - Pumpkins in fall, snowflowers in winter
- **Mood Flowers** - Third flower type for mood tracking
- **Garden Pets** - Unlock bees, butterflies that live in garden
- **Rare Seeds** - Special flowers from quest completions
