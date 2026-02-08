# Superpowers Skills - Cheat Sheet Rapide

## Arbre de décision : Quel skill utiliser ?

```
┌─ Je vais créer quelque chose
│  └─ BRAINSTORMING
│     └─ (après validation) USING-GIT-WORKTREES
│        └─ WRITING-PLANS
│           └─ SUBAGENT-DRIVEN-DEVELOPMENT OU EXECUTING-PLANS
│
├─ Il y a un bug / test échoue
│  └─ SYSTEMATIC-DEBUGGING (Phase 1 obligatoire)
│     └─ TEST-DRIVEN-DEVELOPMENT (pour le fix)
│        └─ VERIFICATION-BEFORE-COMPLETION
│
├─ Code est écrit et needs review
│  └─ REQUESTING-CODE-REVIEW
│
├─ Je veux finir et merger
│  └─ FINISHING-A-DEVELOPMENT-BRANCH
│
└─ Tâches indépendantes
   └─ DISPATCHING-PARALLEL-AGENTS
```

---

## Checklist par Phase

### 🧠 Phase Brainstorming

- [ ] Lire l'état du projet (files, docs, commits)
- [ ] Poser 1 question à la fois
- [ ] Préférer réponses avec choix multiples
- [ ] Comprendre: but, contraintes, succès
- [ ] Proposer 2-3 approches avec trade-offs
- [ ] Présenter design en sections 200-300 mots
- [ ] Valider après chaque section
- [ ] Sauver design dans docs/plans/YYYY-MM-DD-<topic>-design.md
- [ ] Commit le design

### 🌳 Phase Worktrees

- [ ] Chercher .worktrees/ ou worktrees/
- [ ] Vérifier dans .gitignore (ajouter si absent)
- [ ] `git worktree add <path> -b <branch-name>`
- [ ] Lancer setup (npm install, etc.)
- [ ] Lancer tests (tous doivent passer)

### 📋 Phase Planification

- [ ] Header avec Goal, Architecture, Tech Stack
- [ ] > **For Claude:** REQUIRED SUB-SKILL: superpowers:executing-plans
- [ ] Découper en tâches 2-5 minutes
- [ ] Chaque tâche a exactement : Fichiers, Étapes détaillées
- [ ] Code complet dans le plan, pas "ajoutez validation"
- [ ] Commandes exactes avec résultats attendus
- [ ] TDD dans chaque tâche (test, run, code, run, commit)

### 🔨 Phase Implémentation

#### Subagent-Driven:
- [ ] Lire le plan une fois
- [ ] Extraire toutes les tâches
- [ ] Créer TodoWrite
- [ ] Par tâche: dispatch → implement → spec review → quality review
- [ ] Marquer complete dans TodoWrite
- [ ] Final code review global

#### Executing Plans:
- [ ] Charger et reviewer plan
- [ ] Créer TodoWrite
- [ ] Exécuter batch (défaut 3 tâches)
- [ ] Reporter après batch
- [ ] Continuer ou ajuster
- [ ] Finalisation avec finish-branch

### ✅ Phase Vérification

**AVANT chaque affirmation de succès:**

```
1. IDENTIFIER: Quelle commande = preuve ?
2. LANCER: Exécuter la commande (fraîche)
3. LIRE: Output complet
4. VÉRIFIER: Ça confirme l'affirmation ?
5. SEULEMENT APRÈS: Faire l'affirmation
```

- [ ] Tests lancer, vérifier exit 0
- [ ] Build lancer, vérifier exit 0
- [ ] Linter lancer, vérifier 0 erreurs
- [ ] Symptôme test lancer, vérifier PASS

### 🔍 Phase Débogage (si problème)

1. **ROOT CAUSE (obligatoire)**
   - [ ] Lire messages d'erreur complets
   - [ ] Reproduire de façon consistent
   - [ ] Vérifier changements récents
   - [ ] Ajouter instrumentation
   - [ ] NE PAS deviner

2. **HYPOTHÈSE**
   - [ ] Basée sur preuve Phase 1
   - [ ] Vérifiable
   - [ ] Adressable

3. **TEST SOLUTION**
   - [ ] Proposer fix minimal
   - [ ] Voir si ça change l'output
   - [ ] NE PAS supposer succès

4. **VÉRIFICATION**
   - [ ] Lancer le test original
   - [ ] Vérifier regression

---

## Commandes Fréquentes

### Git

```bash
# Créer worktree
git worktree add .worktrees/<feature> -b <feature>

# Vérifier si directory ignoré
git check-ignore -q .worktrees

# Lancer test et voir count
npm test 2>&1 | tail -5

# Diff depuis HEAD~1
git diff HEAD~1 HEAD

# Commit atomique
git commit -m "feat: [exact task name]"
git commit -m "fix: [bug description from root cause]"
git commit -m "refactor: [specific change]"
git commit -m "test: [test name]"
```

### Test & Verify

```bash
# Always full run
npm test

# Specific file
npm test -- src/file.test.js

# With verbose output
npm test -- --verbose

# Line count
npm test 2>&1 | grep -E "pass|fail" | head -1

# Exit code check
npm test && echo "✓ PASS" || echo "✗ FAIL"
```

### Git Worktree Cleanup

```bash
# List worktrees
git worktree list

# Remove after done
git worktree remove <path>

# Prune old
git worktree prune
```

---

## Affirmations & Preuves

### ❌ → ✅ Conversions

```
❌ "Tests pass"
✅ "[npm test output: 34/34 pass] Tests pass"

❌ "Build works"
✅ "[build command output: exit 0] Build successful"

❌ "Fixed the bug"
✅ "[test command: test pass] Bug fixed"

❌ "Code quality is good"
✅ "[style review output: 0 errors] Code passes style checks"

❌ "Ready to merge"
✅ "[all tests: 45/45 pass] Tests passing, ready for merge"
```

---

## Red Flags & Stops

### STOP & ASK quand:

- [ ] Plan a critical gaps → Clarify first
- [ ] Hit blocker mid-batch → Ask for help
- [ ] Test fails repeatedly → Different strategy needed
- [ ] Don't understand instruction → Ask
- [ ] Verification fails → Don't proceed

### NEVER rationalize:

- "Should work now" → RUN THE TEST
- "I'm confident" → Show me output
- "Just this once" → NO EXCEPTIONS
- "Different wording so rule doesn't apply" → SPIRIT OVER LETTER
- "I'm tired" → Exhaustion ≠ excuse

---

## Skill Invocation Template

```
I'm using the {skill-name} skill to {specific-purpose}.

[Announce the specific purpose, not just the skill]

[Follow the skill exactly as documented]

[After completing the skill]

Report status based on skill output.
```

---

## Workflow Diagram

```
START
  ↓
Might any skill apply? 
  → 1% chance = CHECK SKILL
  → No chance = Proceed
  ↓
Invoke Skill
  ↓
Announce: "Using X for Y"
  ↓
Has checklist?
  → Yes = Create TodoWrite
  → No = Continue
  ↓
Follow skill exactly
  ↓
Complete
  ↓
Report + Next step
```

---

## Skills Summary Table

| Skill | When | Output | Duration |
|-------|------|--------|----------|
| Brainstorming | New feature idea | Design doc | 15-45 min |
| Using-Git-Worktrees | Before coding | Ready worktree | 2-5 min |
| Writing-Plans | Have spec | Detailed plan | 20-60 min |
| Subagent-Driven | Have plan, independent tasks | Full implementation | 1-3 hours |
| Executing-Plans | Have plan, parallel session | Batch results | 30-60 min/batch |
| Test-Driven | During coding | Tested code | Per task |
| Systematic-Debugging | Bug found | Root cause + fix | 30 min - 2 hours |
| Requesting-Code-Review | Work complete | Feedback | 10-30 min |
| Verification-Before | Before claim success | Proof + claim | 5 min |
| Finishing-Branch | Implementation done | Merged/PR/saved | 5-10 min |
| Writing-Skills | New technique needed | New skill doc | 1-3 hours |

---

## Conversation Patterns

### Starting a Feature

```
User: "Help with X feature"

Agent: "I'll use brainstorming to explore this with you."
[Brainstorming happens]
[Design validated]

Agent: "I'm using using-git-worktrees to set up an isolated workspace."
[Worktree created, tests pass]

Agent: "I'm using writing-plans to create a detailed implementation plan."
[Plan written with N tasks]

Agent: "Ready to execute with subagent-driven-development."
```

### Fixing a Bug

```
Test fails: "expected 5 got 3"

Agent: "I'll use systematic-debugging to find the root cause."
[Phase 1: Investigation]
[Phase 2-4: Hypothesis → Test → Verify]

Agent: "Found root cause: X not calling Y. Using test-driven-development to fix."
[Write test that fails]
[Write fix]
[Test passes]

Agent: "I'm using verification-before-completion to confirm the fix."
[Run full suite]
[Report: All tests pass]
```

### Executing a Ready Plan

```
User: "Execute the plan in docs/plans/api-redesign.md"

Agent: "I'm using executing-plans to implement this plan."
[Step 1: Load and critique plan]
[Step 2: Execute batch 1, 2, 3]
[Step 3: Report results]
User: "Looks good, continue"
[Step 4: Execute batches 4-6]
```

---

## Key Principles (Mantras)

🎯 **Evidence Before Claims**
- No "should work"
- No "probably"
- No "seems to"
- Proof first, then affirmation

🔴 **Red First, Green Second**
- Watch test fail (RED)
- Write minimal code (GREEN)
- Refactor (REFACTOR)
- Never skip RED phase

🔍 **Root Cause Always**
- No quick fixes
- Investigation first
- Understanding required
- Then propose solution

📋 **Plan Then Code**
- Never code without plan
- Plan is bite-sized tasks
- Each step is 2-5 minutes
- Exact file paths, exact commands

👥 **Fresh Eyes Per Task**
- Subagent per task
- No context pollution
- Two reviews: spec then quality
- Cycle fast

✅ **Verify Then Close**
- Verification before status claim
- Evidence in message
- Output in response
- Proof without excuses

💪 **No Exceptions**
- "Just this once" = NO
- "It's simple" = NO
- "I'm confident" = NO
- Follow skill exactly

---

## Quick Reference Commands

```bash
# Verify implementation
npm test 2>&1 | grep -E "passing|failing"

# Git status
git status && git log --oneline -5

# Check worktree
git worktree list

# See what changed
git diff HEAD~3 HEAD --stat

# Clean commit message
git commit -m "feat: add [specific feature]"
git commit -m "fix: [specific bug from root cause]"

# Push and create PR
git push -u origin $(git rev-parse --abbrev-ref HEAD)

# Final verification before merge
npm test && echo "✓ Ready" || echo "✗ Issues remain"
```

---

**Use this cheat sheet to stay on track with skills!**

Remember: If there's even a 1% chance a skill applies, invoke it.

