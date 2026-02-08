# Superpowers Skills - Cas d'Usage et Patterns

## Introduction

Ce document détaille comment les skills de Superpowers s'utilisent dans des scénarios concrets de développement. Chaque cas d'usage montre la séquence complète du workflow.

---

## Cas d'Usage 1 : Créer une feature majeure

### Scenario Complet

**Utilisateur**: "Je veux ajouter un système de caching pour les API calls. Les clients doivent pouvoir mettre en cache les réponses avec TTL configurable et un eviction policy."

**Étape 1: Brainstorming** (15-30 min)

```
Agent:
"Je vais utiliser le skill brainstorming pour explorer cette feature avec vous.

[Comprendre l'idée]
Agent pose une question à la fois:

Q1: "Quel type de données allez-vous cacher? (APIs time-series, CRUD, analytics, configuration)?"
Réponse: "Surtout des CRUD APIs et quelques time-series"

Q2: "Le cache doit-il être:
- Local only (in-memory)?
- Distributed (Redis)?
- Local with distributed option?"
Réponse: "Local in-memory d'abord, distributed plus tard"

Q3: "Comment invalider le cache? (TTL only, explicit invalidation, pattern)?
Réponse: "TTL + explicit invalidation par clé pattern"

[Proposer approches]
Agent propose 3 approches:

Approach A (RECOMMANDÉ): 
- Simple interface: cache.get(key), cache.set(key, value, ttl)
- Memory storage
- TTL + pattern-based invalidation
- Minimal dependencies
Pourquoi: Simplicity first, extensible later

Approach B: 
- Complex with levels (L1 in-memory, L2 persistent)
- More overhead
Pourquoi: Overkill pour MVP

Approach C:
- Third-party library (Cacheman)
- Less control
Pourquoi: Moins flexible

[Présenter le design]
Agent présente en sections:

Section 1: Architecture Overview
'The caching system consists of a Cache manager with:
- get(key, options) - retrieve or fetch
- set(key, value, ttl) - store with expiration
- invalidate(pattern) - clear matching keys
- stats() - hit/miss metrics

Uses in-memory storage with Node.js Map for O(1) lookups.
TTL enforcement with clearInterval checks every 30 seconds for expired items.

Section 2: Integration Points
- Decorated API client methods
- Transparent pass-through when cache miss
- Automatic revalidation on patterns

Section 3: Data Structures
Cache entry = {value, expiresAt, hits, created}
Internal: Map<string, CacheEntry>

Section 4: API
[code examples shown]

[Validation]
Après chaque section: "Ça vous semble correct?"
Utilisateur: "Oui, mais ajoute un max-size limit"
Agent: [ajuste et re-valide]

Design finalisé ✓
"
```

**Output**: `docs/plans/2025-02-07-api-caching-design.md` committed

---

**Étape 2: Using Git Worktrees** (2-3 min)

```
Agent:
"Je vais utiliser le skill using-git-worktrees pour créer un espace isolé.

Vérification répertoire:
$ ls -d .worktrees 2>/dev/null
.worktrees

Vérification .gitignore:
$ git check-ignore -q .worktrees
$ echo $?  # → 0 (déjà ignoré ✓)

Création worktree:
$ git worktree add .worktrees/api-caching -b feature/api-caching
Preparing new working tree (new branch 'feature/api-caching')
...

Setup du projet:
$ cd .worktrees/api-caching
$ npm install
up to date, audited 145 packages

Vérification baseline:
$ npm test
34 tests, 34 pass, 0 fail ✓

Prêt d'implémenter le caching."
```

---

**Étape 3: Writing Plans** (30-45 min)

```
Agent génère: docs/plans/2025-02-07-api-caching-implementation.md

# API Caching - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan.

**Objective:** Implement in-memory caching system for API calls with TTL and pattern-based invalidation.

**Architecture:** Cache manager with get/set/invalidate interface, in-memory Map storage, automatic TTL cleanup.

**Tech Stack:** Node.js (Map, Set, clearInterval), Jest for tests

---

## Task 1: Cache Manager Interface

**Files:**
- Create: `src/cache/CacheManager.ts`
- Create: `src/cache/index.ts`
- Test: `test/cache/CacheManager.test.ts`

**Step 1: Write failing test**

\`\`\`typescript
import { CacheManager } from '../src/cache/CacheManager';

describe('CacheManager', () => {
  it('should store and retrieve values', async () => {
    const cache = new CacheManager();
    cache.set('key1', 'value1', 1000);
    
    const result = cache.get('key1');
    
    expect(result).toBe('value1');
  });
});
\`\`\`

**Step 2: Run test to verify it fails**

\`\`\`bash
npm test -- test/cache/CacheManager.test.ts
FAIL test/cache/CacheManager.test.ts
  CacheManager
    ✕ should store and retrieve values
      
Error: Cannot find module '../src/cache/CacheManager'

Tests: 1 failed, 1 total
\`\`\`

**Step 3: Write minimal implementation**

\`\`\`typescript
// src/cache/CacheManager.ts
export class CacheManager {
  private store = new Map();
  
  set(key: string, value: any, ttl: number): void {
    this.store.set(key, { value, expiresAt: Date.now() + ttl });
  }
  
  get(key: string): any {
    const entry = this.store.get(key);
    if (!entry) return undefined;
    if (entry.expiresAt < Date.now()) {
      this.store.delete(key);
      return undefined;
    }
    return entry.value;
  }
}

// src/cache/index.ts
export { CacheManager } from './CacheManager';
\`\`\`

**Step 4: Run test to verify it passes**

\`\`\`bash
npm test -- test/cache/CacheManager.test.ts
PASS test/cache/CacheManager.test.ts
  CacheManager
    ✓ should store and retrieve values (2ms)

Tests: 1 passed, 1 total
\`\`\`

**Step 5: Commit**

\`\`\`bash
git add src/cache/CacheManager.ts src/cache/index.ts test/cache/CacheManager.test.ts
git commit -m "feat: add CacheManager basic get/set"
\`\`\`

---

## Task 2: TTL Expiration Handling

[Similar structure with test → fail → implement → pass → commit]

---

## Task 3: Pattern-Based Invalidation

[Similar structure]

---

## Task 4: Cache Statistics

[Similar structure]

---

## Task 5: API Client Integration

[Similar structure - show how to decorate existing client methods]

---

## Task 6: Error Handling

[Similar structure - edge cases with null values, invalid keys]

---

## Task 7: Configuration & Options

[Similar structure - TTL defaults, max size, cleanup interval]

---

## Task 8: Documentation & Examples

[Similar structure - write usage docs and example code]
```

---

**Étape 4: Subagent-Driven Development** (2-3 hours)

```
Agent:
"Je vais implémenter ce plan avec subagent-driven-development.

[Lire le plan une fois]
8 tâches identifiées
Contexte: API caching system, Node.js/TypeScript, Jest

[Créer TodoWrite avec 8 tâches]
Task 1: Cache Manager Interface (not-started)
Task 2: TTL Expiration (not-started)
...
Task 8: Documentation (not-started)

[Par tâche: Dispatch subagent]

Task 1: Cache Manager Interface
Dispatch implementer subagent:
  - Task details complètes
  - Files à créer/modifier
  - Each step du plan
  - Contexte du projet

Subagent implementer → implémente → teste → commit

[Spec review]  
Agent reviewer vérifie que l'implémentation match la spec
  Issue trouvée: get() ne vérifie pas TTL before returning
  Retour à implementer: fix le bug
  
[Quality review]
Agent reviewer vérifie la qualité
  Issue: Variable names trop courts (e → entry)
  Retour à implementer: renommer
  
Task 1: Completed ✓

Task 2: TTL Expiration Handling
[Dispatch, implement, review spec, review quality]
Task 2: Completed ✓

...

Task 8: Documentation
Task 8: Completed ✓

[Final code review]
Agent reviewer final examine tout le code
  Report: 'Clean architecture, well tested, ready to merge'

Implémentation complète ✓
"
```

---

**Étape 5: Finishing Development Branch** (5 min)

```
Agent:
"Je vais finir cette branche.

[Verify tests]
$ npm test
All tests: 45 pass, 0 fail ✓

[Determine base]
$ git merge-base HEAD main
$ echo Done

Base: main ✓

[Present options]
Implementation complete. What would you like to do?

1. Merge back to main locally
2. Push and create a Pull Request
3. Keep the branch as-is
4. Discard this work

Utilisateur: "Option 2: create a PR"

[Execute]
$ git push -u origin feature/api-caching
Branch 'feature/api-caching' set up to track 'origin/feature/api-caching'

Creating PR...
PR created: /ayos/api-caching
"
```

---

## Cas d'Usage 2 : Corriger un bug complexe

### Scenario Complet

**Situation**: Un test échoue avec "cache entries not cleaned up after TTL expires"

**Étape 1: Systematic Debugging - Phase 1: Root Cause Investigation**

```
Agent:
"Je vais utiliser systematic-debugging pour trouver la cause racine.

[Read error messages carefully]
Test output:
  ✕ cache entries should expire after TTL
    Expected cleaned entries: 0
    Actual found entries: 3
    Assertion: expect(cache.keys().length).toBe(0)

[Reproduce consistently]
§ npm test -- test/cache/CacheManager.test.ts --grep "expire"
✕ FAIL

Run 2:
§ npm test -- test/cache/CacheManager.test.ts --grep "expire"
✕ FAIL

Reproducible 100% (!) ✓

[Check recent changes]
§ git log --oneline -10 | grep -i cache
3a9c1e2 feat: add TTL expiration with cleanup
2f8d1c3 feat: add CacheManager basic get/set

Recent change: TTL cleanup was added
§ git diff 2f8d1c3 3a9c1e2

Changes:
- Added clearInterval loop (every 30 seconds)
- Added cleanup logic in separate function

[Gather evidence]
Add diagnostic logging:

\`\`\`typescript
get(key: string): any {
  console.log(\`[GET] key=\${key}\`);
  const entry = this.store.get(key);
  console.log(\`[GET] found=\${!!entry}\`);
  if (!entry) return undefined;
  console.log(\`[GET] expiresAt=\${entry.expiresAt}, now=\${Date.now()}\`);
  if (entry.expiresAt < Date.now()) {
    console.log(\`[GET] DELETING expired entry\`);
    this.store.delete(key);
    return undefined;
  }
  return entry.value;
}
\`\`\`

Run test with logs:
§ npm test -- test/cache/CacheManager.test.ts --grep "expire"

Output:
[SET] key=item1, ttl=100
[SET] key=item2, ttl=100
[SET] key=item3, ttl=100
[wait 150ms]
[GET] key=item1 - expiresAt=1001, now=1200
[GET] DELETING expired entry  [DELETE 1]
[GET] key=item2 - expiresAt=1001, now=1200
[GET] DELETING expired entry  [DELETE 2]
[GET] key=item3 - expiresAt=1001, now=1200
[GET] DELETING expired entry  [DELETE 3]
cache.keys().length = 3  ← STILL 3 (!)

Aha! Les clés sont supprimées du store lors des GET,
mais le test ne fait pas de GET - juste count les keys!"

Evidence montré: 
- Cleanup loop ne fonctionne pas (items pas supprimés automatiquement)
- Cleanup only happens on GET
- Test vérifie count direct, sans GET calls

Root cause: cleanup interval n'exécute jamais la deletion
```

---

**Étape 2: Systematic Debugging - Phase 2-4: Hypothesis → Test → Verify**

```
[Hypothesis]
Le clearInterval est défini mais jamais appelé.
Code structure:

\`\`\`typescript
constructor() {
  this.startCleanupLoop(); // <- called?
}

startCleanupLoop() {
  this.cleanupInterval = setInterval(() => {
    this.cleanup();
  }, 30000);
}
\`\`\`

L'hypothèse: startCleanupLoop existe pas / n'est pas appellé

Vérification dans le code:
§ grep -n "startCleanupLoop" src/cache/CacheManager.ts
(aucun résultat!)

Root cause confirmée: startCleanupLoop() n'existe pas!

[Test minimal]
Ajouter le code:

\`\`\`typescript
private cleanupInterval: NodeJS.Timeout;

constructor() {
  this.startCleanupLoop();
}

startCleanupLoop() {
  this.cleanupInterval = setInterval(() => {
    const now = Date.now();
    for (const [key, entry] of this.store.entries()) {
      if (entry.expiresAt < now) {
        this.store.delete(key);
      }
    }
  }, 1000); // 1 second for testing (not 30 seconds)
}
\`\`\`

[Verify fix]
§ npm test -- test/cache/CacheManager.test.ts --grep "expire"
✓ PASS

Changé à 1 seconde pour test rapide (normal 30 sec)
"
```

---

**Étape 3: Test-Driven Development**

```
Agent:
"Je vais ajouter un test de régression pour cet issue.

[Write failing test first]

\`\`\`typescript
it('should automatically cleanup expired entries after TTL', async () => {
  const cache = new CacheManager({ cleanupInterval: 100 });
  
  cache.set('key1', 'value1', 50);  // Expires in 50ms
  cache.set('key2', 'value2', 50);
  
  // Wait for expiration + cleanup
  await new Promise(resolve => setTimeout(resolve, 200));
  
  expect(cache.keys().length).toBe(0);
});
\`\`\`

[Run - it fails]
✕ FAIL (entries still there)

[Write implementation]
[See above - startCleanupLoop implementation]

[Run - it passes]
✓ PASS

Cleanup happens automatically
"
```

---

**Étape 4: Verification Before Completion**

```
Agent:
"Je vais vérifier que le fix fonctionne.

[Identify verification command]
Command: npm test (complete suite)

[Run fresh command]
§ npm test

Results:
  PASS test/cache/CacheManager.test.ts
    - should store and retrieve values ✓
    - should cleanup on manual access ✓
    - should automatically cleanup expired entries ✓
  
  PASS test/api/integration.test.ts
    - cache in API client ✓
    
All tests: 48 pass, 0 fail ✓

[Verify]
Output confirms: All tests pass, bug fixed

[Claim with evidence]
Bug fixed: cache now automatically clean expired entries.
Evidence: All 48 tests pass, including regression test for TTL cleanup."
```

---

## Cas d'Usage 3 : Exécution d'un plan existant en parallèle

### Scenario

**Utilisateur**: "Voici le plan API redesign. Je l'ai validé avec l'équipe. Peux-tu l'exécuter en batch?"

**Étape 1: Executing Plans - Load & Review**

```
Agent: "Je vais utiliser executing-plans pour exécuter ce plan.

[Load plan]
§ cat docs/plans/2025-02-07-api-redesign-implementation.md
[Read entire plan - 6 tasks, 200+ lines]

[Review critically]
Q1: Task 1 "Extract API client" - Scope clear?
     Files listed: src/client/ApiClient.ts
     Est: 15-20 min ✓

Q2: Task 3 "Add retry logic" - Retry library or custom?
     Plan says: Custom exponential backoff
     Complexity: moderate ✓

Q3: Task 5 "Migrate endpoints" - All endpoints or subset?
     Plan says: All, but with deprecation warnings
     Risky: oui, but documented ✓

[No blockers found]
Plan is clear. Ready to execute."
```

---

**Étape 2: Executing Plans - Execute Batch 1**

```
Agent: "Executing batch 1 (tasks 1-3).

Task 1: Extract API Client
  [Mark in_progress]
  Step 1: Write failing test
    ✓ Written
  Step 2: Run test to verify fail
    ✓ FAIL (module not found)
  Step 3: Implement ApiClient class
    ✓ Implemented
  Step 4: Run test to verify pass
    ✓ PASS
  Step 5: Commit
    ✓ git commit -m 'feat: extract ApiClient from utilities'
  [Mark completed]

Task 2: Add Error Handling
  [Mark in_progress]
  Step 1-5: [same pattern]
  [Mark completed]

Task 3: Add Retry Logic
  [Mark in_progress]
  Step 1-5: [same pattern]
  [Mark completed]

Batch 1 Summary:
  ✓ Task 1: Extract ApiClient (3 commits, 45 tests)
  ✓ Task 2: Error handling (2 commits, 12 tests added)
  ✓ Task 3: Retry logic (3 commits, 18 tests added)
  
Final status: All 3 tasks complete, 75 tests passing.
Ready for feedback."
```

---

**Étape 3: User Feedback & Continue**

```
User: "Great! I reviewed the code. One issue: Task 3 
needs to respect the max-retries config in settings.json.
Please check and continue with batch 2."

Agent: "Checking Task 3 for config usage...

Checking: src/client/retry.ts handles config?
  Current: Hard-coded 3 retries
  Required: Read from settings.json
  
Fixing:
  \`\`\`typescript
  const config = require('../config/settings.json');
  const maxRetries = config.api.maxRetries || 3;
  \`\`\`
  
  Test updated ✓
  Commit: 'fix: respect maxRetries from config.json'
  
Ready to continue with batch 2."

[Execute batch 2: tasks 4-6]
...

All tasks complete. Using finishing-a-development-branch.
"
```

---

## Cas d'Usage 4 : Paralléliser le débogage

### Scenario

**Situation**: 3 tests différents échouent, pas liés.

```
Tests échouent:
  ✕ test/auth/jwt.test.ts (JWT token parsing)
  ✕ test/database/migration.test.ts (migration script)
  ✕ test/api/rate-limit.test.ts (rate limiting)

Agent:
"Ces 3 problèmes sont indépendants (auth, DB, API).
Utilisation dispatching-parallel-agents.

[Dispatch 3 subagents en parallèle]

Subagent 1: Fix JWT token parsing
  Task: test/auth/jwt.test.ts
  
Subagent 2: Fix migration script
  Task: test/database/migration.test.ts
  
Subagent 3: Fix rate limiting
  Task: test/api/rate-limit.test.ts

[All 3 run concurrently]

Subagent 1 retours:
  'Root cause: Buffer encoding changed in Node 18.
   Token was read as latin1, expected utf8.
   Fix: Add encoding parameter.
   ✓ Test passes'

Subagent 2 retours:
  'Root cause: Migration file timestamp format changed.
   Old: YYYYMMDD_HHmmss
   New: YYYYMMDD_HHmmss_ms
   Fix: Update migration loader pattern.
   ✓ Test passes'

Subagent 3 retours:
  'Root cause: Clock skew in tests.
   Rate limiter uses Date.now(), test mocks need same.
   Fix: Mock Date.now() consistently.
   ✓ Test passes'

[Integrer all 3]
§ npm test
✓ All 50 tests pass
"
```

---

## Patterns d'Intégration

### Pattern 1: Iterative Refinement

Certains designs/plans doivent être améliorés:

```
Brainstorming (first draft)
  ↓ User feedback
Brainstorming (revised)
  ↓ More questions
Brainstorming (final design)
  ↓
Using-Git-Worktrees + Writing-Plans
```

Pas besoin de recommencer - juste continuer avec le skill.

### Pattern 2: Blocked Implementation

Parfois un plan a besoin de clarification mid-execution:

```
Executing-Plans (Batch 1: 3 tasks)
  ✓ Tasks 1-3 complete
  
Feedback reveal: "Task 5 needs Task 4.5 first"
  ↓ Plan a gap
  ↓ Ask user or update plan
  ↓
Executing-Plans (Batch 2: Tasks 4-4.5)
```

### Pattern 3: Regression Testing

Quand un fix est appliqué:

```
Systematic-Debugging détecte root cause
  ↓
Fix implémenter (minimal code)
  ↓
Regression test écrit (TDD style, ex-post)
  ↓
Verification-Before-Completion confirme tout
```

### Pattern 4: Large Feature with Multiple PRs

Parfois une feature needs multiple PRs:

```
Brainstorming (complète design)
  ↓
Writing-Plans (split en 2 parties)
  ↓
Executing-Plans Batch 1
  → Finishing (PR pour partie 1)
  ↓
Executing-Plans Batch 2
  → Finishing (PR pour partie 2)
```

---

## Anti-Patterns à Éviter

### ❌ Skipping Brainstorming

```
User: "Add caching"
Agent: Immediately starts writing code
Result: Wrong approach, wasted time

✓ BETTER:
Agent: Uses brainstorming to explore options
Result: Right design, confident coding
```

### ❌ Code Before Test

```
Agent: Writes implementation first
Then: Tries to write test
Result: Test is hard to read, coverage gaps

✓ BETTER:
Agent: RED - write failing test
Then: GREEN - minimal code
Result: Clean test, confidence in code
```

### ❌ Fixing Without Investigation

```
Test fails, Agent: "Probably needs validation"
Writes validation code
Result: Wrong fix, still failing / time wasted

✓ BETTER:
Agent: Uses systematic-debugging Phase 1
Finds actual root cause
Result: Correct minimal fix
```

### ❌ Affirmation Without Verification

```
Agent: "Tests pass!" [without running]
User: Tries to merge, tests actually fail
Result: Broken merge, wasted team time

✓ BETTER:
Agent: [Runs full test suite]
Agent: "All 48 tests pass" [with output]
Result: Confident merge, clean CI
```

---

## Conseils Pratiques

1. **Commencer par Brainstorming même pour petites features**
   - Clarifie le scope
   - Capture les edge cases
   - Économise temps global

2. **Écrire plans avant la feature non-triviale**
   - Force la clarté
   - Permet delegation (subagents)
   - Documentation pour l'équipe

3. **TDD n'est pas ralentissement**
   - Test écrit en 1-2 min
   - Code écrit en 2-3 min
   - Debugging plus tard: 0 min (pas de bugs)

4. **Verification est rapide**
   - Juste lancer la commande
   - Lire l'output
   - Mentionner dans le message

5. **Commit après chaque tâche**
   - Atomic commits
   - Easy rollback si besoin
   - Clear git log

6. **Code review n'est pas ralentissement**
   - Subagent review: 2-3 min
   - Capture 80% d'issues
   - Qualité supérieure

---

**Ces patterns s'apprennent par la pratique. Plus on utilise les skills, mieux on comprend quand et comment les appliquer.**

