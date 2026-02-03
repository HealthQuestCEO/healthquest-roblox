# HealthQuest: Lumo's Land - Game Design Document

## Overview

A kids health education game combining multiple Roblox genres into one connected world.

**Target Audience:** Children 6-12 years old

---

## Game Structure

```
                            ┌─────────────────┐
                            │    HUB WORLD    │
                            │  (Spawn Area)   │
                            │  Lumo follows   │
                            └────────┬────────┘
                                     │
        ┌────────────┬───────────────┼───────────────┬────────────┐
        │            │               │               │            │
        ▼            ▼               ▼               ▼            ▼
┌──────────────┐ ┌──────────┐ ┌──────────────┐ ┌──────────┐ ┌──────────┐
│  LUMO'S DEN  │ │  CASTLE  │ │  QUEST HALL  │ │  ARCADE  │ │  WORLDS  │
│ Pet Simulator│ │  Tycoon  │ │   Learning   │ │Mini-Games│ │   RPG    │
└──────────────┘ └──────────┘ └──────────────┘ └──────────┘ └──────────┘
        │            │               │               │            │
        └────────────┴───────────────┼───────────────┴────────────┘
                                     │
                            ┌────────▼────────┐
                            │    THE NOOK     │
                            │     (Shop)      │
                            └─────────────────┘
```

---

## 1. Hub World

**Genre:** Social Hub / Navigation

| Feature | Description |
|---------|-------------|
| Purpose | Central spawn connecting all areas |
| Lumo | Companion follows player everywhere |
| Portals | Doors/portals to each game area |
| Style | Giant meadow with paths to buildings |

### First-Time Player Flow
```
Join Game → Hub World → Meet Lumo → Barrier Assessment →
Get First Quest → Tutorial → Free to Explore
```

---

## 2. Lumo's Den (Pet Simulator)

**Genre:** Tamagotchi-style Pet Care

### Core Mechanics
| Mechanic | Description |
|----------|-------------|
| Feed | Give Lumo food/drinks (affects hunger/thirst) |
| Play | Mini-interactions (affects happiness) |
| Rest | Let Lumo sleep (affects energy) |
| Clean | Hygiene care (affects cleanliness) |
| Identify Emotions | Guessing game from Care Loop |

### Evolution System (5 Stages)

| Stage | Name | Unlock Condition |
|-------|------|------------------|
| 1 | Egg | Starting state |
| 2 | Baby | Hatch after first care session |
| 3 | Young | Reach Level 10 + 50 care sessions |
| 4 | Adult | Reach Level 25 + 200 care sessions |
| 5 | Legendary | Reach Level 50 + complete special quest |

### Accessories/Customization
- Hats, wings, collars, colors
- Unlocked via shop or achievements

### Integration with Care Loop
- 72-hour decay timer
- 10 emotions (see CARE_LOOP.md)
- Recovery Den inside Lumo's Den
- Helper Zone for emotional support items

---

## 3. Castle (Tycoon/Decorating)

**Genre:** Tycoon / Home Decorating / Dress-Up

### 13 Unlockable Rooms

| # | Room | Unlock Level | Purpose |
|---|------|--------------|---------|
| 1 | Bedroom | 1 (Start) | Rest, sticker book |
| 2 | Kitchen | 3 | Cooking mini-games |
| 3 | Living Room | 5 | Display trophies |
| 4 | Bathroom | 7 | Hygiene activities |
| 5 | Garden | 10 | Outdoor space |
| 6 | Library | 13 | Quest Hall access |
| 7 | Game Room | 16 | Arcade preview |
| 8 | Art Studio | 20 | Creative activities |
| 9 | Music Room | 24 | Sound/rhythm games |
| 10 | Gym | 28 | Physical activity zone |
| 11 | Meditation Room | 32 | Mindfulness space |
| 12 | Trophy Hall | 40 | Achievement display |
| 13 | Legendary Suite | 50 | Ultimate room |

### Features
| Feature | Description |
|---------|-------------|
| Furniture Placement | Grid-based drag & drop |
| Avatar Closet | Outfits, accessories, colors |
| Sticker Book | Collectibles from achievements |
| Decorating | Walls, floors, themes |

---

## 4. Quest Hall (Quiz/Learning Game)

**Genre:** Educational Quiz Game

### Structure
- **10 Quest Lines** (from Barrier Assessment)
- **100 Lessons per Quest** (1,000 total lessons)
- **5 Questions per Lesson**
- **10 Thematic Units per Quest**

### Question Types

| Type | Description | Example |
|------|-------------|---------|
| Multiple Choice | 4 options, 1 correct | "What helps your brain feel happy?" |
| Drag & Drop Matching | Match items to categories | Match foods to food groups |
| Spelling Race | Type answer, score by letters | "Type a plant protein!" (beans = 5 pts) |
| True/False | Quick binary choice | "Exercise helps you sleep better" |

### Spelling Race Game
```
┌─────────────────────────────────────────────────────────────┐
│              SPELLING RACE: Plant Proteins!                 │
│                                                             │
│  Type as many plant proteins as you can!                    │
│  Score = number of letters typed correctly                  │
│                                                             │
│  Timer: [=====>        ] 30 seconds                         │
│                                                             │
│  Your answers:                                              │
│  ✓ beans (5 pts)                                            │
│  ✓ lentils (7 pts)                                          │
│  ✓ tofu (4 pts)                                             │
│  ✓ quinoa (6 pts)                                           │
│                                                             │
│  Current Score: 22 points                                   │
│                                                             │
│  [Type here: ________]                                      │
└─────────────────────────────────────────────────────────────┘
```

### Rewards
| Action | XP | Coins |
|--------|-----|-------|
| Complete lesson | 10 | 5 |
| Perfect lesson (all correct) | 25 | 15 |
| Complete unit | 100 | 50 |
| Complete quest | 1000 | 500 |

---

## 5. Arcade (Mini-Game Collection)

**Genre:** Mini-Games

### 13 Games Across 3 Zones

#### Mind Gym (Relaxation/Mindfulness)
| # | Game | Description |
|---|------|-------------|
| 1 | Breathing Bubbles | Breathe in/out to control bubble size |
| 2 | Grounding Garden | Find 5-4-3-2-1 sensory items |
| 3 | Cloud Watching | Tap matching cloud shapes |
| 4 | Calm Colors | Color-by-number relaxation |

#### Action Zone (Physical/Active)
| # | Game | Description |
|---|------|-------------|
| 5 | Endless Runner | Dodge obstacles, collect healthy items |
| 6 | Simon Says Workout | Follow movement commands |
| 7 | Bubble Pop | Pop bubbles matching the prompt |
| 8 | Dance Party | Rhythm game with Lumo |
| 9 | Obstacle Course | Parkour-style challenge |

#### Learning Lab (Educational)
| # | Game | Description |
|---|------|-------------|
| 10 | Cooking Sim | Make healthy recipes |
| 11 | Category Sorter | Sort items into correct groups |
| 12 | Trivia Detective | Solve mysteries with trivia |
| 13 | Spelling Sprint | Race to spell health words |

### Arcade Features
- Coin rewards per game
- Daily challenges (bonus rewards)
- Leaderboards (optional)
- Difficulty levels

---

## 6. World Portals (Story/Roleplay)

**Genre:** Animal Crossing-style RPG

### 6 Themed Worlds

| # | World | Theme | Unlock Level |
|---|-------|-------|--------------|
| 1 | Sunny Meadow | Introduction/Basics | 1 (Start) |
| 2 | Mindful Mountain | Mental Health | 10 |
| 3 | Nutrition Village | Healthy Eating | 15 |
| 4 | Active Island | Physical Activity | 20 |
| 5 | Friendship Forest | Social Skills | 30 |
| 6 | Resilience Realm | Hope & Confidence | 40 |

### NPCs Per World
- **9 NPCs per world** (54 total NPCs)
- **10 conversations per NPC** (540 total conversation trees)

### Conversation Style (Animal Crossing-inspired)

| Feature | Description |
|---------|-------------|
| Warm Greetings | NPCs recognize returning players |
| Personality-Driven | Each NPC has unique voice |
| Branching Dialogue | Player choices affect responses |
| Not Yes/No | Multiple meaningful options |
| Educational Content | Health info woven naturally |
| Progression | New conversations unlock over time |

### Example NPC Conversation
```
┌─────────────────────────────────────────────────────────────┐
│  [Chef Pepper - Nutrition Village]                         │
│                                                             │
│  "Hey there, little chef! I was just thinking about        │
│   breakfast. Did you know your brain needs fuel to         │
│   work its best?"                                           │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ > "What kind of fuel?"                              │   │
│  │ > "I had breakfast today!"                          │   │
│  │ > "I'm not hungry in the morning"                   │   │
│  │ > "Tell me about your favorite breakfast"           │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Rewards
| Action | XP | Coins |
|--------|-----|-------|
| Complete conversation | 15 | 10 |
| First time meeting NPC | 25 | 15 |
| Complete all NPC conversations | 100 | 75 |

---

## 7. The Nook (Shop System)

**Genre:** Economy/Shop

### Purchasable Categories

| Category | Examples |
|----------|----------|
| Furniture | Beds, chairs, tables, decorations |
| Outfits | Clothes, hats, shoes |
| Pet Accessories | Hats, collars, wings for Lumo |
| Room Themes | Wall/floor sets |
| Special Items | Stickers, badges |

### Economy

| Currency | How to Earn | How to Spend |
|----------|-------------|--------------|
| XP | All activities | Leveling up |
| Coins | All activities | Shop purchases |
| Robux | Real money (optional) | Premium coins |

### Coin Sources
| Source | Coins |
|--------|-------|
| Care Loop (correct emotion) | 5 |
| Quest lesson | 5-15 |
| Mini-game | 10-50 |
| NPC conversation | 10-15 |
| Daily login | 25 |
| Achievements | 50-500 |

---

## 8. Progression System

### XP & Leveling

| Level Range | Unlocks |
|-------------|---------|
| 1-5 | Hub World, Lumo's Den, Castle (2 rooms) |
| 6-10 | Quest Hall, Arcade basics, World 1 |
| 11-20 | More Castle rooms, Worlds 2-3 |
| 21-30 | Advanced Arcade, Worlds 4-5 |
| 31-40 | All Castle rooms, World 6 |
| 41-50 | Legendary content, special evolutions |

### Daily Engagement
- Daily login bonus
- Daily challenges (arcade)
- Lumo care reminders
- New NPC conversations

---

## Technical Requirements

### Data to Persist (Per Player)
```lua
PlayerData = {
    -- Profile
    level = 1,
    xp = 0,
    coins = 0,

    -- Lumo
    lumoStage = "egg",
    lumoNeeds = {hunger = 100, thirst = 100, hygiene = 100},
    lumoAccessories = {},
    lastCareTime = 0,

    -- Barrier Assessment
    assessmentComplete = false,
    assessmentAnswers = {},
    topBarriers = {},
    assignedQuest = "",

    -- Quest Progress
    questProgress = {
        ActiveAdventures = {lessonsComplete = 0, currentUnit = 1},
        -- ... other quests
    },

    -- Castle
    unlockedRooms = {"bedroom"},
    furniture = {},
    avatar = {outfit = "default", accessories = {}},
    stickers = {},

    -- World Progress
    unlockedWorlds = {"sunny_meadow"},
    npcProgress = {
        -- NPC ID = conversations completed
    },

    -- Arcade
    highScores = {},
    dailyChallengesComplete = {},
}
```

---

## Content Requirements Summary

| Content Type | Count | Status |
|--------------|-------|--------|
| Quest Lessons | 1,000 (100 × 10) | Need content |
| Trivia Questions | 5,000 (5 × 1000) | Need content |
| NPCs | 54 (9 × 6 worlds) | Need designs |
| NPC Conversations | 540 (10 × 54) | Need scripts |
| Mini-Games | 13 | Need design docs |
| Furniture Items | ~100+ | Need list |
| Avatar Items | ~50+ | Need list |
| Lumo Accessories | ~30+ | Need list |
