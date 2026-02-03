# HealthQuest Wellness Barrier Assessment

## Overview

The Wellness Barrier Assessment identifies challenges children face in achieving well-being across multiple areas and prioritizes their wellness path (quest) based on these barriers.

---

## Assessment Questions (12 Total)

| Q# | Wellness Area | Question | Scoring Direction |
|----|---------------|----------|-------------------|
| 1 | Mental Health & Emotional Well-being | How often do you feel sad, stressed, or worried — even if you're not sure why? | Higher = More Barrier |
| 2 | Physical Activity & Motivation | How often do you enjoy playing outside or doing activities like sports, dancing, or running around? | Lower = More Barrier |
| 3 | Nutrition & Healthy Eating Habits | How often do you include fruits or vegetables in your snacks or meals? | Lower = More Barrier |
| 4 | Resilience & Confidence | When things get hard, how often do you feel like giving up? | Higher = More Barrier |
| 5 | Mindfulness & Coping Strategies | How often do you take a few deep breaths or try to calm yourself down when you're upset? | Lower = More Barrier |
| 6 | Intuitive Eating & Body Awareness | How often do you notice when your body feels full and stop eating? | Lower = More Barrier |
| 7 | Bullying & Social Confidence | How often do you feel like someone is mean to you or hurts your feelings? | Higher = More Barrier |
| 8 | Psychological Factors & Weight Management | How often do you feel unhappy with your body or how it looks? | Higher = More Barrier |
| 9 | Motivation & Setting Goals | How often do you find it hard to keep going when you set a goal for yourself? | Higher = More Barrier |
| 10 | Social Relationships & Self-Worth | How often do you feel left out or like it's hard to find someone to talk to? | Higher = More Barrier |
| 11 | Mindful Eating & Enjoying Food | How often do you enjoy the taste of your food and pay attention to it while eating? | Lower = More Barrier |
| 12 | Hope & Future Optimism | How often do you feel hopeful about what you can do in the future? | Lower = More Barrier |

---

## Answer Options & Base Scoring

### For "Higher = More Barrier" Questions (1, 4, 7, 8, 9, 10)
| Answer | Score |
|--------|-------|
| a) Never | 1 |
| b) Rarely | 2 |
| c) Sometimes | 3 |
| d) Always | 4 |

### For "Lower = More Barrier" Questions (2, 3, 5, 6, 11, 12)
| Answer | Score |
|--------|-------|
| a) Always | 1 |
| b) Sometimes | 2 |
| c) Rarely | 3 |
| d) Never | 4 |

**Score Range:** 12 (minimal barriers) to 48 (maximum barriers)

---

## Barrier Categories

### 8 Barrier Categories with Question Mapping

| Category | Questions | Max Points | Weight | Quest Path |
|----------|-----------|------------|--------|------------|
| Mental Health Barriers | 1, 9, 10 | 12 | 1.5x | MindfulMoods |
| Hope & Resilience | 4, 9, 12 | 12 | 1.5x | HopeHarbor |
| Psychological Factors & Weight Management | 1, 8, 9 | 12 | 1.4x | BodyPositive |
| Physical Activity | 2, 4, 9 | 12 | 1.4x | ActiveAdventures |
| Mindfulness & Psychological Factors | 5, 9, 12 | 12 | 1.4x | ZenZone |
| Nutrition & Mindful Eating | 3, 6, 11 | 12 | 1.3x | NutritionNinja |
| Anti-Bullying | 7, 10 | 8 | 1.3x | FriendshipForge |
| Intuitive Eating & Body Awareness | 6, 8, 11 | 12 | 1.2x | BodyWise |

---

## Scoring Algorithm

### Step 1: Calculate Raw Category Score
```
Raw Score = Sum of question scores in category
```

### Step 2: Calculate Average Score
```
Average Score = Raw Score / Number of Questions in Category
```

### Step 3: Apply Weight
```
Weighted Score = Average Score × Category Weight
```

### Step 4: Rank Categories
Sort all 8 categories by Weighted Score (highest = biggest barrier)

### Step 5: Identify Top 3 Barriers
The 3 categories with highest weighted scores become the user's priority barriers.

---

## Scoring Example

**Sample Answers:**
- Q1: c (3), Q2: b (2), Q3: c (3), Q4: c (3)
- Q5: c (3), Q6: b (2), Q7: c (3), Q8: c (3)
- Q9: c (3), Q10: b (2), Q11: b (2), Q12: b (2)

**Mental Health Barriers (Q1, Q9, Q10):**
```
Raw Score = 3 + 3 + 2 = 8
Average = 8 / 3 = 2.67
Weighted = 2.67 × 1.5 = 4.00
```

**Physical Activity (Q2, Q4, Q9):**
```
Raw Score = 2 + 3 + 3 = 8
Average = 8 / 3 = 2.67
Weighted = 2.67 × 1.4 = 3.73
```

**Anti-Bullying (Q7, Q10):**
```
Raw Score = 3 + 2 = 5
Average = 5 / 2 = 2.50
Weighted = 2.50 × 1.3 = 3.25
```

---

## Post-Assessment Flow

### 1. Results Summary Screen
- Congratulate user for completing assessment
- Award **100 coins** as reward
- Display top 3 barriers with brief explanations
- Prompt to sign up/log in to save progress

### 2. SMART Goal Selection
- Explain what SMART goals are (Specific, Measurable, Achievable, Relevant, Time-bound)
- Present 3 SMART goals (one per top barrier)
- User selects ONE goal to focus on

### 3. Path Assignment
- User is assigned to the quest path matching their selected SMART goal
- Show path overview and what to expect

---

## Age Groups

| Age Group | Target Audience |
|-----------|-----------------|
| 6-12 years | Children |
| 13+ years | Teens |
| Parent/Caregiver | Can match child's barriers |

---

## Quest Paths (8 Total)

| Path ID | Name | Primary Barrier | Focus |
|---------|------|-----------------|-------|
| 1 | MindfulMoods | Mental Health Barriers | Emotional regulation, stress management |
| 2 | HopeHarbor | Hope & Resilience | Optimism, bouncing back from setbacks |
| 3 | BodyPositive | Psychological Factors | Self-esteem, body image |
| 4 | ActiveAdventures | Physical Activity | Movement, exercise, motivation |
| 5 | ZenZone | Mindfulness | Breathing, meditation, coping |
| 6 | NutritionNinja | Nutrition & Mindful Eating | Healthy foods, mindful eating |
| 7 | FriendshipForge | Anti-Bullying | Social skills, standing up for self/others |
| 8 | BodyWise | Intuitive Eating | Hunger cues, body awareness |

---

## Weight Rationale

| Weight | Categories | Reasoning |
|--------|------------|-----------|
| 1.5x | Mental Health, Hope & Resilience | Foundational to all well-being; cascading effects on other areas |
| 1.4x | Psychological Factors, Physical Activity, Mindfulness | Direct impact on long-term health outcomes |
| 1.3x | Nutrition, Anti-Bullying | Important but can be influenced by higher-weighted factors |
| 1.2x | Intuitive Eating | More specific/narrow scope |

---

## Data Structure (for implementation)

```lua
-- Question Structure
Question = {
    id = 1,
    text = "How often do you feel sad, stressed, or worried?",
    area = "Mental Health & Emotional Well-being",
    scoringDirection = "higher_is_barrier", -- or "lower_is_barrier"
    options = {
        {text = "Never", value = 1},
        {text = "Rarely", value = 2},
        {text = "Sometimes", value = 3},
        {text = "Always", value = 4}
    }
}

-- Category Structure
Category = {
    id = "mental_health",
    name = "Mental Health Barriers",
    questions = {1, 9, 10},
    weight = 1.5,
    questPath = "MindfulMoods"
}

-- User Assessment Result
AssessmentResult = {
    userId = "player123",
    timestamp = 1234567890,
    answers = {1, 2, 3, 3, 3, 2, 3, 3, 3, 2, 2, 2}, -- Q1-Q12 scores
    categoryScores = {
        mental_health = 4.00,
        hope_resilience = 3.73,
        -- etc.
    },
    topBarriers = {"mental_health", "hope_resilience", "physical_activity"},
    selectedGoal = "mental_health",
    assignedPath = "MindfulMoods",
    coinsAwarded = 100
}
```
