# Promo Code System (Lumo's Land)

## Overview
Promo codes are entered **directly in Lumo's Land** to receive special items. Codes can come from:
- HealthQuest website promotions
- Social media campaigns
- Email newsletters
- Special events
- Achievement milestones

---

## Flow

```
HealthQuest creates promo code (e.g., "WELLNESS2026")
        ↓
Player sees code on website/social media/email
        ↓
Player opens Lumo's Land → Settings → "Enter Code"
        ↓
Enters code: WELLNESS2026
        ↓
🎉 "Code Redeemed!" - Special sticker added to inventory!
```

---

## Code Entry UI (Settings → Enter Code)

```
┌─────────────────────────────────────┐
│         Enter Promo Code            │
├─────────────────────────────────────┤
│                                     │
│  Have a special code? Enter it      │
│  below to get your reward!          │
│                                     │
│  ┌─────────────────────────────────┐│
│  │  WELLNESS2026                   ││
│  └─────────────────────────────────┘│
│                                     │
│         [ Redeem Code ]             │
│                                     │
└─────────────────────────────────────┘
```

### Success Response:
```
┌─────────────────────────────────────┐
│      🎉 Code Redeemed! 🎉           │
│                                     │
│  You received:                      │
│                                     │
│     ⭐ Wellness Star Sticker        │
│                                     │
│  Check your Sticker Book!           │
│                                     │
│         [Awesome!]                  │
└─────────────────────────────────────┘
```

### Error Responses:
- "Invalid code. Please check and try again."
- "This code has already been used."
- "This code has expired."

---

## Promo Code Types

### 1. Global Codes (Anyone can use, limited uses total)
Created by HealthQuest marketing for campaigns.

| Code | Reward | Max Uses | Expires |
|------|--------|----------|---------|
| WELLNESS2026 | ⭐ Wellness Star | 10,000 | Mar 31, 2026 |
| LUMOLOVE | 💖 Love Sticker | 5,000 | Feb 14, 2026 |
| HEALTHY | 🍎 Apple Sticker | Unlimited | Never |

### 2. Single-Use Codes (One player only)
For giveaways, contests, special rewards.

| Code | Reward | Status |
|------|--------|--------|
| WINNER-A1B2C3 | 🏆 Trophy Sticker | Unused |
| PRIZE-X7Y8Z9 | 🎁 Gift Box Sticker | Used |

---

## Special Stickers (Promo Rewards)

| ID | Sticker | Emoji | Description |
|----|---------|-------|-------------|
| STCK-PROMO-001 | Quest Champion Star | ⭐ | "You're a wellness champion!" |
| STCK-PROMO-002 | Devoted Caretaker Heart | 💖 | "Lumo's best friend!" |
| STCK-PROMO-003 | Rising Star Rocket | 🚀 | "Reaching for the stars!" |
| STCK-PROMO-004 | Perfect Week Rainbow | 🌈 | "A week of love!" |
| STCK-PROMO-005 | Wellness Star | ⭐ | "Wellness warrior!" |
| STCK-PROMO-006 | Apple of Health | 🍎 | "Healthy choices!" |
| STCK-PROMO-007 | Trophy Winner | 🏆 | "Contest winner!" |
| STCK-PROMO-008 | Gift Box | 🎁 | "Special surprise!" |

**Properties:**
- Rarity: Legendary (gold border)
- Not purchasable with coins
- Display in Sticker Journal & Castle walls
- Shows as "locked" in Nook until earned via code

---

## Settings → My Redeemed Codes

```
┌─────────────────────────────────────┐
│         My Redeemed Codes           │
├─────────────────────────────────────┤
│                                     │
│  WELLNESS2026                       │
│     ⭐ Wellness Star Sticker        │
│     Redeemed: Jan 15, 2026          │
│                                     │
│  LUMOLOVE                           │
│     💖 Love Sticker                 │
│     Redeemed: Feb 1, 2026           │
│                                     │
│  ─────────────────────────────────  │
│                                     │
│  [ Enter New Code ]                 │
│                                     │
└─────────────────────────────────────┘
```

---

## Backend: Code Management

HealthQuest team manages codes via admin panel or database:

```
promo_codes table:
─────────────────
id: 1
code: "WELLNESS2026"
reward_id: "STCK-PROMO-005"
code_type: "global"           -- "global" or "single_use"
max_uses: 10000
current_uses: 2847
expires_at: "2026-03-31"
active: true
```

```
redeemed_codes table:
─────────────────────
id: 1
code: "WELLNESS2026"
roblox_user_id: 12345678
redeemed_at: "2026-01-15 10:30:00"
```

---

## Roblox Implementation

### Code Redemption Flow:

```lua
function PromoCode.redeemCode(player, code)
    -- 1. Validate code exists and is active
    local codeData = PromoCode.validateCode(code)
    if not codeData then
        return false, "Invalid code"
    end

    -- 2. Check if player already used this code
    if PromoCode.hasPlayerUsedCode(player, code) then
        return false, "Already redeemed"
    end

    -- 3. Check expiration
    if codeData.expiresAt and os.time() > codeData.expiresAt then
        return false, "Code expired"
    end

    -- 4. Check uses remaining (for global codes)
    if codeData.maxUses and codeData.currentUses >= codeData.maxUses then
        return false, "Code limit reached"
    end

    -- 5. Grant reward
    InventoryService.addItem(player, codeData.rewardId)

    -- 6. Record redemption
    PromoCode.recordRedemption(player, code)

    return true, "Success!", codeData.rewardItem
end
```

---

## Summary

| Who | Does What |
|-----|-----------|
| **HealthQuest Team** | Creates codes, sets rewards, manages expiration |
| **Lumo's Land** | Code entry UI, validation, grants items |
| **Player** | Enters code in Settings, receives sticker |
