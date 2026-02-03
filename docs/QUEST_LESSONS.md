# Quest Lesson Structure

## Overview

Each quest contains **100 lessons** organized into **10 thematic units** (10 lessons per unit).

---

## Physical Activity Quests (Both Presented to Users)

Users who score high on Physical Activity barriers are presented with **both** quests to choose from:

| Quest | Approach | Best For |
|-------|----------|----------|
| **ActiveAdventures** | Play-Based | Kids who want fun, games, spontaneous movement |
| **MissionPowerUp** | Body Science | Kids who want to understand how their body works, get stronger |

**Key Difference:** Same themes, different lens. ActiveAdventures = "Let's play!" vs MissionPowerUp = "Let's learn how your body gets powerful!"

---

## ActiveAdventures - 100 Lessons

**Approach:** Play-focused, fun, games, spontaneous movement

| Unit | Lessons | Theme | Focus |
|------|---------|-------|-------|
| 1 | 1-10 | Joy of Movement | Why movement is fun, body basics, feelings |
| 2 | 11-22 | Brain + Body + Outdoors | Movement boosts brain, body signals, nature exploration |
| 3 | 23-32 | Play & Games | What counts as play, inventing games, tag variations |
| 4 | 33-42 | Movement & Emotions | Moving when mad/happy, stretching for calm, mood matching |
| 5 | 43-52 | Movement All Day | Morning, lunch, after-school, bedtime, indoor moves |
| 6 | 53-62 | Confidence & Self-Worth | I move for me, brave tries, small wins, not needing to be best |
| 7 | 63-72 | Social Play | Solo play, with friends, teamwork, inclusion, cheering |
| 8 | 73-82 | Tools & Equipment | Balls, ropes, chalk, obstacle courses, backyard gear |
| 9 | 83-92 | Body Signals & Rest | Listening to body, tired vs. done, hurt vs. sore, breaks |
| 10 | 93-100 | Recovery & Body Ownership | Water, sleep, stretching, happy chemicals, "I'm the boss" |

---

## MissionPowerUp - 100 Lessons

**Approach:** Body science, understanding mechanics, getting stronger

| Unit | Lessons | Theme | Focus |
|------|---------|-------|-------|
| 1 | 1-10 | Joy of Movement | Why movement is fun, body basics, feelings |
| 2 | 11-22 | Brain + Body + Outdoors | Movement boosts brain, body signals, nature exploration |
| 3 | 23-32 | Play & Games | What counts as play, inventing games, tag variations |
| 4 | 33-42 | Movement & Emotions | Moving when mad/happy, stretching for calm, mood matching |
| 5 | 43-52 | Movement All Day | Morning, lunch, after-school, bedtime, indoor moves |
| 6 | 53-62 | Confidence & Self-Worth | I move for me, brave tries, small wins, not needing to be best |
| 7 | 63-72 | Social Play | Solo play, with friends, teamwork, inclusion, cheering |
| 8 | 73-82 | Tools & Equipment | Balls, ropes, chalk, obstacle courses, backyard gear |
| 9 | 83-92 | Body Signals & Rest | Listening to body, tired vs. done, hurt vs. sore, breaks |
| 10 | 93-100 | Recovery & Body Ownership | Water, sleep, stretching, happy chemicals, "I'm the boss" |

---

## Lesson Structure (Per Lesson)

Each lesson follows this format:

```
┌─────────────────────────────────────────────────────────────┐
│                     LESSON SCREEN                           │
│                                                             │
│  Quest: ActiveAdventures                                    │
│  Unit 1: Joy of Movement                                    │
│  Lesson 3 of 100                                            │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                                                     │   │
│  │              [Lesson Content Area]                  │   │
│  │                                                     │   │
│  │   Text, images, animations teaching the concept    │   │
│  │                                                     │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                TRIVIA QUESTION                      │   │
│  │                                                     │   │
│  │   "Why does moving make your brain happy?"         │   │
│  │                                                     │   │
│  │   ○ It makes you tired                             │   │
│  │   ○ It sends happy chemicals to your brain  ✓     │   │
│  │   ○ It makes you hungry                            │   │
│  │   ○ It doesn't do anything                         │   │
│  │                                                     │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  Rewards: 10 XP + 5 Coins (correct answer)                 │
│                                                             │
│                    [ Next Lesson ]                          │
└─────────────────────────────────────────────────────────────┘
```

---

## Rewards Per Lesson

| Action | XP | Coins |
|--------|-----|-------|
| Complete lesson | 5 | 2 |
| Correct trivia answer | 10 | 5 |
| Complete unit (10 lessons) | 50 | 25 |
| Complete quest (100 lessons) | 500 | 250 |

---

## Data Structure

```lua
-- Lesson Structure
Lesson = {
    id = 1,
    questId = "ActiveAdventures",
    unitNumber = 1,
    unitTheme = "Joy of Movement",
    lessonNumber = 1,
    title = "Why Moving Feels Good",
    content = "When you move your body, something amazing happens...",
    trivia = {
        question = "Why does moving make your brain happy?",
        options = {
            "It makes you tired",
            "It sends happy chemicals to your brain",
            "It makes you hungry",
            "It doesn't do anything"
        },
        correctIndex = 2
    },
    rewards = {
        completion = {xp = 5, coins = 2},
        correctAnswer = {xp = 10, coins = 5}
    }
}

-- Unit Structure
Unit = {
    unitNumber = 1,
    theme = "Joy of Movement",
    lessonRange = {1, 10},
    focus = "Why movement is fun, body basics, feelings",
    completionBonus = {xp = 50, coins = 25}
}
```

---

## Other Quests (100 Lessons Each)

All 10 quests follow the same 100-lesson, 10-unit structure:

| Quest | Theme | Units TBD |
|-------|-------|-----------|
| BodyImageOdyssey | Body Image & Self-Esteem | Need content |
| FocusandFeel | Emotional Awareness | Need content |
| KindnessCrusaders | Anti-Bullying & Social Skills | Need content |
| MindfulBites | Mindful/Intuitive Eating | Need content |
| MindfulHeroAdventure | Mindfulness & Coping | Need content |
| MindQuest | Mental Health | Need content |
| NutriQuest | Nutrition | Need content |
| Resilience Adventure | Hope & Resilience | Need content |
