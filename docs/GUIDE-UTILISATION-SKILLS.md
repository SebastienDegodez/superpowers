# Guide Complet d'Utilisation des Skills Superpowers

## Table des matières

1. [Vue d'ensemble](#vue-densemble)
2. [Architecture des skills](#architecture-des-skills)
3. [Workflow de base](#workflow-de-base)
4. [Catalogue des skills](#catalogue-des-skills)
5. [Patterns d'utilisation](#patterns-dutilisation)
6. [Exemples pratiques](#exemples-pratiques)
7. [Bonnes pratiques](#bonnes-pratiques)

---

## Vue d'ensemble

### Qu'est-ce que Superpowers ?

**Superpowers** est un framework complet de développement logiciel pour agents codeurs (Claude Code, GitHub Copilot, Codex, OpenCode). Il fournit un ensemble de "skills" (compétences) qui automatisent et structurent le processus entier de développement.

Au lieu de sauter directement au code, Superpowers guide l'agent à travers une série d'étapes structurées :

```
📋 Brainstorming (conception)
    ↓
📐 Using Git Worktrees (isolation)
    ↓
📝 Writing Plans (planification détaillée)
    ↓
🔨 Subagent-Driven Development (implémentation)
    ↓
✅ Verification Before Completion (vérification)
    ↓
✔️ Finishing a Development Branch (finalisation)
```

### Pourquoi les skills ?

- **Consistent workflow**: Chaque tâche suit le même processus fiable
- **Autonomous execution**: L'agent peut travailler indépendamment pendant des heures
- **Quality gates**: Vérification systématique à chaque étape
- **No context decay**: Chaque étape accumule le contexte nécessaire
- **Human-in-the-loop**: Validation à des points clés (design, plan, finalisation)

---

## Architecture des skills

### Qu'est-ce qu'un skill ?

Un skill est un **guide de processus réutilisable** documenté en Markdown avec la structure suivante :

```markdown
---
name: skill-name              # Identifiant unique
description: "Use when..."    # Quand l'utiliser (≤1024 chars)
---

# Titre du Skill

## Overview
Vue rapide du skill et du principe core

## The Iron Law (optionnel)
Règle absolue impossible à violer

## When to Use
Conditions pour utiliser le skill

## The Process
Étapes détaillées du skill
```

### Frontmatter

**Chaque skill commence par :**

```yaml
---
name: skill-name
description: "Use when [triggering condition] - [what it does]"
---
```

- **name**: Identifiant unique, minuscules + tirets uniquement
- **description**: Commence par "Use when..." et décrit quand l'utiliser, pas ce qu'il fait

### Principes clés des skills

1. **Iron Laws**: Règles absolues non-négociables (ex: "NO FIXES WITHOUT ROOT CAUSE INVESTIGATION")
2. **Step-by-step**: Processus exact à suivre
3. **Verification first**: Vérification avant affirmation
4. **TDD mindset**: RED-GREEN-REFACTOR pour tous les processus
5. **Red flags**: Décisions qui signalent une violation du skill

---

## Workflow de base

### Flux général

Chaque session suit ce pattern :

```
1. User demande quelque chose
   ↓
2. Agent vérifie si un skill s'applique
   ↓
3. Agent invoque le skill
   ↓
4. Agent annonce : "Je vais utiliser le skill X pour Y"
   ↓
5. Agent suit le skill exactement
   ↓
6. Agent rapporte le résultat
```

### La règle du 1%

```
SI tu penses qu'un skill POURRAIT s'appliquer (même 1% de chance),
TU DOIS invoquer le skill pour vérifier.

C'est non-négociable. C'est non-optionnel.
```

### Using Workflow (Skill d'amorçage)

Le skill `using-workflow` rappelle à l'agent de toujours chercher et invoquer les skills pertinents.

Red flags qui indiquent qu'on rate un skill :
- "This is just a simple question"
- "I need more context first"
- "Let me explore the codebase first"
- "Let me gather information first"
- "I'll just do this one thing first"

---

## Catalogue des skills

### 1. Brainstorming
**Description**: Transformer les idées brutes en designs validés

**Quand l'utiliser** :
- Créer une nouvelle fonctionnalité
- Ajouter une épée majeure
- Modifier le comportement existant
- Résoudre un problème architectural

**Le processus** :
```
Étape 1: Comprendre l'idée
  → Vérifier l'état du projet
  → Poser des questions une par une
  → Préférer réponses à choix multiples
  → Comprendre: but, contraintes, critères de succès

Étape 2: Explorer les approches
  → Proposer 2-3 approches avec trade-offs
  → Commencer par l'approche recommandée
  → Expliquer le raisonnement

Étape 3: Présenter le design
  → Découper en sections de 200-300 mots
  → Valider après chaque section
  → Couvrir: architecture, composants, flux de données, erreurs, tests

Étape 4: Finaliser
  → Sauver dans docs/plans/YYYY-MM-DD-<topic>-design.md
  → Commit le design
  → Demander: "Prêt pour l'implémentation ?"
```

**Principes clés** :
- Une question à la fois
- YAGNI ruthless (enlever les features inutiles)
- Validation incrémentale
- Être flexible et revenir clarifier si nécessaire

**Output**: Document design validé, prêt pour la planification

---

### 2. Using Git Worktrees
**Description**: Créer des espaces de travail isolés pour le développement

**Quand l'utiliser** :
- Avant de commencer une feature
- Pour isoler le travail de la branche actuelle
- Quand on doit continuer sur main/master

**Le processus** :
```
Étape 1: Sélectionner le répertoire pour worktrees
  → Chercher .worktrees/ en priorité
  → Chercher worktrees/ ensuite
  → Chercher la préférence dans CLAUDE.md
  → Demander à l'utilisateur si absent

Étape 2: Vérifier la sécurité
  → Pour répertoires locaux: vérifier dans .gitignore
  → SI ABSENT: l'ajouter + commit
  → Pour répertoire global: pas besoin de vérifier

Étape 3: Créer le worktree
  → git worktree add <path> -b <branch-name>
  → cd <path>

Étape 4: Setup du projet
  → npm install / cargo build / pip install / etc.

Étape 5: Vérifier la baseline
  → Lancer les tests existants
  → Vérifier que tout passe
  → Signaler les erreurs si présentes
```

**Points importants** :
- Pas d'édition sur main/master directement
- Tests doivent passer au départ
- Worktree isolé du reste du projet

**Output**: Worktree prêt, tests passant, prêt pour le plan

---

### 3. Writing Plans
**Description**: Créer des plans d'implémentation détaillés

**Quand l'utiliser** :
- Après validation du design
- Avant de toucher au code
- Quand on a une spécification claire

**La granularité des tâches** :
Chaque étape = 2-5 minutes :
- "Écrire le test qui échoue" = 1 étape
- "Lancer le test pour vérifier qu'il échoue" = 1 étape
- "Implémenter le code minimal" = 1 étape
- "Lancer le test pour vérifier qu'il passe" = 1 étape
- "Commit" = 1 étape

**Structure d'une tâche** :
```markdown
### Tâche N: [Nom du composant]

**Fichiers:**
- Créer: `exact/path/to/file.py`
- Modifier: `exact/path/to/existing.py:123-145`
- Tests: `tests/exact/path/to/test.py`

**Étape 1: Écrire le test qui échoue**

\`\`\`python
def test_specific_behavior():
    result = function(input)
    assert result == expected
\`\`\`

**Étape 2: Lancer le test pour vérifier qu'il échoue**

Lancer: \`pytest tests/path/test.py::test_name -v\`
Résultat attendu: FAIL avec "function not defined"

**Étape 3: Implémenter le code minimal**

\`\`\`python
def function(input):
    return expected
\`\`\`

**Étape 4: Lancer le test pour vérifier qu'il passe**

Lancer: \`pytest tests/path/test.py::test_name -v\`
Résultat attendu: PASS

**Étape 5: Commit**

\`\`\`bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
\`\`\`
```

**Headers obligatoires** :
```markdown
# [Nom de la feature] - Plan d'implémentation

> **Pour Claude:** SKILL REQUIS: Utiliser superpowers:executing-plans pour implémenter ce plan.

**Objectif:** [Une phrase]

**Architecture:** [2-3 phrases]

**Stack technologique:** [Technologies clés]

---
```

**Points importants** :
- Chemins de fichiers exacts
- Code complet, pas "ajouter validation"
- Commandes exactes avec résultats attendus
- TDD, DRY, YAGNI
- Commits fréquents

**Output**: Plan d'implémentation détaillé et prêt à suivre

---

### 4. Test-Driven Development
**Description**: Cycle RED-GREEN-REFACTOR pour tout code

**Quand l'utiliser** :
- Toujours quand on implémente une feature
- Toujours quand on corrige un bug
- Pour tout refactoring
- Pour tout changement de comportement

**La loi de fer** :
```
AUCUN CODE DE PRODUCTION SANS TEST QUI ÉCHOUE D'ABORD
```

**Le cycle RED-GREEN-REFACTOR** :

```
RED Phase:
  1. Écrire un test minimal qui montre ce qui devrait se passer
  2. Lancer le test pour VOIR qu'il échoue
  3. Vérifier que l'erreur est la bonne (pas une fausse erreur)

GREEN Phase:
  1. Écrire le code MINIMAL pour faire passer le test
  2. Lancer le test pour VOIR qu'il passe
  3. Tous les tests doivent rester verts

REFACTOR Phase:
  1. Nettoyer le code
  2. Lancer les tests pour vérifier qu'ils restent verts
  3. Recommencer le cycle
```

**Red flags** :
- Écrire du code avant le test → DELETE ET RECOMMENCER
- Ne pas lancer la test → Tu ne sais pas ce qu'il teste
- Écrire du code "juste pour référence" → SUPPRIME-LE
- Oublier de vérifier que le test échoue d'abord → RED n'est pas respecté

**Points importants** :
- Un test = une chose
- Nom clair et explicite
- Tester le comportement réel
- Minimal == peut passer/échouer correctement

**Output**: Code bien testé, confiance dans les comportements

---

### 5. Systematic Debugging
**Description**: Processus systématique de débogage en 4 phases

**Quand l'utiliser** :
- Tout bug, tout échec de test
- Comportement inattendu
- Avant de proposer des solutions

**La loi de fer** :
```
AUCUNE SOLUTION SANS ENQUÊTE RACINE D'ABORD
```

**Les 4 phases** (OBLIGATOIRES dans l'ordre) :

```
Phase 1: Investigation racine
  1. Lire les messages d'erreur attentivement
  2. Reproduire de façon consistent
  3. Vérifier les changements récents (git diff)
  4. Ajouter de l'instrumentation de diagnostic
  5. NE PAS deviner la cause

Phase 2: Hypothèse
  1. Basée sur les preuves de Phase 1
  2. Vérifiable
  3. Adressable

Phase 3: Test de la solution
  1. Proposer un fix minimal basé sur l'hypothèse
  2. Voir si ça change le comportement
  3. NE PAS supposer que ça marche

Phase 4: Vérification
  1. S'assurer que c'est vraiment fixé
  2. S'assurer qu'on n'a pas créé de régression
  3. Documenter la racine pour apprendre
```

**Red flags** :
- "Ça devrait marcher maintenant"
- "Je suis confiant que..."
- "Juste cette fois" pour skip la phase 1
- Accepter un fix sans comprendre la racine

**Points importants** :
- NE JAMAIS passer une phase
- Chaque phase construit sur la précédente
- Plus d'instrumentation = mieux comprendre

**Output**: Racine comprise, solution confiante

---

### 6. Subagent-Driven Development
**Description**: Exécution de plans avec revision automatique

**Quand l'utiliser** :
- Quand on a un plan d'implémentation
- Quand les tâches sont indépendantes
- Quand on reste dans la même session

**Le processus** :

```
Étape 1: Préparer
  → Lire le plan une fois
  → Extraire toutes les tâches
  → Créer une liste TodoWrite
  → Noter le contexte

Par tâche (boucle) :
  Étape 2: Dispatcher subagent implémenteur
    → Fournir la tâche complète avec contexte
    → Attendre que subagent pose questions (si besoin)
    → Répondre aux questions

  Étape 3: Subagent implémente
    → Suit le plan
    → Écrit tests
    → Implémente code
    → Commit

  Étape 4: Dispatch spec reviewer
    → Vérifier que l'implémentation matche la spec
    → Identifier les gaps
    → SI problèmes: implémenteur corrige

  Étape 5: Dispatch code quality reviewer
    → Vérifier qualité du code
    → Identifier les problèmes de qualité
    → SI problèmes: implémenteur corrige

  Étape 6: Mark tâche comme complète

Étape 7: Tous les tests global + finalisation
  → Code reviewer final sur tout le travail
  → Utiliser finishing-a-development-branch
```

**Points importants** :
- Un subagent frais par tâche
- Pas de pollution de contexte
- Deux reviews : spec puis qualité
- Cycle de feedback rapide

**Output**: Implémentation complète, revue, testée

---

### 7. Executing Plans
**Description**: Exécution de plans avec checkpoints humains

**Quand l'utiliser** :
- Quand on a un plan d'implémentation
- Quand on exécute dans une session parallèle
- Quand on veut des checkpoints humains

**Le processus** :

```
Étape 1: Charger et revoir le plan
  → Lire le plan
  → Revoir de façon critique
  → Lever les questions avant de commencer
  → SI OK: créer TodoWrite

Étape 2: Exécuter un batch (défaut: 3 premières tâches)
  → Mark tâche comme in_progress
  → Suivre chaque étape du plan exactement
  → Lancer les vérifications
  → Mark comme completed

Étape 3: Rapporter
  → Montrer ce qui a été implémenté
  → Montrer les vérifications
  → Dire: "Prêt pour feedback"

Étape 4: Continuer ou ajuster
  → SI feedback: appliquer les changements
  → Exécuter le prochain batch
  → Répéter

Étape 5: Finalisation
  → Tous les tests passent ?
  → Utiliser finishing-a-development-branch
```

**Red flags** :
- Hit a blocker → STOPPER et demander de l'aide
- Plan a critical gaps → STOPPER et clarifier
- Tu ne comprends pas une instruction → DEMANDER

**Output**: Implémentation par batches avec validation humaine

---

### 8. Requesting Code Review
**Description**: Demander une review de code systématique

**Quand l'utiliser** :
- Après chaque tâche en subagent-driven-development
- Après une feature majeure
- Avant un merge

**Le processus** :

```
Étape 1: Obtenir les SHA
  BASE_SHA=$(git rev-parse HEAD~1)
  HEAD_SHA=$(git rev-parse HEAD)

Étape 2: Dispatcher code-reviewer subagent
  → Fournir ce qui a été implémenté
  → Fournir la spec/plan
  → Fournir les commits

Étape 3: Agir sur le feedback
  → Critical issues → fix immédiatement
  → Important issues → fix avant de continuer
  → Minor issues → note pour plus tard
```

**Points importants** :
- Review tôt, review souvent
- Les critical issues bloquent le progrès
- Peut pousser back si reviewer a tort (avec raison technique)

**Output**: Feedback de qualité, confiance dans le code

---

### 9. Verification Before Completion
**Description**: S'assurer que le travail est vraiment fini

**Quand l'utiliser** :
- Avant de clamer que quelque chose marche
- Avant de merger
- Avant de commit
- Avant de finir une tâche

**La loi de fer** :
```
AUCUNE AFFIRMATION DE SUCCÈS SANS PREUVE FRAÎCHE
```

**Le processus** :

```
AVANT de clamer un statut:

1. IDENTIFIER: Quelle commande prouve cette affirmation ?
2. LANCER: Exécuter la commande (fraîche, complète)
3. LIRE: Output complet, vérifier exit code
4. VÉRIFIER: L'output confirme l'affirmation ?
   SI NON → énoncer le statut réel avec preuve
   SI OUI → énoncer l'affirmation AVEC preuve
5. SEULEMENT APRÈS: Faire l'affirmation

Skip une étape = mentir, pas vérifier
```

**Red flags** :
- "Ça devrait passer" → LANCER LA COMMANDE
- "Je suis confiant" → Confiance ≠ preuve
- Exprimer de la satisfaction avant vérification → ARRÊTE
- Env different → Il faut quand même vérifier
- "Juste cette fois" → PAS D'EXCEPTIONS

**Exemples** :
```
❌ FAUX:  "Tests passed!"
✅ JUSTE: [Lancer tests] "34/34 tests pass"

❌ FAUX:  "Build works"
✅ JUSTE: [Lancer build] "Exit 0 - build successful"

❌ FAUX:  "Bug is fixed"
✅ JUSTE: [Lancer test du symptôme original] "Test passes"
```

**Output**: Affirmations vérifiées, pas de surprises

---

### 10. Finishing a Development Branch
**Description**: Finaliser le travail et merger/PR

**Quand l'utiliser** :
- Quand l'implémentation est complète
- Quand tous les tests passent
- Avant de proposer des options

**Le processus** :

```
Étape 1: Vérifier les tests
  → Lancer: npm test / cargo test / pytest / go test
  → SI ÉCHEC: corriger avant de continuer
  → SI PASS: continuer

Étape 2: Déterminer la branche de base
  → Vérifier contre main/master
  → Demander si incertain

Étape 3: Proposer les options
  1. Merger localement vers <base-branch>
  2. Push et créer une Pull Request
  3. Garder la branche (je m'en occuperai plus tard)
  4. Jeter ce travail

Étape 4: Exécuter le choix
  SI OPTION 1 (Merge local):
    → git checkout <base-branch>
    → git pull
    → git merge <feature-branch>
    → Vérifier tests sur le résultat merged

  SI OPTION 2 (Pull Request):
    → git push -u origin <feature-branch>
    → Créer la PR avec description claire

  SI OPTION 3 (Keep):
    → Laisser la branche
    → Documenter le status

  SI OPTION 4 (Discard):
    → git worktree remove <path>
    → Confirmer

Étape 5: Cleanup (optionnel)
  → Supprimer le worktree côté local
  → Supprimer la branche remote
```

**Points importants** :
- Tests doivent passer en premier
- Options claires et simples
- Pas d'auto-merge sans approbation humaine

**Output**: Travail intégré ou sauvegardé, worktree propre

---

### 11. Systematic Debugging - Techniques Avancées
**Description**: Techniques spécialisées de débogage

Le skill principal contient aussi des techniques avancées :

- **Root-Cause Tracing**: Comment tracer une cause à travers les layers
- **Defense in Depth**: Ajouter du logging/instrumentation
- **Condition-Based Waiting**: Attendre les conditions justes

Toutes utilisent le même framework RED: Investigation → Hypothèse → Test → Vérification

**Output**: Debugging systématique et fiable

---

### 12. Writing Skills
**Description**: Créer ou modifier des skills

**Quand l'utiliser** :
- Créer une nouvelle technique réutilisable
- Documenter un pattern efficace
- Adapter un skill pour un contexte spécifique

**Approche TDD pour skills** :

```
RED:    Faire échouer un agent sans le skill
GREEN:  Écrire le skill et voir l'agent l'appliquer
REFACTOR: Fermer les loopholes, améliorer la clarté
```

Vérifier avec subagent-driven-development de tests

**Output**: Nouveau skill prêt pour réutilisation

---

### 13. Using Workflow
**Description**: L'apprentissage de base - toujours chercher les skills

**Quand l'utiliser** :
- À chaque message
- Avant chaque action
- AVANT de clarifier des questions

**Red flags** :
- "C'est juste une question simple"
- "J'ai besoin de plus de contexte d'abord"
- "Laisse-moi explorer le codebase d'abord"
- "Laisse-moi rassembler l'info d'abord"

**Output**: Habitude d'utiliser les skills correctement

---

### 14. Autres Skills
**Description**: Skills de support

- **dispatching-parallel-agents**: Dispatcher plusieurs agents pour tâches indépendantes
- **receiving-code-review**: Recevoir et intégrer le feedback de review
- **using-workflow**: Rappel de toujours chercher les skills

---

## Patterns d'utilisation

### Classification des skills

Les skills se divisent en deux catégories :

**Skills Rigides** (TDD, Debugging, Verification)
- Suive exactement
- Pas d'adaptation
- Discipline non-négociable

**Skills Flexibles** (Patterns, Brainstorming)
- Adapter aux principes du contexte
- La flexibilité est dans l'application, pas l'absence

### Priorité des skills

Quand plusieurs skills s'appliquent, utiliser cet ordre :

```
1. Process skills (brainstorming, debugging)
   → Déterminés COMMENT aborder la tâche

2. Implementation skills (writing-skills, writing-plans)
   → Guides l'exécution
```

Exemple: "Let's build X" → brainstorming d'abord, puis implementation skills

### Workflow complet

La séquence standard est :

```
💭 Brainstorming (décrire + design)
    ↓
🌳 Using Git Worktrees (créer l'espace)
    ↓
📋 Writing Plans (découper en tâches)
    ↓
🔨 Subagent-Driven Development OU Executing Plans
    ↓
✅ Test-Driven Development (pendant implémentation)
    ↓
🔍 Systematic Debugging (si problèmes)
    ↓
✔️ Verification Before Completion (vérifier chaque tâche)
    ↓
👥 Requesting Code Review (après tâche complète)
    ↓
🎯 Finishing a Development Branch (finaliser)
```

Le agent invoque les skills EN FONCTION DU CONTEXTE, pas nécessairement tous.

---

## Exemples pratiques

### Exemple 1: Ajouter une nouvelle feature

**Scenario**: Utiliser directement est utile pour les features.

```
Utilisateur: "Je veux ajouter un système de cache pour les API calls"

Agent pense: "C'est une feature majeure"
  → Cherche skill applicable: brainstorming ✓
  → "Je vais utiliser brainstorming pour cette feature"

[Brainstorming]

Agent: "Voici le design validé. Prêt pour l'implémentation ?"

[Using-git-worktrees]

Agent: "Worktree créé, tests passant baseline"

[Writing-plans]

Agent: "Plan écrit avec 8 tâches bite-sized"

[Subagent-driven-development]

Agent: Lance un subagent par tâche
  - Tâche 1: Interface cache
  - Tâche 2: Memory backend
  - etc.

Chaque subagent:
  - Implement (TDD)
  - Self-review
  - Spec check
  - Quality check
  - Commit

[Finishing]

Agent: "Tests passent. Merger localement ? PR ? Keep ?"
```

### Exemple 2: Corriger un bug

**Scenario**: Bug découvert en test

```
Test échoue : "cache_ttl expired items not removed"

Agent pense: "C'est un bug"
  → Cherche skill applicable: systematic-debugging ✓
  → "Je vais utiliser systematic-debugging"

[Systematic-debugging Phase 1]

Agent:
  Lit l'erreur → Cache not cleaning up expired items
  Reproduit → TTL expires mais items restent
  Cherche changements récents → Commit X changea la cleanup logic
  Ajoute instrumentation → Log insertion/expiration/cleanup

Découverte: Cleanup trigger jamais appelé pour tâches

[Systematic-debugging Phase 2-4]

Agent:
  Hypothèse: Cleanup scheduled n'est pas appelé
  Test: Ajoute log avant cleanup
  Voir: Log n'appelle jamais la fonction
  Fix: Restaurer l'appel à schedule_cleanup()
  Vérifie: Test passe maintenant

[Test-Driven-Development]

Agent:
  Ajoute test de régression pour cache expiration
  Commit le fix

[Verification-before-completion]

Agent:
  Lancer: npm test
  Voir: Tous tests passent ✓
```

### Exemple 3: Exécuter un plan existant

**Scenario**: Plan déjà écrit, on l'exécute en parallèle

```
Agent reçoit: docs/plans/api-refactor.md

Agent pense: "J'ai un plan à exécuter"
  → Cherche skill applicable: executing-plans ✓
  → "Je vais utiliser executing-plans"

[Executing-plans Step 1]

Agent lit le plan
  Revue critique: Questions sur tâches C et D
  "J'ai une question sur le scope de la tâche C"

Utilisateur: "Tâche C devrait aussi ajouter validation"

Agent: "Compris, le plan est clair"

[Executing-plans Step 2-3]

Agent: Exécute batch 1 (tâches 1-3)
  Chaque tâche:
    - Mark in_progress
    - Suivre les étapes du plan
    - Lancer les vérifications
    - Commit
    - Mark completed

Agent rapporte:
  "✓ Tâche 1: API route créé
   ✓ Tâche 2: Controller implémenté
   ✓ Tâche 3: Tests passant
   
   Prêt pour feedback"

Utilisateur: "Looks good, continue"

[Executing-plans Step 4]

Agent: Exécute batch 2...
```

---

## Bonnes pratiques

### ✅ À FAIRE

1. **Toujours chercher les skills d'abord**
   - Avant de clarifier
   - Avant de commencer
   - Même si ça semble simple

2. **Annoncer le skill utilisé**
   ```
   "Je vais utiliser {skill} pour {purpose}"
   ```

3. **Suivre le skill exactement**
   - Pas d'adaptation "juste cette fois"
   - Pas de raccourcis
   - Pas de logique créative

4. **Vérifier avant d'affirmer**
   - Tests avant "tests pass"
   - Lancer avant "works"
   - Preuve avant affirmation

5. **Chercher les red flags**
   - "Devrait fonctionner" → Lancer la commande
   - "Je suis confiant" → Preuve ?
   - "Juste une fois" → Non

6. **Commits fréquents et atomiques**
   - Une tâche = un commit
   - Messages clairs
   - État vérifiable

7. **Instrumentation diagnostique**
   - Log ce qui entre/sort de chaque composant
   - Ajouter quand débugger
   - Garder pour la compréhension

### ❌ À ÉVITER

1. **NE PAS skip les phases du skill**
   - Systematic-debugging phase 1 est obligatoire
   - Verification est obligatoire
   - Brainstorming n'est pas optionnel

2. **NE PAS coder avant un test**
   - TDD signifie RED d'abord
   - Code écrit avant test = DELETE
   - Pas de "ref code"

3. **NE PAS accepter un feedback sans comprendre**
   - "You're right" sans vérification = mensonge
   - Ask if unclear
   - Pousser back si techniquement faux

4. **NE PAS rationaliser les exceptions**
   - "This time is different" → Non
   - "I'll hurry" → Non
   - "Seems simple" → Skills existent pour les choses "simples"

5. **NE PAS faire l'affirmation avant vérification**
   - Preuve d'abord
   - Affirmation après
   - Pas de "should work"

6. **NE PAS négliger la documentation**
   - Designs sauvegardés
   - Plans écrits explicitement
   - Raisons documentées

---

## Intégration avec les systèmes

### Claude Code

```
Dans Claude Code, les skills sont disponibles via Skill tool
/plugin install superpowers@superpowers-marketplace
```

### GitHub Copilot

```
Installer via GitHub Copilot CLI (en développement)
copilot plugin install superpowers
```

### Codex / OpenCode

```
Configuration manuelle en cours (voir docs/)
```

---

## Troubleshooting

### Agent ne trouve pas le skill

**Vérifier:**
- Skill file existe dans skills/<skill-name>/SKILL.md
- Frontmatter est valide (name, description)
- Skill name utilise lettre/chiffre/tirets uniquement

### Agent skip le skill

**Red flags** :
- L'agent pense "c'est simple"
- L'agent voulait "juste vérifier quelque chose"
- Agent rationalisait une exception

**Solution** :
- Rappeler la règle du 1%
- TOUS les skills possibles doivent être vérifiés
- Pas de rationalisation

### Plan n'est pas suivi

**Checker** :
- Agent suit chaque étape du plan ?
- Agent lance les vérifications explicitées ?
- Agent commit après chaque étape ?

**Solution** :
- Pointing au skill appropriate
- Être strict sur la suivance

### Tests passent mais "quelque chose sent mauvais"

**Utiliser** :
- requesting-code-review
- Ajouter plus de tests edge cases
- Ajouter instrumentation

---

## Ressources

- [README principal](../README.md)
- Skills individuels dans [skills/](../skills/)
- Exemples de tests dans [tests/](../tests/)
- Documentations spécialisées dans [docs/](../)

---

**Dernière mise à jour**: Février 2026
**Version**: 1.0 - Documentation complète des skills

