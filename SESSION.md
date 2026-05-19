# Session: Rebrand BeerBet → Predictions League + Cloudflare Backend

**Branch:** `claude/rebrand-predictions-league-HsCse`
**Date:** 2026-05-19
**Primary language:** Hebrew (EN secondary)

---

## Mission Summary

Rebrand **BeerBet** from a gambling-UX app to a legal **Predictions League** platform, then replace all mock data with a real Cloudflare Pages + D1 backend.

- Brand name `BeerBet` stays unchanged.
- All gambling terminology is replaced (see Step 2 map).
- Three legal pages added (Terms, Privacy, About).
- Cloudflare D1 + Pages Functions replace `mockData.js`.
- Tier infrastructure (Free / Pro / League Owner Pro) scaffolded without a real paywall yet.

---

## Operating Principles

1. **Show proof, no self-LGTM** — `git diff --stat`, grep proof, test output before checking off any step.
2. **Stop after each major step** — wait for explicit "go" before continuing.
3. **No new dependencies unless justified.**
4. **WCAG 2.2 AA accessibility must not regress** (10:1 contrast, 44×44 touch targets, ARIA, RTL focus, dyslexia font).
5. **Conventional commits, one logical change per commit, English.**
6. **Never merge to master automatically** — open PR and wait.

---

## Step Status

| # | Step | Status |
|---|------|--------|
| 1 | Audit (read-only) | ✅ Complete — see findings below |
| 2 | Terminology rebrand | ⬜ Waiting for "go" |
| 3 | Legal pages | ⬜ Blocked on Step 2 |
| 4 | Cloudflare backend (wrangler + D1 + Functions + auth + API) | ⬜ Blocked on Step 3 |
| 5 | Tier infrastructure + Pro page | ⬜ Blocked on Step 4 |
| 6 | Match comments (Trash-Talk / Match Talk) | ⬜ Blocked on Step 5 |
| 7 | Brand asset audit (logo / favicon / OG) | ⬜ Blocked on Step 6 |
| 8 | Privacy endpoints + account page | ⬜ Blocked on Step 7 |
| 9 | Final QA pass | ⬜ Blocked on Step 8 |

---

## Step 1 — Audit Findings

Ran against `avielzi/andrej-karpathy-skills` on branch `claude/rebrand-predictions-league-HsCse`.

### A. wrangler.toml
```
MISSING
```

### B. functions/ directory
```
NO functions/ DIR
```

### C. mockData.js
```
MISSING — src/ directory does not exist in this repo
```

### D. API calls in frontend
```
No src/ directory found — no frontend code present
```

### E. Routes
```
No src/App.jsx or src/main.jsx found
```

### F. Problematic terms (bet / gambling / Hebrew equivalents)
```
No src/ directory to scan
```

### G. package.json
```
No package.json found at repo root
```

### H. Git status
```
Branch: claude/rebrand-predictions-league-HsCse
Last 10 commits:
2c60614 Sync Chinese README with English version (add Cursor section) (#95)
fb7a22c add cursor support (#92)
fcd5d36 Add Chinese translation for README (#93)
c9a44ae Update README with project and social media links
331a3ac Update README with project and social media links
9ec6bef Fix readme
fb8fdb0 Add Multica project link at the top of README (#51)
aa4467f Merge pull request #18 from back1ply/fix/plugin-skill-path
68b67a5 Fix plugin.json schema validation errors
3cf049f Add marketplace.json and fix plugin structure
```

### I. Migrations / D1 schema
```
No migrations/ directory found
No .sql files found
```

### J. Source line count
```
No src/ directory — no source files
```

### K. GitHub Actions
```
No .github/workflows/ directory found
```

### Audit Conclusion

**This repository (`andrej-karpathy-skills`) contains only:**
- `CLAUDE.md` — Karpathy coding guidelines
- `CURSOR.md` — Cursor IDE equivalent
- `EXAMPLES.md` — Usage examples
- `README.md` / `README.zh.md`
- `skills/karpathy-guidelines/SKILL.md` — Claude Code plugin skill

**There is no BeerBet application code in this repo.**

Before Steps 2–9 can execute, one of the following must be confirmed:

> **Question for human:** Is the BeerBet source code in a different repository? If so, please provide the repo name/path so the rebrand can proceed in the correct location. Or, if the intent is to scaffold BeerBet from scratch here, confirm that and provide the initial source (Vite + React template, existing zip, etc.).

---

## Step 2 — Terminology Replacement Map

_(Ready to execute once human confirms correct repo and gives "go")_

| Old | New |
|-----|-----|
| `bet` / `Bet` / `BET` | `prediction` / `Prediction` / `PREDICTION` |
| `bets` | `predictions` |
| `betting` / `Betting` | `predicting` / `Predicting` |
| `place a bet` | `submit a prediction` |
| `stake` / `stakes` | `points` / `score` |
| `pot` / `wager` | `score` / `points` |
| `Banter` (chat name) | `Match Talk` |
| `הימור` | `חיזוי` |
| `הימורים` | `חיזויים` |
| `מהמר` | `חוזה` |
| `בירה` | DELETE — rephrase sentence |
| `קופה` / `פוט` | `נקודות` / `טבלה` |
| `חוב` | DELETE — no debts in this system |
| `sports betting` | `sports predictions` |

**Rules:**
- Brand `BeerBet` stays everywhere.
- Tagline: EN `BeerBet · Predictions for Friends` / HE `BeerBet · ליגת חיזויים לחברים`
- All variable/function/component names, CSS classes, route paths, i18n keys updated.
- `README.md`: remove "sports betting", "Live Chat (Banter)", "Age gate verification".
- `package.json` description updated.
- `index.html` title, meta description, OG tags updated.

**Commit:** `refactor: rebrand terminology from betting to predictions`

---

## Step 3 — Legal Pages

_(After Step 2 approval)_

Three new routes under `src/pages/legal/`:

- `/legal/terms` — תקנון (bilingual; BeerBet is a predictions game, not gambling; no real money; points have no monetary value; Israeli law / Tel Aviv jurisdiction; 18+ for data consent, not gambling)
- `/legal/privacy` — מדיניות פרטיות (bilingual; תיקון 13 + תקנות אבטחת מידע 2017; data collected, purpose, access, retention, user rights, deletion/export, contact, essential-only cookies)
- `/legal/about` — Friendly Stakes Disclaimer (bilingual; points-only reward; side arrangements are outside the platform entirely)

Global footer with links to all three pages.

**Commit:** `feat(legal): add terms, privacy, and friendly stakes pages`

---

## Step 4 — Cloudflare Backend

_(After Step 3 approval — execute substep by substep, stop between each)_

| Substep | Commit |
|---------|--------|
| 4a. wrangler.toml + D1 + KV | `feat(infra): add wrangler config and D1 setup` |
| 4b. Schema `migrations/0001_initial.sql` | `feat(db): add initial schema migration` |
| 4c. Functions scaffold | `feat(api): scaffold Pages Functions structure` |
| 4d. Magic-link auth | `feat(auth): implement magic-link authentication` |
| 4e. Leagues CRUD | `feat(api): implement leagues CRUD endpoints` |
| 4f. Predictions endpoints | `feat(api): implement predictions endpoints` |
| 4g. Comments endpoints | `feat(api): implement match comments endpoints` |
| 4h. Frontend API client (replace mockData) | `feat(frontend): replace mockData with real API client` |

**Tables:** users, user_consents, leagues, league_members, matches, predictions, match_comments, audit_log.
**Auth:** Magic link → Resend email API → HttpOnly cookie + KV session.
**New deps (justified):** `nanoid` (IDs), `jose` (JWT), `zod` (validation), `@tanstack/react-query` (client fetching), `@cloudflare/workers-types` (TS types), `wrangler` (dev tooling).

---

## Step 5 — Tier Infrastructure

_(After Step 4 approval)_

- `requireTier()` middleware helper
- Free limits enforced (max 3 leagues, max 10 members per league)
- `usePlan()` hook + `<ProBadge />` component
- `/pro` comparison page (Free / Pro ₪29/mo / League Owner Pro ₪49/mo)
- `migrations/0002_waitlist.sql` — `pro_waitlist` table
- Pro features show locked overlay + email capture modal (no real paywall yet)

**Commit:** `feat(tier): add tier infrastructure and Pro waitlist`

---

## Step 6 — Match Comments UI

_(After Step 5 approval)_

- Expandable comments below each match card
- Pre-kickoff: disabled input + "💬 התגובות נפתחות לאחר שריקת הפתיחה"
- Post-kickoff: full thread + working input
- Max 500 chars; rate-limit 10 comments/match/user
- Soft delete own comments
- ARIA live region + focus management on send

**Commit:** `feat(comments): add match talk thread (post-kickoff)`

---

## Step 7 — Brand Asset Audit

_(After Step 6 approval)_

- Logo: if depicts beer mug → replace with trophy + ⚽ SVG placeholder
- Favicon: same treatment
- OG image: regenerate with `BeerBet · ליגת חיזויים לחברים`
- Color palette: keep unless dominant color is beer-amber; if so, propose alternative and wait for approval

**Commit:** `feat(brand): update logo, favicon, and OG image`

---

## Step 8 — Privacy Endpoints + Account Page

_(After Step 7 approval)_

- `/account/privacy`: "Download my data" + "Delete my account" buttons
- `GET /api/me/export` → JSON download
- `POST /api/me/delete` → soft delete + 30-day hard-delete schedule
- Audit log entries for both actions
- Confirmation email on deletion

**Commit:** `feat(privacy): implement data export and account deletion`

---

## Step 9 — Final QA

_(After Step 8 approval)_

```bash
# Must return zero results (excluding BeerBet brand):
grep -rni "stake\|wager\|gambl\|הימור\|מהמר\|בירה\|פוט\|קופה" src/ functions/

# Must all exist:
test -f src/pages/legal/Terms.jsx     && echo "✓ terms"
test -f src/pages/legal/Privacy.jsx   && echo "✓ privacy"
test -f src/pages/legal/About.jsx     && echo "✓ about"
test -f src/pages/Pro.jsx             && echo "✓ pro page"
test -f functions/_middleware.ts      && echo "✓ middleware"
test -f functions/api/auth/magic-link.ts && echo "✓ magic link"
test -f migrations/0001_initial.sql   && echo "✓ migration"
```
