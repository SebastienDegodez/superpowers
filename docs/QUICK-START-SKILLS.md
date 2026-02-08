# Superpowers Skills - Quick Start pour Débutants

## 🚀 Démarrer en 5 minutes

### Qu'est-ce que Superpowers ?

Superpowers est un système de "skills" (compétences) pour agents codeurs. Au lieu de coder directement, l'agent suit un processus structuré :

```
Idée → Design → Plan → Implémentation → Vérification → Merge
```

Chaque étape utilise un skill différent qui guide l'agent pour bien le faire.

---

## 🎯 3 Règles Essentielles

### 1️⃣ Toujours chercher un skill en premier

Avant de faire quoi que ce soit, demande: "Existe-t-il un skill pour ça ?"

```
User: "Ajoute un système de cache"

Agent pense:
  ✓ Est-ce une feature ?  → Brainstorming
  ✓ Existe-t-il un skill ? → OUI
  → "Je vais utiliser brainstorming"
```

**Red flag**: Si l'agent dit "Je vais juste..." ou "Laisse-moi vérifier d'abord..." → Il a oublié de chercher un skill!

### 2️⃣ Suivre le skill EXACTEMENT

Les skills ne sont pas des suggestions - c'est des guides à suivre à la lettre.

```
TDD skill dit:
  1. RED: écrire un test qui échoue
  2. Vérifier qu'il échoue vraiment
  3. GREEN: écrire du code minimal
  4. Vérifier qu'il passe
  5. REFACTOR

Si l'agent écrit du code avant #1 → Il viole le skill.
```

### 3️⃣ Vérifier avant de clamer le succès

Pas de "ça devrait marcher" - lancer la commande et montrer la preuve.

```
❌ "Tests pass!"
✅ "Tests pass: 34/34 ✓"

❌ "Code quality is good"
✅ "[linter output: 0 errors] Code passes linting"
```

---

## 📚 Skills Essentiels (7 core)

### 🧠 Brainstorming (Quand on démarre une feature)

**Utilisation**: Nouveau feature, changement majeur

**Ce que ça fait**: 
- Pose des questions pour clarifier l'idée
- Propose différentes approches
- Valide le design avec toi
- Crée un document design

**Duration**: 15-45 min

**Example**:
```
User: "Je veux du caching pour les API"

Agent utilise brainstorming:
  "Quel genre d'APIs? Time-series vs CRUD?"
  → User: "CRUD"
  
  "Cache local ou distributed?"
  → User: "Local pour l'instant"
  
  "TTL ou explicit invalidation?"
  → User: "TTL + manual clear patterns"
  
  [Propose 3 approches]
  [Montre le design section par section]
  [User valide]
  
Output: docs/plans/YYYY-MM-DD-caching-design.md ✓
```

---

### 🌳 Using Git Worktrees (Avant de coder)

**Utilisation**: Avant de démarrer une feature

**Ce que ça fait**:
- Crée un espace isolé pour travailler
- Vérifie que les tests passent au baseline
- Tu peux travailler sans toucher à main

**Duration**: 2-5 min

**Example**:
```
Agent: "Je crée un worktree isolé"
  $ git worktree add .worktrees/caching -b feature/caching
  $ npm install
  $ npm test  ✓ Tous les tests passent
  
Output: Worktree ready, tests green ✓
```

---

### 📋 Writing Plans (Quand on est prêt à coder)

**Utilisation**: Après un design validé

**Ce que ça fait**:
- Découpe la feature en petites tâches (2-5 min chacune)
- Chaque tâche a: tests, code, vérification
- Facile à suivre pour un agent

**Duration**: 30-60 min

**Example**:
```
Plan contient 5 tâches:

Task 1: Cache Manager Class
  - Create: src/cache.ts
  - Step 1: Write test
  - Step 2: Verify fails
  - Step 3: Implement
  - Step 4: Verify passes
  - Step 5: Commit

Task 2: TTL Cleanup
  [même pattern]

...
```

---

### 🔨 Subagent-Driven Development (Faire le travail)

**Utilisation**: Exécuter un plan avec subagents

**Ce que ça fait**:
- Dispatch un agent par tâche
- Chaque agent implémente + self-review
- Spec review + quality review automatiques
- Tout est committé et vérifié

**Duration**: 1-3 heures pour une feature

**Example**:
```
Agent lance 5 subagents
  Subagent 1 → Task 1 (cache manager)
  Subagent 2 → Task 2 (TTL cleanup)
  ...
  
Chaque subagent:
  [Implémente selon le plan]
  [Auto-review son code]
  [Accepte spec review]
  [Accepte quality review]
  [Commit]
  
Résultat: Feature complète, testée, revue ✓
```

---

### ✅ Test-Driven Development (À faire pendant l'implémentation)

**Utilisation**: Toujours quand on code

**Ce que ça fait**:
- RED: écris un test qui échoue
- GREEN: écris du code minimal pour le faire passer
- REFACTOR: nettoie le code
- Répète

**Duration**: Fait partie de chaque tâche

**Example**:
```
RED:
  test('cache returns stored value', () => {
    cache.set('key', 'value');
    expect(cache.get('key')).toBe('value');
  });
  
  npm test  → FAIL ✓

GREEN:
  class Cache {
    set(k, v) { this.store[k] = v; }
    get(k) { return this.store[k]; }
  }
  
  npm test  → PASS ✓

REFACTOR:
  [nettoyer le code]
  npm test  → PASS ✓
```

---

### 🔍 Systematic Debugging (Quand y a un bug)

**Utilisation**: Test échoue, bug découvert, comportement inattendu

**Ce que ça fait**:
1. Find root cause (pas direct fix)
2. Hypothèse basée sur la preuve
3. Proposer solution minimal
4. Vérifier c'est fixé

**Duration**: 30 min - 2 heures

**Example**:
```
Test échoue: "cache not clean after TTL"

Phase 1: Investigation
  - Read error message
  - Reproduce (toujours ?)
  - Check recent changes
  - Add logging
  
  Découverte: Cleanup runs on get(), pas automatiquement

Phase 2-4: Hypothèse → Test → Verify
  - Hypothèse: startCleanup() not called
  - Add the missing function
  - Test passes ✓
```

---

### ✔️ Finishing a Development Branch (Finalisation)

**Utilisation**: Feature finie, tous les tests passent

**Ce que ça fait**:
- Vérifie les tests
- Propose: Merge local / Create PR / Keep / Discard
- Exécute le choix

**Duration**: 5 min

**Example**:
```
Agent: "Tests passing. Options:
  1. Merge to main locally
  2. Push and create PR
  3. Keep branch
  4. Discard"

User: "Option 2 - create PR"

Agent: 
  $ git push -u origin feature/caching
  [PR created: github.com/.../pull/42]
```

---

## 🔗 Workflow Complet

Un flux type pour une feature:

```
1. User: "Je veux du caching"
   
2. Agent: "Je vais utiliser brainstorming"
   [Chat, questions, design]
   Output: Design doc ✓
   
3. Agent: "Je vais utiliser using-git-worktrees"
   [Créer espace isolé]
   Output: Worktree ready ✓
   
4. Agent: "Je vais utiliser writing-plans"
   [Créer plan détaillé]
   Output: Detailed plan ✓
   
5. Agent: "Je vais utiliser subagent-driven-development"
   [Exécuter chaque tâche]
   Output: Feature complète ✓
   
6. Agent: "Je vais utiliser finishing-a-development-branch"
   [Merger ou créer PR]
   Output: Code intégré ✓
```

**Ca prend combien de temps ?** 2-4 heures pour une feature moyenne

---

## 🚨 Red Flags (Signes qu'on oublie un skill)

Écoute ces phrases = skill oublié:

| Phrase | Skill manquant |
|--------|---|
| "Je vais juste coder rapidement" | Brainstorming + Writing-Plans |
| "Comment fonctionne ça?" | Systematic-Debugging |
| "Ca devrait marcher" | Verification-Before-Completion |
| "Laisses-moi explorer le code" | Brainstorming ou Debugging |
| "Je suis confiant" | Verification-Before-Completion + tests |

---

## 📖 Apprendre les Skills

### Ressources Complètes

1. **GUIDE-UTILISATION-SKILLS.md** - Guide complet (tout expliqué)
2. **CHEAT-SHEET-SKILLS.md** - Référence rapide (tables, arbre de décision)
3. **CAS-D-USAGE-SKILLS.md** - Cas réels (voir comment ça marche)
4. **skills/*/SKILL.md** - Chaque skill en détail

### Progression d'apprentissage

**Jour 1**: Lire ce document (Quick Start) - 15 min

**Jour 2**: Utiliser 3 skills (brainstorming, plans, TDD) dans une petite feature - 1 hour

**Jour 3**: Lire CHEAT-SHEET - 10 min

**Jour 4**: Utiliser subagent-driven-dev pour une feature plus grosse - 2-3 hours

**Ongoing**: Référencer GUIDE ou skill files selon besoin

---

## 💡 Tips & Tricks

### ✅ Bons Habitudes

1. **Toujours annoncer le skill**
   ```
   "Je vais utiliser brainstorming pour clarifier cette feature"
   ```

2. **Laisser l'agent terminer le skill**
   - Skip les interruptions
   - Donner feedback à la fin

3. **Clamer quand c'est vraiment fini**
   - Pas de "almost done"
   - Vérification complète

4. **Committer après chaque tâche**
   - git commit avec message clair
   - git log doit raconter l'histoire

### ❌ Mauvaises Habitudes

1. **Ne pas chercher le skill**
   - "Je vais juste coder" - NON
   - Toujours chercher d'abord

2. **Modifier le skill à la volée**
   - "Je vais passer la phase 1" - NON
   - Stick au skill

3. **Affirmer sans preuve**
   - "Tests pass" (sans les lancer) - NON
   - Toujours lancer, montrer output

---

## 🤔 Questions Fréquentes

**Q: Ca prend pas mieux long qu'une implémentation directe?**
A: Non! TDD + systématique = moins de rework et debug. Temps total: identique ou moins.

**Q: Faut-il utiliser TOUS les skills?**
A: Non, juste les pertinents au contexte. L'agent choisit.

**Q: What if the plan changes mid-execution?**
A: Ask for clarification from user. Don't guess. Modify plan if needed, then continue.

**Q: Comment déboguer un skill qui n'a pas marché?**
A: Read the skill file again - l'agent l'a probablement pas suivi exactement.

**Q: Les skills c'est pour quelle plateforme?**
A: Claude Code (plugin), GitHub Copilot (en dev), Codex, OpenCode. L'agent adapte.

---

## 🎓 Prochaines Étapes

1. **Lire le Guide complet** (GUIDE-UTILISATION-SKILLS.md) si tu veux comprendre tous les skills
2. **Essayer une feature** petite (1-2 heures) avec Brainstorming + Plans + TDD
3. **Lire les cas d'usage** (CAS-D-USAGE-SKILLS.md) pour voir des patterns réels
4. **Consulter la cheat sheet** (CHEAT-SHEET-SKILLS.md) quand tu as besoin d'une ref rapide

---

## 📞 Support

- Chaque skill file a des sections "Red Flags" et "Common Failures"
- Lire le skill.md correspondant pour plus de détails
- Code examples sont dans tests/

---

**Version**: 1.0 - Quick Start Guide  
**Dernière mise à jour**: Février 2026

**Recommandation**: Essayer une small feature avec Superpowers - c'est le mieux pour apprendre!

