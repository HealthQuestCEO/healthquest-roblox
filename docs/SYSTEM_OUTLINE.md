# HEALTHQUEST: LUMO'S LAND
## Complete System Outline

---

## PROJECT STRUCTURE

```
healthquest-roblox/
│
├── docs/                          # Design Documentation (COMPLETE)
│   ├── BARRIER_ASSESSMENT.md
│   ├── CARE_LOOP.md
│   ├── GAME_DESIGN.md
│   ├── QUEST_LESSONS.md
│   ├── SMART_GOALS.md
│   ├── SYSTEM_OUTLINE.md          # This file
│   └── MINI_GAME_*.md             # 8 mini-game specs
│
├── data/                          # Game Content (NEEDS YOUR JSON)
│   ├── quests/                    # Quest lesson content
│   │   ├── ActiveAdventures.json
│   │   ├── MissionPowerUp.json
│   │   ├── BodyImageOdyssey.json
│   │   ├── FocusandFeel.json
│   │   ├── KindnessCrusaders.json
│   │   ├── MindfulBites.json
│   │   ├── MindfulHeroAdventure.json
│   │   ├── MindQuest.json
│   │   ├── NutriQuest.json
│   │   └── ResilienceAdventure.json
│   │
│   └── npcs/                      # NPC dialogue content
│       ├── SunnyMeadow/           # World 1 NPCs
│       ├── MindfulMountain/       # World 2 NPCs
│       ├── NutritionVillage/      # World 3 NPCs
│       ├── ActiveIsland/          # World 4 NPCs
│       ├── FriendshipForest/      # World 5 NPCs
│       └── ResilienceRealm/       # World 6 NPCs
│
└── src/                           # Roblox Game Code (TO BUILD)
    ├── ServerScriptService/
    ├── ReplicatedStorage/
    ├── StarterGui/
    └── Workspace/
```

---

# PART 1: CORE SYSTEMS

---

## 1. PLAYER PROGRESSION SYSTEM

### 1.1 XP & Leveling

| Component | Status | Details |
|-----------|--------|---------|
| Level Cap | ✅ Designed | 50 levels |
| XP Curve | ✅ Designed | 200 XP (Lv1) → 5,000 XP (Lv50) |
| Total XP to Max | ✅ Designed | 86,500 XP |
| Daily Caps | ✅ Designed | ~600 XP max/day |

**XP Thresholds:**
```lua
local XP_PER_LEVEL = {
    [1] = 200, [2] = 200, [3] = 200, [4] = 200, [5] = 200,      -- 1,000 total
    [6] = 350, [7] = 350, [8] = 350, [9] = 350, [10] = 350,     -- 2,750 total
    [11] = 500, [12] = 500, [13] = 500, [14] = 500, [15] = 500, -- 5,250 total
    [16] = 750, [17] = 750, [18] = 750, [19] = 750, [20] = 750, -- 9,000 total
    [21] = 1000, [22] = 1000, [23] = 1000, [24] = 1000, [25] = 1000, -- 14,000 total
    [26] = 1500, [27] = 1500, [28] = 1500, [29] = 1500, [30] = 1500, -- 21,500 total
    [31] = 2000, [32] = 2000, [33] = 2000, [34] = 2000, [35] = 2000, -- 31,500 total
    [36] = 2500, [37] = 2500, [38] = 2500, [39] = 2500, [40] = 2500, -- 44,000 total
    [41] = 3500, [42] = 3500, [43] = 3500, [44] = 3500, [45] = 3500, -- 61,500 total
    [46] = 5000, [47] = 5000, [48] = 5000, [49] = 5000, [50] = 5000  -- 86,500 total
}
```

### 1.2 Daily XP Caps

| Activity | XP/Action | Daily Limit | Max XP |
|----------|-----------|-------------|--------|
| Quest Lessons | 50 | 5 lessons | 250 |
| Care Loop (emotion) | 10 | 4 guesses | 40 |
| Care Loop (feed/water/clean) | 5 | 6 actions | 30 |
| NPC Conversations | 15-25 | 5 convos | 100 |
| Mini-Games (combined) | varies | cap | 150 |
| Daily Login | 25 | 1 | 25 |
| **TOTAL DAILY MAX** | | | **~600** |

### 1.3 Coins (Currency)

| Source | Coins |
|--------|-------|
| Quest Lesson | 50 |
| Care Loop (correct) | 5 |
| NPC Conversation | 10 |
| Mini-Game | 10-50 |
| Daily Login | 25 |
| Level Up Bonus | 100 |

---

## 2. UNLOCK PROGRESSION

### 2.1 Castle Rooms (13 + Classroom)

| Level | Room | Nook Category Unlocks |
|-------|------|----------------------|
| 1 | Bedroom | Basic Decor, Basic Outfits, Basic Lumo |
| 1 | Classroom | (Quest lessons) |
| 3 | Kitchen | Kitchen Furniture, Chef Outfits |
| 5 | Living Room | Living Room Decor, Cozy Outfits |
| 7 | Bathroom | Bathroom Items, Spa Items |
| 10 | Garden | Garden Decor, Outdoor Outfits |
| 13 | Library | Books & Shelves, Scholar Outfits |
| 16 | Game Room | Gaming Furniture, Gamer Outfits |
| 20 | Art Studio | Art Supplies, Artist Outfits |
| 24 | Music Room | Instruments, Musician Outfits |
| 28 | Gym | Gym Equipment, Athletic Outfits |
| 32 | Meditation Room | Zen Decor, Meditation Outfits |
| 40 | Trophy Hall | Trophy Cases, Champion Outfits |
| 50 | Legendary Suite | Legendary Decor, Legendary Items |

### 2.2 World Portals (6 Worlds)

| Level | World | NPCs | Theme |
|-------|-------|------|-------|
| 1 | Sunny Meadow | 9 | Introduction |
| 10 | Mindful Mountain | 9 | Mental Health |
| 15 | Nutrition Village | 9 | Healthy Eating |
| 20 | Active Island | 9 | Physical Activity |
| 30 | Friendship Forest | 9 | Social Skills |
| 40 | Resilience Realm | 9 | Hope & Confidence |

### 2.3 Mini-Game Portals

| Mini-Game | Unlock Requirement |
|-----------|-------------------|
| Word Race | Always available |
| Energy Dash | Always available |
| Wellness Garden | Always available |
| Reframe It | Always available |
| Category Crush | Always available |
| Bubble Burst | Always available |
| **Food Lab** | **Kitchen (Level 3)** |
| **Move & Groove** | **Gym (Level 28)** |

---

## 3. BARRIER ASSESSMENT SYSTEM

### 3.1 Flow
```
Player Joins → 12 Questions → Weighted Scoring → Top 3 Barriers → SMART Goal Selection → Quest Assignment
```

### 3.2 Questions (12 Total)

| # | Question | Barrier Measured |
|---|----------|------------------|
| 1 | How often do you eat fruits/veggies? | Nutrition |
| 2 | Do you eat when bored/sad? | Mindful Eating |
| 3 | How do you feel about your body? | Body Image |
| 4 | How often do you play/exercise? | Physical Activity |
| 5 | How do you feel most days? | Mental Health |
| 6 | Can you name your feelings? | Emotions |
| 7 | What do you do when stressed? | Mindfulness |
| 8 | Have you been bullied/left out? | Anti-Bullying |
| 9 | Do you bounce back from hard things? | Resilience |
| 10 | Do you have goals you're working on? | Motivation |
| 11 | How do you feel trying new things? | Resilience |
| 12 | Do you ask for help when needed? | Social Support |

### 3.3 Scoring

- Each answer: a=1, b=2, c=3, d=4 (lower = more barrier)
- Weights: 1.0x - 1.5x per barrier category
- Top 3 barriers identified → Quest options presented

### 3.4 Quest Routing

| Barrier | Quest Assigned |
|---------|----------------|
| Physical Activity (play) | ActiveAdventures |
| Physical Activity (body) | MissionPowerUp |
| Body Image | BodyImageOdyssey |
| Emotions | FocusandFeel |
| Anti-Bullying | KindnessCrusaders |
| Mindful Eating | MindfulBites |
| Mindfulness | MindfulHeroAdventure |
| Mental Health | MindQuest |
| Nutrition | NutriQuest |
| Resilience | ResilienceAdventure |

---

## 4. LUMO CARE LOOP SYSTEM

### 4.1 Physical Needs (72-Hour Decay)

| Need | Start | Decay Rate | Critical |
|------|-------|------------|----------|
| Hunger | 100% | -1.4%/hour | ≤10% |
| Thirst | 100% | -1.4%/hour | ≤10% |
| Hygiene | 100% | -1.4%/hour | ≤15% |

**If all needs at 0% for 72 hours → Lumo disappears!**

### 4.2 Emotions (10 States, Priority Order)

| Priority | Emotion | Trigger Condition |
|----------|---------|-------------------|
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

### 4.3 Emotion Guessing Game

1. Lumo shows emotion state
2. Player guesses emotion
3. Correct: +5 coins, +10 XP (max 4/day)
4. Wrong: Hint given, try again
5. Go to Recovery Den to help

### 4.4 Recovery Den

- **Help Body:** Feed, Water, Clean
- **Helper Zone:** Emotional items (yoga mat, teddy, tablet)
- After care: Needs reset to 50%

---

## 5. QUEST SYSTEM

### 5.1 Structure

| Component | Count |
|-----------|-------|
| Total Quests | 10 |
| Lessons per Quest | 100 |
| Units per Quest | 10 |
| Lessons per Unit | 10 |
| Questions per Lesson | 5 |

### 5.2 Ten Quests

1. **ActiveAdventures** - Play, movement, fun
2. **MissionPowerUp** - Body science, getting stronger
3. **BodyImageOdyssey** - Self-esteem, body positivity
4. **FocusandFeel** - Recognizing feelings
5. **KindnessCrusaders** - Social skills, inclusion
6. **MindfulBites** - Hunger cues, enjoying food
7. **MindfulHeroAdventure** - Breathing, coping
8. **MindQuest** - Stress, emotional regulation
9. **NutriQuest** - Healthy foods
10. **ResilienceAdventure** - Hope, bouncing back

### 5.3 Quest JSON Structure (NEEDED)

```json
{
  "questId": "ActiveAdventures",
  "questName": "Active Adventures",
  "units": [
    {
      "unitId": 1,
      "unitName": "Getting Started with Movement",
      "lessons": [
        {
          "lessonId": 1,
          "lessonName": "Why Moving Matters",
          "questions": [
            {
              "questionId": 1,
              "type": "multiple_choice",
              "question": "What happens to your body when you exercise?",
              "options": [
                "Your heart gets stronger",
                "Your bones disappear",
                "You shrink",
                "Nothing"
              ],
              "correctAnswer": 0,
              "explanation": "Exercise makes your heart muscle stronger!"
            }
          ]
        }
      ]
    }
  ]
}
```

---

## 6. NPC WORLD SYSTEM

### 6.1 Structure

| Component | Count |
|-----------|-------|
| Worlds | 6 |
| NPCs per World | 9 |
| Total NPCs | 54 |
| Conversations per NPC | 10 |
| Total Conversations | 540 |

### 6.2 NPC JSON Structure (NEEDED)

```json
{
  "world": "SunnyMeadow",
  "npcId": "sunny_rabbit",
  "npcName": "Rosie the Rabbit",
  "personality": "Cheerful and energetic",
  "appearance": "Pink rabbit with a flower crown",
  "conversations": [
    {
      "conversationId": 1,
      "unlockLevel": 1,
      "greeting": "Oh hello there, new friend! I'm Rosie!",
      "branches": [
        {
          "playerChoice": "Hi Rosie! What do you do here?",
          "npcResponse": "I tend to the flower garden! Want to help?",
          "nextBranches": [
            {
              "playerChoice": "Sure, I'd love to help!",
              "npcResponse": "Wonderful! Gardening is great exercise!",
              "healthTip": "Moving your body helps your heart stay strong.",
              "reward": { "xp": 15, "coins": 10 }
            },
            {
              "playerChoice": "Maybe another time",
              "npcResponse": "That's okay! Come back anytime!",
              "reward": { "xp": 10, "coins": 5 }
            }
          ]
        }
      ]
    }
  ]
}
```

---

## 7. THE NOOK (SHOP SYSTEM)

### 7.1 Categories by Unlock Level

| Level | Category | Example Items |
|-------|----------|---------------|
| 1 | Basic Decor | Simple Bed (100), Basic Rug (50), Small Lamp (75) |
| 1 | Basic Outfits | T-Shirt Pack (100), Basic Pants (75), Sneakers (50) |
| 1 | Basic Lumo | Simple Collar (50), Tiny Bow (75) |
| 3 | Kitchen | Cute Stove (200), Mini Fridge (250), Kitchen Table (150) |
| 3 | Chef Outfits | Chef Hat (150), Apron (100), Chef Coat (200) |
| 5 | Living Room | Cozy Couch (300), Coffee Table (150), Bookshelf (200) |
| 7 | Bathroom | Bathtub (250), Vanity Mirror (150), Towel Rack (75) |
| 10 | Garden | Flower Pot (75), Garden Bench (200), Bird Bath (250) |
| 13 | Library | Reading Chair (200), Tall Bookcase (350), Desk Lamp (100) |
| 16 | Game Room | Bean Bag (150), Game Console (400), Poster Set (100) |
| 20 | Art Studio | Easel (200), Paint Set (150), Art Table (250) |
| 24 | Music Room | Piano (500), Guitar Stand (200), Music Stand (100) |
| 28 | Gym | Yoga Mat (100), Dumbbells (200), Treadmill (400) |
| 32 | Meditation | Zen Fountain (300), Floor Cushion (150), Incense (50) |
| 40 | Trophy | Trophy Case (400), Medal Display (250), Champion Banner (300) |
| 50 | Legendary | Golden Throne (2000), Crystal Chandelier (1500), Dragon Statue (2500) |

---

## 8. LUMO PET SYSTEM

### 8.1 Evolution Stages

| Stage | Name | Unlock Requirement |
|-------|------|-------------------|
| 1 | Egg | Starting state |
| 2 | Baby | Hatch after first care session |
| 3 | Young | Level 10 + 50 care sessions |
| 4 | Adult | Level 25 + 200 care sessions |
| 5 | Legendary | Level 50 + complete special quest |

### 8.2 Dragon Variants

| Type | How to Get |
|------|------------|
| Classic Lumo (teal) | Free starter |
| Color variants | Coins or Robux |
| Elemental dragons | Achievement unlocks |
| Legendary dragons | Complete full quest lines |
| Seasonal dragons | Limited time events |

---

# PART 2: MINI-GAMES (8 Total)

---

| # | Game | Focus | Unlock | Spec Complete |
|---|------|-------|--------|---------------|
| 1 | Word Race | Typing/vocabulary | Always | ✅ |
| 2 | Energy Dash | Nutrition runner | Always | ✅ |
| 3 | Wellness Garden | Daily habits | Always | ✅ |
| 4 | Reframe It | CBT/positive thinking | Always | ✅ |
| 5 | Category Crush | Categorization | Always | ✅ |
| 6 | Bubble Burst | Nutrition identification | Always | ✅ |
| 7 | Food Lab | MyPlate cooking | Kitchen (Lv 3) | ✅ |
| 8 | Move & Groove | HIIT workouts | Gym (Lv 28) | ✅ |

---

# PART 3: CONTENT NEEDED FROM YOU

---

## QUEST CONTENT

| Quest | Lessons | Questions | Status |
|-------|---------|-----------|--------|
| ActiveAdventures | 100 | 500 | ❓ Need JSON |
| MissionPowerUp | 100 | 500 | ❓ Need JSON |
| BodyImageOdyssey | 100 | 500 | ❓ Need JSON |
| FocusandFeel | 100 | 500 | ❓ Need JSON |
| KindnessCrusaders | 100 | 500 | ❓ Need JSON |
| MindfulBites | 100 | 500 | ❓ Need JSON |
| MindfulHeroAdventure | 100 | 500 | ❓ Need JSON |
| MindQuest | 100 | 500 | ❓ Need JSON |
| NutriQuest | 100 | 500 | ❓ Need JSON |
| ResilienceAdventure | 100 | 500 | ❓ Need JSON |
| **TOTAL** | **1,000** | **5,000** | |

## NPC CONTENT

| World | NPCs | Conversations | Status |
|-------|------|---------------|--------|
| Sunny Meadow | 9 | 90 | ❓ Need JSON |
| Mindful Mountain | 9 | 90 | ❓ Need JSON |
| Nutrition Village | 9 | 90 | ❓ Need JSON |
| Active Island | 9 | 90 | ❓ Need JSON |
| Friendship Forest | 9 | 90 | ❓ Need JSON |
| Resilience Realm | 9 | 90 | ❓ Need JSON |
| **TOTAL** | **54** | **540** | |

## NOOK ITEMS

| Category | Items Needed | Status |
|----------|--------------|--------|
| Room Furniture | ~100 items | ❓ Need list |
| Avatar Outfits | ~50 items | ❓ Need list |
| Lumo Accessories | ~30 items | ❓ Need list |
| Dragon Variants | ~10 variants | ❓ Need list |

---

# PART 4: BUILD ORDER

---

## Phase 1: Core Framework
1. ✅ Data persistence system
2. ✅ XP/Level/Coin system
3. ✅ Daily caps system
4. ✅ Player data structure

## Phase 2: World & Castle
1. Main Meadow environment
2. Castle exterior
3. Castle rooms (locked/unlocked states)
4. Room unlock system
5. World portal visuals (locked/unlocked)

## Phase 3: Lumo Pet
1. Lumo model & animations
2. Care Loop needs system
3. Emotion state machine
4. Emotion guessing game
5. Recovery Den

## Phase 4: Onboarding
1. First-time player flow
2. Barrier Assessment UI
3. Scoring & routing
4. SMART goal selection
5. Quest assignment

## Phase 5: Quest System
1. Classroom environment
2. Lesson UI (questions, answers)
3. Progress tracking
4. Unit/Quest completion rewards
5. **← NEEDS QUEST JSON DATA**

## Phase 6: NPC Worlds
1. 6 world environments
2. NPC placement
3. Dialogue system
4. Branching conversations
5. **← NEEDS NPC JSON DATA**

## Phase 7: Shop
1. Nook building
2. Category display
3. Purchase system
4. Inventory system
5. **← NEEDS ITEM LIST**

## Phase 8: Mini-Games
1. Word Race
2. Energy Dash
3. Wellness Garden
4. Reframe It
5. Category Crush
6. Bubble Burst
7. Food Lab (locked to Kitchen)
8. Move & Groove (locked to Gym)

## Phase 9: Polish
1. Sound design
2. Visual effects
3. Tutorials
4. Achievements
5. Streaks & bonuses

---

# PART 5: JSON FILE TEMPLATES

---

## Quest JSON Template

Save as: `data/quests/[QuestName].json`

```json
{
  "questId": "ActiveAdventures",
  "questName": "Active Adventures",
  "description": "Learn about movement and play!",
  "totalLessons": 100,
  "units": [
    {
      "unitId": 1,
      "unitName": "Unit 1: Getting Moving",
      "lessons": [
        {
          "lessonId": 1,
          "lessonName": "Lesson 1: Why Move?",
          "questions": [
            {
              "id": 1,
              "type": "multiple_choice",
              "question": "Your question here?",
              "options": ["A", "B", "C", "D"],
              "correct": 0,
              "explanation": "Why this is correct"
            },
            {
              "id": 2,
              "type": "true_false",
              "question": "Statement here",
              "correct": true,
              "explanation": "Why"
            },
            {
              "id": 3,
              "type": "matching",
              "pairs": [
                {"left": "Heart", "right": "Pumps blood"},
                {"left": "Lungs", "right": "Breathe air"}
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## NPC JSON Template

Save as: `data/npcs/[WorldName]/[npc_id].json`

```json
{
  "npcId": "rosie_rabbit",
  "name": "Rosie the Rabbit",
  "world": "SunnyMeadow",
  "personality": "Cheerful, energetic, loves flowers",
  "appearance": {
    "species": "rabbit",
    "color": "pink",
    "accessories": ["flower crown"]
  },
  "location": {"x": 100, "y": 0, "z": 50},
  "conversations": [
    {
      "id": 1,
      "unlockLevel": 1,
      "title": "First Meeting",
      "dialogue": [
        {
          "speaker": "npc",
          "text": "Oh hello! I'm Rosie! Welcome to Sunny Meadow!"
        },
        {
          "speaker": "player_choice",
          "options": [
            {
              "text": "Hi Rosie! Nice to meet you!",
              "next": "friendly_response"
            },
            {
              "text": "What is this place?",
              "next": "explain_meadow"
            }
          ]
        },
        {
          "id": "friendly_response",
          "speaker": "npc",
          "text": "So nice to meet you too! I hope we become great friends!",
          "healthTip": "Making friends helps us feel happy and connected.",
          "reward": {"xp": 20, "coins": 10},
          "end": true
        },
        {
          "id": "explain_meadow",
          "speaker": "npc",
          "text": "This is Sunny Meadow! It's where all new friends start their wellness journey!",
          "reward": {"xp": 15, "coins": 10},
          "end": true
        }
      ]
    }
  ]
}
```

---

# SUMMARY

| Category | Status |
|----------|--------|
| Game Design | ✅ Complete |
| Systems Design | ✅ Complete |
| XP/Leveling | ✅ Complete |
| Unlock Progression | ✅ Complete |
| Daily Caps | ✅ Complete |
| Barrier Assessment | ✅ Complete |
| Care Loop | ✅ Complete |
| Quest Framework | ✅ Complete |
| NPC Framework | ✅ Complete |
| Shop Framework | ✅ Complete |
| Mini-Game Specs (8) | ✅ Complete |
| **Quest Content (JSON)** | ❓ **NEED FROM YOU** |
| **NPC Content (JSON)** | ❓ **NEED FROM YOU** |
| **Item Lists** | ❓ **NEED FROM YOU** |

---

**Next Step:** Share your Quest and NPC JSON files and I'll integrate them into the project structure.
