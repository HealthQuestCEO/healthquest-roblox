# HealthQuest: Lumo's Land - Complete Game Design

## Overview

A kids health education game combining multiple Roblox genres into one connected world.

**Target Audience:** Children 6-12 years old
**Platform:** Roblox

---

## Player & Pet System

| Element | Description |
|---------|-------------|
| **Player Avatar** | Human character (customizable outfits, colors, accessories) |
| **Pet Companion** | Lumo the dragon - follows player everywhere |
| **Dragon Variants** | Unlockable/purchasable different dragon types |

### Lumo Evolution (5 Stages)

| Stage | Name | How to Unlock |
|-------|------|---------------|
| 1 | Egg | Starting state |
| 2 | Baby | Hatch after first care session |
| 3 | Young | Level 10 + 50 care sessions |
| 4 | Adult | Level 25 + 200 care sessions |
| 5 | Legendary | Level 50 + complete special quest |

### Dragon Variants (Monetization)

| Type | How to Get |
|------|------------|
| Classic Lumo (teal) | Free starter |
| Color variants | Coins or Robux |
| Elemental dragons | Achievement unlocks |
| Legendary dragons | Complete full quest lines |
| Seasonal dragons | Limited time events |

---

## World Layout

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           MAIN MEADOW                                   │
│                                                                         │
│                        ┌───────────────────┐                            │
│                        │      CASTLE       │                            │
│                        │                   │                            │
│                        │  ┌─────────────┐  │                            │
│                        │  │ 13 Rooms    │  │  ← Unlock with XP (FREE)   │
│                        │  │ (functional)│  │    Decorate with COINS     │
│                        │  ├─────────────┤  │                            │
│                        │  │ Classroom   │  │  ← Quest lessons here      │
│                        │  │ (quests)    │  │    (adapts to YOUR path)   │
│                        │  └─────────────┘  │                            │
│                        │                   │                            │
│                        └───────────────────┘                            │
│                                                                         │
│     ┌───────────┐                                                       │
│     │ THE NOOK  │  ← Shop: Room decor, outfits, Lumo accessories        │
│     │  (Shop)   │                                                       │
│     └───────────┘                                                       │
│                                                                         │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐    │
│  │World 1 │ │World 2 │ │World 3 │ │World 4 │ │World 5 │ │World 6 │    │
│  │Portal  │ │Portal  │ │Portal  │ │Portal  │ │Portal  │ │Portal  │    │
│  │ Lv 1   │ │ Lv 10  │ │ Lv 15  │ │ Lv 20  │ │ Lv 30  │ │ Lv 40  │    │
│  └───┬────┘ └───┬────┘ └───┬────┘ └───┬────┘ └───┬────┘ └───┬────┘    │
│      │          │          │          │          │          │          │
└──────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┘
       ▼          ▼          ▼          ▼          ▼          ▼
  ┌─────────┐┌─────────┐┌─────────┐┌─────────┐┌─────────┐┌─────────┐
  │ Sunny   ││ Mindful ││Nutrition││ Active  ││Friendship││Resilience│
  │ Meadow  ││Mountain ││ Village ││ Island  ││ Forest  ││  Realm  │
  │ 9 NPCs  ││ 9 NPCs  ││ 9 NPCs  ││ 9 NPCs  ││ 9 NPCs  ││ 9 NPCs  │
  └─────────┘└─────────┘└─────────┘└─────────┘└─────────┘└─────────┘
```

---

## First-Time Player Experience

```
1. Player joins → Spawns in Meadow
                      │
2. Meets Lumo (egg) → Egg hatches into Baby Lumo!
                      │
3. Barrier Assessment → 12 questions about wellness
                      │
4. Results → Top 3 barriers identified → Earn 100 coins!
                      │
5. SMART Goal Selection → Pick 1 of 3 goals
                      │
6. Quest Assigned → Routed to specific quest path
                      │
7. Tutorial → Learn castle, care loop, basics
                      │
8. Free to Explore! → Castle, Worlds, Arcade, Shop
```

---

## Castle (Central Hub Building)

### 13 Functional Rooms + 1 Classroom

**Unlock:** Rooms unlock with XP (FREE)
**Decorate:** Buy furniture/decor with Coins

| # | Room | Unlock Level | Purpose |
|---|------|--------------|---------|
| 1 | Bedroom | 1 (Start) | Rest, sticker book |
| 2 | Kitchen | 3 | Cooking activities |
| 3 | Living Room | 5 | Display trophies |
| 4 | Bathroom | 7 | Hygiene/self-care |
| 5 | Garden | 10 | Outdoor space |
| 6 | Library | 13 | Reading nook |
| 7 | Game Room | 16 | Mini-game preview |
| 8 | Art Studio | 20 | Creative activities |
| 9 | Music Room | 24 | Sound/rhythm |
| 10 | Gym | 28 | Physical activity |
| 11 | Meditation Room | 32 | Mindfulness |
| 12 | Trophy Hall | 40 | Achievement display |
| 13 | Legendary Suite | 50 | Ultimate room |
| -- | **Classroom** | 1 (Start) | Quest lessons |

### Classroom (Quest Learning)

- Walk into classroom to do quest lessons
- Content adapts to YOUR assigned quest path
- 100 lessons per quest, 5 questions per lesson
- Multiple choice, matching, spelling race

---

## Lumo Care Loop (Pet Simulator)

### 3 Physical Needs (72-Hour Decay)

| Need | Range | If Neglected |
|------|-------|--------------|
| Hunger | 0-100% | Lumo gets hungry emotions |
| Thirst | 0-100% | Lumo gets thirsty emotions |
| Hygiene | 0-100% | Lumo gets messy emotions |

**WARNING:** If needs hit 0% for 72 hours → Lumo disappears!

### 10 Emotions (Priority Order)

| # | Emotion | When It Shows |
|---|---------|---------------|
| 1 | Thirsty | thirst ≤ 10% |
| 2 | Hungry | hunger ≤ 10% |
| 3 | Messy | hygiene ≤ 15% |
| 4 | Angry | hunger + thirst both low |
| 5 | Sad | mid hunger, high thirst, low hygiene |
| 6 | Anxious | mid hunger, mid thirst, high hygiene |
| 7 | Scared | higher needs but mid hygiene |
| 8 | Tired | any need 25-35% |
| 9 | Playful | all needs 50-75% |
| 10 | Happy | all needs > 75% |

### Emotion Guessing Game

1. Lumo shows emotion (static image)
2. Player guesses what emotion
3. **Correct:** 5 coins + 10 XP (max 4/day)
4. **Wrong:** Get a hint, try again
5. Go to Recovery Den to help Lumo

### Recovery Den

- **Help Lumo's Body** → Feed, water, clean
- **Helper Zone** → Emotional support items (yoga mat, teddy bear, tablet)
- After care → Needs reset to 50%

---

## Quest Hall (10 Quests)

### How It Works

1. Take Barrier Assessment (12 questions)
2. Get Top 3 barriers ranked
3. Choose SMART goal
4. Assigned to quest matching your goal
5. Complete 100 lessons in Classroom

### 10 Quest Paths

| Quest | Barrier | Focus |
|-------|---------|-------|
| ActiveAdventures | Physical Activity | Play, movement, fun |
| MissionPowerUp | Physical Activity | Body science, getting stronger |
| BodyImageOdyssey | Body Image | Self-esteem, body positivity |
| FocusandFeel | Emotions | Recognizing feelings |
| KindnessCrusaders | Anti-Bullying | Social skills, inclusion |
| MindfulBites | Mindful Eating | Hunger cues, enjoying food |
| MindfulHeroAdventure | Mindfulness | Breathing, coping |
| MindQuest | Mental Health | Stress, emotional regulation |
| NutriQuest | Nutrition | Healthy foods |
| Resilience Adventure | Resilience | Hope, bouncing back |

### Quest Rewards

| Action | XP | Coins |
|--------|-----|-------|
| Complete lesson | 50 | 50 |
| Complete unit (10 lessons) | 100 | 100 |
| Complete quest (100 lessons) | 1000 | 500 |

---

## World Portals (NPC Conversations)

### 6 Themed Worlds

| World | Theme | Unlock | NPCs |
|-------|-------|--------|------|
| Sunny Meadow | Introduction | Level 1 | 9 |
| Mindful Mountain | Mental Health | Level 10 | 9 |
| Nutrition Village | Healthy Eating | Level 15 | 9 |
| Active Island | Physical Activity | Level 20 | 9 |
| Friendship Forest | Social Skills | Level 30 | 9 |
| Resilience Realm | Hope & Confidence | Level 40 | 9 |

**Total: 54 NPCs × 10 conversations each = 540 conversation trees**

### Animal Crossing-Style Dialogue

- Warm, personality-driven greetings
- Branching conversations (not yes/no)
- Player choices affect NPC responses
- Educational content woven naturally
- New conversations unlock over time

### World Rewards

| Action | XP | Coins |
|--------|-----|-------|
| Complete conversation | 15 | 10 |
| Meet new NPC | 25 | 15 |
| Complete all NPC convos | 100 | 75 |

---

## The Nook (Shop)

**Location:** Building in the Meadow (outside Castle)

### What You Can Buy

| Category | Examples | Currency |
|----------|----------|----------|
| Room Decor | Furniture, rugs, lamps | Coins |
| Avatar Outfits | Clothes, hats, shoes | Coins |
| Lumo Accessories | Hats, collars, wings | Coins |
| Dragon Variants | Color skins, elemental | Coins or Robux |
| Room Themes | Wall/floor sets | Coins |

### Decor Per Room

- Each of the 13 castle rooms has themed decor
- Buy items to customize YOUR castle

---

## Economy

### Two Currencies

| Currency | How to Earn | What It Does |
|----------|-------------|--------------|
| **XP** | All activities | Level up → Unlock rooms & worlds |
| **Coins** | All activities | Buy items in The Nook |

### Coin Sources

| Source | Coins |
|--------|-------|
| Quest lesson | 50 |
| Care Loop (correct emotion) | 5 |
| NPC conversation | 10 |
| Mini-game | 10-50 |
| Daily login | 25 |
| Achievements | 50-500 |

### Premium Option

- Buy Coins with Robux (optional)
- All content playable without paying

---

## Arcade (Mini-Games)

### 13 Games in 3 Zones

**Mind Gym (Relaxation)**
1. Breathing Bubbles
2. Grounding Garden
3. Cloud Watching
4. Calm Colors

**Action Zone**
5. Endless Runner
6. Simon Says Workout
7. Bubble Pop
8. Dance Party
9. Obstacle Course

**Learning Lab**
10. Cooking Sim
11. Category Sorter
12. Trivia Detective
13. Spelling Sprint

---

## Progression Summary

| Level | Unlocks |
|-------|---------|
| 1 | Meadow, Castle (3 rooms), Classroom, World 1 |
| 3-10 | More Castle rooms |
| 10 | World 2: Mindful Mountain |
| 15 | World 3: Nutrition Village |
| 20 | World 4: Active Island |
| 30 | World 5: Friendship Forest |
| 40 | World 6: Resilience Realm |
| 50 | Legendary Suite, Legendary Lumo |

---

## Content Needed to Build

| Content | Count | Status |
|---------|-------|--------|
| Quest Lessons | 1,000 | ❓ Need from you |
| Trivia Questions | 5,000 | ❓ Need from you |
| NPC Characters | 54 | ❓ Need from you |
| NPC Dialogue | 540 convos | ❓ Need from you |
| Furniture Items | ~100 | ❓ Need list |
| Avatar Items | ~50 | ❓ Need list |
| Dragon Variants | ~10 | ❓ Need list |

---

## Technical Systems (I Can Build Now)

| System | Status |
|--------|--------|
| ✅ Barrier Assessment | Ready (12 questions, scoring, routing) |
| ✅ Care Loop | Ready (emotion logic, 72hr decay) |
| ✅ XP/Coin/Level System | Ready |
| ✅ Data Persistence | Ready |
| ✅ Quest Framework | Ready (needs lesson content) |
| ✅ NPC Dialogue System | Ready (needs scripts) |
| ✅ Shop System | Ready (needs item list) |
