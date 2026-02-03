# HealthQuest: Lumo's Land - Game Specification Summary

## Core Game Loop

```
BARRIER ASSESSMENT (12 questions)
        |
        v
   100 coins earned
        |
        v
   HATCH LUMO (spend 100 coins)
        |
        v
   TOP 3 QUESTS shown (based on wellness barriers)
        |
        v
   SELECT SMART GOAL (pick 1 quest)
        |
        v
   QUEST JOURNEY (102 lessons)
        |
        v
   CARE FOR LUMO (daily loop)
        |
        v
   COMPLETE QUEST --> New Barrier (400 Robux) or Retake FREE
```

---

## Barrier Assessment

**Purpose:** Identifies children's wellness barriers across 10 areas

| Property | Value |
|----------|-------|
| Questions | 12 |
| Scoring | Weighted by barrier area |
| Output | Top 3 quest recommendations |
| First Time | FREE |
| Retake (after quest complete) | FREE |
| New Barrier Assessment | 400 Robux |
| Reward | 100 coins (used to hatch Lumo) |

### 10 Wellness Barrier Areas → Quests

| Quest | Barrier Area | Weight |
|-------|--------------|--------|
| MindQuest | Mental Health | 1.5x |
| ResilienceAdventure | Hope & Resilience | 1.5x |
| BodyImageOdyssey | Body Image | 1.4x |
| ActiveAdventures | Physical Activity | 1.4x |
| MissionPowerUp | Physical Activity & Motivation | 1.4x |
| MindfulHeroAdventure | Mindfulness & Coping | 1.4x |
| FocusandFeel | Emotional Awareness | 1.4x |
| NutriQuest | Nutrition | 1.3x |
| KindnessCrusaders | Anti-Bullying / Social | 1.3x |
| MindfulBites | Mindful/Intuitive Eating | 1.2x |

---

## Quest Structure (102 Lessons Total)

```
PRE-ASSESSMENT (1)
    |
    v
100 REGULAR LESSONS (10 units × 10 lessons)
    |
    v
POST-ASSESSMENT (1)
    |
    v
FEEDBACK (1)
```

### Lesson Format
- Each lesson: Intro → 5 MCQ Questions → 3 Takeaways
- MCQ delivered via 8 rotating game modes:
  - Glass Bridge, Door Dash, Climb Mountain, Target Practice
  - Race Lanes, Balloon Pop, Lily Pad, Wall Break

---

## Coin Economy

### Where Coins Are EARNED (Castle Only)

| Location | Activity | Coins |
|----------|----------|-------|
| **Classroom** | Barrier Assessment (12 questions) | 100 |
| **Classroom** | Pre-Assessment | 50 |
| **Classroom** | Quest Lessons (1st time) | 50/lesson |
| **Classroom** | Quest Lessons (2nd time) | 25/lesson |
| **Classroom** | Quest Lessons (3rd time) | 15/lesson |
| **Classroom** | Quest Lessons (4th+ time) | 10/lesson |
| **Classroom** | Post-Assessment | 50 |
| **Classroom** | Feedback | 50 |
| **Lumo Care** | Emotion Guess (correct) | 10 |

### Where Coins Are SPENT (Castle Only)

| Location | Activity | Cost |
|----------|----------|------|
| **Lumo Care** | Hatch Lumo (first time) | 100 |
| **Lumo Care** | Feed Lumo (physical) | 15 (base) |
| **Lumo Care** | Water Lumo (physical) | 15 (base) |
| **Lumo Care** | Clean Lumo (physical) | 15 (base) |
| **Lumo Care** | Emotional Care (after guessing) | 15 (base) |
| **Nook Shop** | Castle Items | 25-2,500 |

### First Quest Coin Potential

| Component | Coins |
|-----------|-------|
| Barrier Assessment | 100 |
| Pre-Assessment | 50 |
| 100 Lessons × 50 | 5,000 |
| Post-Assessment | 50 |
| Feedback | 50 |
| **TOTAL** | **5,250** |

### Daily Care Economy

| Activity | Coins |
|----------|-------|
| Physical Care (Feed + Water + Clean) | -45 |
| Emotional Care (after guessing correct) | -15 |
| **Total Daily Care** | **-60** |
| Emotion Guessing (3 correct) | +30 |
| **Net Daily Cost** | **-30** |

---

## Lumo Care Loop

### Physical Needs (3 Stats)

| Need | Range | Decay Rate |
|------|-------|------------|
| Hunger | 0-100% | 72 hours to 0% |
| Thirst | 0-100% | 72 hours to 0% |
| Hygiene | 0-100% | 72 hours to 0% |

### Emotion System (Derived from Physical Needs)

Priority order - first match wins:

| # | Emotion | Trigger |
|---|---------|---------|
| 1 | THIRSTY | thirst ≤ 10% |
| 2 | HUNGRY | hunger ≤ 10% |
| 3 | MESSY | hygiene ≤ 15% |
| 4 | ANGRY | hunger < 25% AND thirst < 25% |
| 5 | SAD | 25-50% hunger AND thirst > 50% AND hygiene < 40% |
| 6 | ANXIOUS | 25-50% hunger AND 25-50% thirst AND hygiene > 50% |
| 7 | SCARED | hunger > 30% AND thirst > 30% AND 25-50% hygiene |
| 8 | TIRED | Any need 25-35% |
| 9 | PLAYFUL | All needs 50-75% |
| 10 | HAPPY | All needs > 75% |

### Emotional Care System (Two Steps)

**Teaching children to RECOGNIZE and ADDRESS emotions:**

```
STEP 1: RECOGNIZE (Emotion Guessing)
    - Guess how Lumo is feeling
    - FREE to attempt (3 tries/day)
    - Earn 10 coins if correct
    - Unlocks Step 2 when correct
           |
           v
STEP 2: ADDRESS (Emotional Care)
    - Provide emotional care (15 coins)
    - Shows age-appropriate coping strategy
    - Teaches HOW to help with that emotion
```

### Step 1: Emotion Guessing (Recognize)

| Property | Value |
|----------|-------|
| Attempts per day | 3 |
| Reward (correct) | 10 coins |
| Max daily earnings | 30 coins |
| Unlocks | Emotional Care (Step 2) |

### Step 2: Emotional Care (Address)

| Property | Value |
|----------|-------|
| Cost | 15 coins |
| Requires | Correct emotion guess first |
| Times per day | 1 (after guessing) |
| Teaches | Coping strategy for that emotion |

### Coping Strategies by Emotion

| Emotion | Strategy Taught |
|---------|----------------|
| Thirsty | "Let's take a water break together!" |
| Hungry | "Time for a healthy snack!" |
| Messy | "Let's clean up - a tidy space helps our mind feel calm" |
| Angry | "Let's take 5 deep breaths together" |
| Sad | "It's okay to feel sad. Let's give Lumo a hug" |
| Anxious | "Grounding exercise: Name 5 things you can see" |
| Scared | "You're safe here. Think of something brave you did" |
| Tired | "Rest is important! Let's take a quiet moment" |
| Playful | "Lumo wants to play! Let's do something fun" |
| Happy | "Lumo is so happy! Let's celebrate!" |

### Fly Away Mechanic

| Condition | Result |
|-----------|--------|
| No care for 72 hours | Lumo flies away |
| Player restriction | Cannot leave castle |
| Allowed action | Quest lessons only |
| Recovery | Map (120 Robux) |
| Return health | 50% all needs |

---

## Lumo Evolution System

### Evolution Stages (7 Total)

| Stage | Name | Care Actions | Discount | Description |
|-------|------|--------------|----------|-------------|
| 1 | Egg | 0 | 0% | A glowing dragon egg |
| 2 | Hatchling | 10+ | 0% | Eyes just opened |
| 3 | Fledgling | 50+ | 5% | Learning to walk |
| 4 | Juvenile | 150+ | 10% | Can fly short distances |
| 5 | Adolescent | 400+ | 12% | Full wings, playful |
| 6 | Adult | 1000+ | 15% | Mature and wise |
| 7 | Elder | 2500+ | 20% | Legendary, glowing |

### Care Costs by Evolution Stage

| Stage | Feed | Water | Clean | Emotional | Daily Total |
|-------|------|-------|-------|-----------|-------------|
| Egg-Hatchling | 15 | 15 | 15 | 15 | 60 |
| Fledgling | 14 | 14 | 14 | 14 | 56 |
| Juvenile | 13 | 13 | 13 | 13 | 52 |
| Adolescent | 13 | 13 | 13 | 13 | 52 |
| Adult | 12 | 12 | 12 | 12 | 48 |
| Elder | 12 | 12 | 12 | 12 | 48 |

---

## Castle Rooms

### Default Rooms (Level 1)

| Room | Purpose |
|------|---------|
| Bedroom | Sticker Journal, decorations |
| Kitchen | Food-themed decor |
| Living Room | Furniture, relaxation |
| Style Closet | Lumo outfits/accessories |
| Vault | Achievement display |
| Attic | Item storage |

### Unlockable Rooms

| Room | Unlock Level |
|------|--------------|
| Game Room | 12 |
| Library | 18 |
| Music Studio | 22 |
| Art Gallery | 28 |
| Home Gym | 32 |
| Greenhouse | 36 |

---

## Monetization Summary

### Robux Purchases

| Item | Price | Purpose |
|------|-------|---------|
| New Barrier Assessment | 400 Robux | New quest path (includes quest) |
| Map (Lumo recovery) | 120 Robux | Bring back Lumo when lost |

### What's FREE

- First Barrier Assessment
- Retaking any barrier (after completing its quest)
- Retaking any owned/completed quest
- All quest lessons and assessments
- Emotion guessing (earns coins)

---

## Location Summary

### Castle (Indoor) - COINS EARNED HERE

```
CASTLE
├── Classroom
│   ├── Barrier Assessment (100 coins)
│   ├── Pre-Assessment (50 coins)
│   ├── Quest Lessons (10-50 coins each)
│   ├── Post-Assessment (50 coins)
│   └── Feedback (50 coins)
│
├── Lumo's Room (Care Loop)
│   ├── Feed (costs 15 coins) - physical
│   ├── Water (costs 15 coins) - physical
│   ├── Clean (costs 15 coins) - physical
│   ├── Emotion Guess (earns 10 coins) - recognize
│   └── Emotional Care (costs 15 coins) - address
│
├── Nook Shop
│   └── Buy items with coins
│
└── Castle Rooms (6 default + 6 unlockable)
    └── Decorate with purchased items
```

### Outside Castle (Meadow & Biomes) - NO COINS

```
MEADOW (Hub)
├── Quest Portals (10 biomes)
├── Spinner (daily prizes)
└── Social features

BIOMES (Mini-games only)
├── Movement-based games
├── No coin rewards
└── Just for fun/engagement
```

---

## Key Design Principles

1. **All coins earned in castle** - Classroom (lessons) + Lumo Care (emotion guessing)
2. **Coins spent on Lumo** - Care costs create pressure to do lessons
3. **Diminishing returns** - Encourages buying new barriers vs. grinding same quest
4. **72-hour pressure** - Must care for Lumo or lose access to outside castle
5. **Evolution rewards loyalty** - Long-term care reduces costs
6. **SMART goals** - Barrier results personalize the wellness journey

---

## File Locations

| System | File |
|--------|------|
| Quest Progress | `src/ServerScriptService/PlayerData/QuestProgress.lua` |
| Lumo Care | `src/ServerScriptService/PlayerData/LumoCare.lua` |
| Barrier Assessment | `docs/BARRIER_ASSESSMENT.md` |
| Care Loop | `docs/CARE_LOOP.md` |
| Castle Rooms | `data/castle/castle-rooms.json` |
| Shop Items | `data/shop/shop-items.json` |
| Quest Lessons | `data/quests/*.json` |
