# Lumo's Word Race - Mini-Game Spec

## Overview

A competitive typing race where players type health-related words to move Lumo toward the finish line.

**Core Mechanic:** Each correct letter = 1 step forward

---

## Race Basics

| Element | How It Works |
|---------|--------------|
| Race Distance | 100 meters (or 100 "steps") |
| Movement | Each correct letter = 1 step forward |
| Goal | Reach finish line as FAST as possible |
| Score | Your completion TIME (lower = better) |

```
┌─────────────────────────────────────────────────────┐
│  🏁 TOPIC: Green Vegetables                         │
│                                                     │
│  ════════════════════════════════════════════════   │
│  🐉.......................................FINISH    │
│       ↑                                             │
│    LUMO (0m)                              (100m)    │
│                                                     │
│  ┌──────────────────────────────────────────────┐   │
│  │ Type here: broccoli_                         │   │
│  └──────────────────────────────────────────────┘   │
│                                                     │
│  ⏱️ 00:12.45      📏 34/100 steps                   │
│                                                     │
│  ✓ spinach (7)  ✓ kale (4)  ✓ broccoli (8)         │
└─────────────────────────────────────────────────────┘
```

---

## Difficulty Tiers

| Tier | Race Distance | Letters Needed | Target Time |
|------|---------------|----------------|-------------|
| Sprint | 50 steps | ~50 letters | < 30 sec |
| Dash | 100 steps | ~100 letters | < 60 sec |
| Marathon | 200 steps | ~200 letters | < 2 min |

---

## Race Modes

| Mode | Players | Description |
|------|---------|-------------|
| Solo | 1 | Practice, beat your own time |
| Ghost Race | 1 | Race your personal best |
| 1v1 Duel | 2 | Head-to-head showdown |
| Quick Race | 4 | Fast matchmaking, random topic |
| Grand Prix | 8 | Full lobby race |
| Tournament | 16-64 | Bracket elimination |
| Class Race | 2-30 | Private room (teachers/clinics) |

---

## Multiplayer Race Display

```
┌─────────────────────────────────────────────────────────────────┐
│  🏁 TOPIC: Proteins                          ⏱️ 00:34.21        │
│                                                                 │
│  DragonKid99    ════════════════════🐉━━━━━━━━━━━━━━━━ 78m     │
│  HealthHero42   ════════════════🐉━━━━━━━━━━━━━━━━━━━━ 67m     │
│  LumoFan2026    ══════════════🐉━━━━━━━━━━━━━━━━━━━━━━ 62m     │
│  YOU            ═══════════🐉━━━━━━━━━━━━━━━━━━━━━━━━━ 54m     │
│                                                        FINISH   │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ Type here: chicken_                                       │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                 │
│  ✓ eggs (4)  ✓ tofu (4)  ✓ salmon (6)  ✓ beans (5)            │
└─────────────────────────────────────────────────────────────────┘
```

---

## Skill-Based Matchmaking (ELO)

| Rank | ELO Range | Icon |
|------|-----------|------|
| Seedling | 0-499 | 🌱 |
| Sprout | 500-999 | 🌿 |
| Bloom | 1000-1499 | 🌸 |
| Tree | 1500-1999 | 🌳 |
| Dragon | 2000+ | 🐉 |

**ELO Changes:**
- Win = +15 to +30 (based on opponent rank)
- Lose = -10 to -20
- Top 3 in 8-player = gain ELO
- Bottom 2 = lose ELO

---

## Word Bank Topics

### NUTRITION

**🥩 Proteins**
```
chicken, turkey, beef, fish, salmon, tuna, eggs, tofu, beans,
lentils, nuts, almonds, cheese, yogurt, milk, shrimp, pork,
quinoa, tempeh, edamame, peanuts, cashews, walnuts, seeds,
sardines, lamb, duck, crab, lobster, hummus, cottage
```

**🌱 Plant Proteins**
```
tofu, tempeh, lentils, chickpeas, beans, quinoa, almonds,
peanuts, cashews, walnuts, hemp, chia, flax, edamame, hummus,
seitan, peas, oats, seeds, pistachios, sunflower, pumpkin,
soybeans, spirulina
```

**🥬 Green Vegetables**
```
broccoli, spinach, kale, lettuce, celery, cucumber, zucchini,
asparagus, peas, cabbage, chard, arugula, okra, leeks, bok choy,
parsley, cilantro, basil, mint, dill, greenbeans, artichoke,
watercress, collards, chives, scallions
```

**🥕 Orange Vegetables**
```
carrot, sweetpotato, pumpkin, squash, yam, butternut, acorn,
orangepepper, cantaloupe, apricot, mango, papaya, turmeric,
persimmon, nectarine
```

**🍎 Red Foods**
```
tomato, strawberry, raspberry, cherry, watermelon, apple,
beet, radish, pomegranate, cranberry, grape, pepper, rhubarb,
goji, redcabbage, redpotato, redlentils, kidney
```

**🫐 Purple Foods**
```
blueberry, blackberry, grape, plum, eggplant, fig, raisin,
prune, acai, elderberry, cabbage, potato, lavender, passionfruit
```

**🦴 Sources of Calcium**
```
milk, cheese, yogurt, sardines, salmon, tofu, almonds, broccoli,
kale, figs, oranges, edamame, beans, okra, collards, chia,
tahini, tempeh, kefir, fortified
```

**💧 Hydrating Foods**
```
watermelon, cucumber, lettuce, celery, tomato, strawberry,
cantaloupe, peach, orange, grapefruit, zucchini, radish,
pepper, spinach, broth, coconut, soup, popsicle, melon
```

**🌾 Whole Grains**
```
oats, oatmeal, quinoa, rice, barley, bulgur, farro, millet,
buckwheat, wheat, bread, pasta, couscous, amaranth, sorghum,
spelt, rye, corn, popcorn, tortilla, cereal, granola, crackers
```

**🍬 Healthy Snacks**
```
apple, banana, orange, grapes, berries, carrots, celery, hummus,
yogurt, cheese, nuts, almonds, popcorn, granola, crackers,
edamame, smoothie, veggies, fruit, raisins, pretzels, ricecakes
```

### FITNESS

**💪 Muscle Groups**
```
biceps, triceps, deltoids, abs, core, quads, hamstrings, glutes,
calves, chest, back, shoulders, lats, traps, forearms, obliques,
pecs, rhomboids, hip, neck, abdominals
```

**🏋️ Push Exercises**
```
pushup, press, dips, plank, pike, extension, incline, decline,
wall push, diamond, wide, narrow, bench, overhead, chest
```

**🚣 Pull Exercises**
```
pullup, chinup, row, curl, deadlift, shrug, lat, cable, seated,
bent, hammer, reverse, face pull, inverted
```

**🏃 Cardio Exercises**
```
running, jogging, walking, swimming, biking, dancing, jumping,
skipping, hiking, skating, rowing, climbing, sprinting, aerobics,
zumba, kickboxing, elliptical, burpees, jumprope
```

**🤸 Types of Exercise**
```
cardio, strength, flexibility, balance, endurance, aerobic,
stretching, yoga, pilates, hiit, circuit, crossfit, swimming,
running, lifting, calisthenics, sports, dance, martial arts
```

**🧘 Relaxation Techniques**
```
breathing, meditation, yoga, stretching, visualization, bodyscan,
mindfulness, grounding, journaling, music, coloring, reading,
bath, massage, rest, nap, quiet, nature, aromatherapy, sleep
```

**🤸 Stretches**
```
hamstring, quad, calf, butterfly, cobra, lunge, twist, pigeon,
shoulder, tricep, neck, hip, side, forward, seated, standing,
child pose, downward dog, cat cow, toe touch
```

**🎯 Balance Moves**
```
tree pose, flamingo, one leg, heel toe, wobble, yoga, warrior,
eagle, dancer, stork, airplane, half moon, standing, single leg
```

**🏆 Sports**
```
soccer, basketball, baseball, football, tennis, volleyball,
swimming, gymnastics, hockey, lacrosse, golf, bowling, skiing,
skating, track, wrestling, karate, judo, archery, rugby, surfing
```

### WELLNESS

**😊 Feelings**
```
happy, sad, angry, scared, excited, nervous, calm, peaceful,
frustrated, proud, grateful, worried, surprised, confused,
hopeful, tired, energetic, lonely, loved, brave, shy, curious,
joyful, anxious, relaxed, content, cheerful, overwhelmed
```

**🧠 Coping Skills**
```
breathing, talking, walking, drawing, music, journaling, rest,
exercise, hugging, counting, grounding, stretching, meditation,
coloring, reading, nature, friends, family, playing, dancing,
singing, crafts, games, pets, bath, sleep, crying, laughing
```

**💤 Sleep Helpers**
```
routine, dark, cool, quiet, reading, bath, stretching, breathing,
meditation, white noise, lavender, bedtime, pajamas, blanket,
pillow, calm, comfortable, wind down, gratitude, no screens
```

**🫂 Kind Actions**
```
sharing, helping, listening, smiling, compliment, thankyou,
please, sorry, hug, highfive, including, encouraging, caring,
donating, volunteering, forgiving, patience, empathy, support,
cheering, holding door, writing notes
```

---

## Power-Ups

| Power-Up | Effect | Cost |
|----------|--------|------|
| Head Start | Begin at 10m instead of 0 | 75 coins |
| Double Steps | 2x movement for 5 seconds | 100 coins |
| Hint Peek | Shows 5 valid words briefly | 50 coins |
| Forgiveness | No penalty for 3 wrong words | 60 coins |

---

## Penalties

| Event | Penalty |
|-------|---------|
| Wrong word | 0.5 second freeze |
| Repeated word | No movement (already used!) |
| Misspelling | No movement + brief shake |

---

## Rewards

### Race Rewards

| Achievement | Reward |
|-------------|--------|
| First race completed | 25 coins |
| Beat personal best | 50 XP + 25 coins |
| Finish under 30 sec (Sprint) | 75 coins |
| Finish under 60 sec (Dash) | 100 coins |
| 100% accuracy race | 150 coins + badge |
| Complete all topics | Special Lumo skin |
| Daily challenge top 10 | 200 coins |

### Placement Rewards (Multiplayer)

| Place | Coins | XP | Bonus |
|-------|-------|-----|-------|
| 1st | 500 | 200 | Trophy + Title |
| 2nd | 300 | 150 | Silver badge |
| 3rd | 200 | 100 | Bronze badge |
| 4th-8th | 50 | 50 | Participation |

---

## Grand Prix Format (8 Players)

```
RACE 1: Green Vegetables     → Points: 8,7,6,5,4,3,2,1
RACE 2: Cardio Exercises     → Points: 8,7,6,5,4,3,2,1
RACE 3: Feelings/Emotions    → Points: 8,7,6,5,4,3,2,1
RACE 4: Proteins             → Points: 8,7,6,5,4,3,2,1
────────────────────────────────────────────────────────
FINAL STANDINGS: Most points wins Grand Prix! 🏆
```

---

## Weekly Tournament

```
BRACKET (32 players)

Round 1 (32→16):  Best of 1
Round 2 (16→8):   Best of 1
Quarterfinals:    Best of 3
Semifinals:       Best of 3
FINALS:           Best of 5

Entry: 100 coins
Prize Pool: 2,500 coins distributed to top 4
```

---

## Class Race Mode (Private Lobbies)

For clinics, schools, family groups.

| Feature | Details |
|---------|---------|
| Create Room | Teacher/parent generates code |
| Join | Kids enter 6-digit code |
| Capacity | 2-30 players |
| Topic Selection | Host picks from unlocked topics |
| Moderation | Host can kick, pause, restart |
| Results | Exportable leaderboard (for clinics) |
| No Wagers | Coins disabled in private rooms |

**Use Cases:**
- Clinic waiting room competition
- Classroom brain break
- Family game night
- Birthday party activity

---

## Social Features

### Safe Chat (Roblox filtered)
- Pre-set quick phrases only
- "Good race!" / "Nice word!" / "Rematch?" / "GG"
- No free typing (child safety)

### Friends
- Add friends after races
- See friends online
- Challenge friends to 1v1
- Friends leaderboard

### Emotes (During Race)

| Emote | Trigger |
|-------|---------|
| 🎉 | Finish first |
| 💪 | 10-word streak |
| 🔥 | Personal best |
| 😅 | Wrong word |
| 👏 | Opponent finishes |

---

## Lumo Customization (Unlockables)

### Skins

| Skin | How to Unlock |
|------|---------------|
| Default Lumo | Free |
| Golden Lumo | Win 50 races |
| Rainbow Lumo | Win 10 Grand Prix |
| Fire Lumo | Reach Dragon rank |
| Ice Lumo | 100% accuracy 25 times |
| Galaxy Lumo | Win a Tournament |
| Veggie Lumo | Complete all Nutrition topics |
| Muscle Lumo | Complete all Fitness topics |

### Trails
Sparkles, flames, hearts, stars, leaves, bubbles
- Earned through achievements or coin purchase

### Victory Dances
- Unlocked by winning streaks
- Play automatically when you finish 1st

---

## Leaderboards

### Global Leaderboards

| Board | Tracks |
|-------|--------|
| Fastest Ever | Best time per topic (all-time) |
| Daily Champions | Most wins today |
| Weekly Warriors | Most wins this week |
| Accuracy Kings | Highest avg accuracy |
| Word Masters | Most unique words typed |
| ELO Rankings | Top 100 by skill rating |

### Personal Stats

```
Total Races: 247
Wins: 89 (36%)
Best Finish: 1st (x89)
Favorite Topic: Green Vegetables
Fastest Time: 00:38.12 (Proteins)
Words Typed: 4,892
Letters Typed: 31,456
Longest Win Streak: 7
Current ELO: 1,247 (Bloom 🌸)
```

---

## Quest Integration

| Completed in HealthQuest | Unlocks in Word Race |
|--------------------------|----------------------|
| Mindful Bites Unit 1-2 | Healthy Snacks, Fruits |
| Mindful Bites Unit 3-5 | Vegetables (all colors) |
| Mindful Bites Unit 6-10 | Proteins, Grains, Calcium |
| Active Adventures Unit 1-3 | Cardio, Sports |
| Active Adventures Unit 4-7 | Muscles, Exercises |
| Active Adventures Unit 8-10 | Stretches, Balance |
| Focus & Feel | Relaxation, Coping, Feelings |
| Kindness Crusaders | Kind Actions, Emotions |

---

## Anti-Cheat Measures

| Issue | Solution |
|-------|----------|
| Auto-typers/bots | Server validates typing speed (max 12 chars/sec) |
| Word lists | Words checked server-side, not client |
| Lag exploitation | Server timestamp for all input |
| Alt accounts | Matchmaking considers account age |

---

## Monetization

| Item | Robux | Notes |
|------|-------|-------|
| Coin Pack (500) | 75 | For power-ups |
| Coin Pack (2000) | 250 | Better value |
| Premium Skin Bundle | 150 | 3 exclusive Lumos |
| Tournament Entry | Free or 100 coins | Prize pool funded |
| Private Room (30 min) | 50 coins | For groups |

**Note:** Core gameplay always free — cosmetics only

---

## Example Race

**Topic:** Green Vegetables
**Distance:** 100 steps

```
Player types:
- spinach (7 letters) → 7 steps → 7m
- kale (4) → 4 steps → 11m
- broccoli (8) → 8 steps → 19m
- lettuce (7) → 7 steps → 26m
- celery (6) → 6 steps → 32m
- cucumber (8) → 8 steps → 40m
- zucchini (8) → 8 steps → 48m
- peas (4) → 4 steps → 52m
- cabbage (7) → 7 steps → 59m
- chard (5) → 5 steps → 64m
- arugula (7) → 7 steps → 71m
- okra (4) → 4 steps → 75m
- asparagus (9) → 9 steps → 84m
- mint (4) → 4 steps → 88m
- basil (5) → 5 steps → 93m
- dill (4) → 4 steps → 97m
- leeks (5) → 5 steps → 102m 🏁 FINISH!

⏱️ TIME: 00:52.18
📝 17 words | 102 letters | 100% accuracy
```
