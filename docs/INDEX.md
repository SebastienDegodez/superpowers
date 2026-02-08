# Index Complet - Documentation des Skills Superpowers

## 📍 Tu es ici

Tu cherches a comprendre comment utiliser les skills de Superpowers pour développement logiciel.

### 🎯 Choisis par où commencer :

| Situation | Lis | Temps |
|-----------|-----|-------|
| Je suis nouveau | [QUICK-START-SKILLS.md](#quick-start) | 15 min |
| Je veux tout comprendre | [GUIDE-UTILISATION-SKILLS.md](#guide-complet) | 1-2 heures |
| J'ai besoin d'une ref rapide | [CHEAT-SHEET-SKILLS.md](#cheat-sheet) | 5 min |
| Je veux voir des exemples | [CAS-D-USAGE-SKILLS.md](#cas-dusage) | 30-45 min |
| Je sais déjà, juste un truc rapide | Voir [Arbre de Décision](#arbre-de-décision) | 2 min |

---

## 📚 Documents de Documentation

### <a name="quick-start"></a>🚀 QUICK-START-SKILLS.md
**Pour**: Débutants qui veulent démarrer vite

**Contient**:
- 3 règles essentielles
- 7 cours de base expliqués simplement
- Workflow complet pour une feature
- Red flags (signes d'avoir oublié un skill)
- Tips & tricks

**Lire si**: C'est ta première fois avec Superpowers

**Ne lis pas si**: Tu veux une explication technique complète

---

### <a name="guide-complet"></a>📖 GUIDE-UTILISATION-SKILLS.md
**Pour**: Qui veut comprendre profondément tous les skills

**Contient**:
- Vue d'ensemble complète du système
- Architecture des skills (frontmatter, structure)
- Chaque skill expliqué en détail (14 skills)
- Quand l'utiliser, le processus exact, principes clés
- Patterns d'utilisation (skills rigides vs flexibles)
- Bonnes pratiques et anti-patterns
- Troubleshooting

**Lire si**: Tu veux références exhaustives

**Ne lis pas si**: Tu es pressé (lis Quick Start instead)

---

### <a name="cheat-sheet"></a>⚡ CHEAT-SHEET-SKILLS.md
**Pour**: Référence rapide pendant le travail

**Contient**:
- Arbre de décision (quel skill utiliser?)
- Checklists par phase
- Commandes fréquentes
- Conversion "affirmations sans preuve" → "affirmations avec preuve"
- Red flags et STOP conditions
- Template d'invocation de skill
- Tableau résumé des skills
- Patterns de conversation

**Lire si**: Tu as besoin d'une reference pendant que tu codes

**Frequence**: Consulter 10-20 fois par jour

---

### <a name="cas-dusage"></a>💼 CAS-D-USAGE-SKILLS.md
**Pour**: Voir comment les skills s'utilisent dans la pratique

**Contient**:
- 4 cas d'usage complets (début à fin)
  - Créer une feature majeure (caching)
  - Corriger un bug complexe
  - Exécuter un plan existant
  - Paralléliser le débogage
- Chaque cas montre: commandes, output, dialogue
- Patterns d'intégration (workflows réels)
- Anti-patterns à éviter
- Conseils pratiques

**Lire si**: Tu veux voir des exemples concrets

**Valeur**: Augmente confiance en comprenant la "vraie" utilisation

---

## 🎨 Arbre de Décision

### Je dois faire quoi maintenant ?

```
┌─ C'est une NOUVELLE FEATURE
│  └─ BRAINSTORMING
│     └─ USING-GIT-WORKTREES
│        └─ WRITING-PLANS
│           └─ SUBAGENT-DRIVEN-DEVELOPMENT ou EXECUTING-PLANS
│              └─ TEST-DRIVEN-DEVELOPMENT (pendant)
│                 └─ FINISHING-A-DEVELOPMENT-BRANCH
│
├─ Y a un BUG / TEST ÉCHOUE
│  └─ SYSTEMATIC-DEBUGGING (Phase 1 obligatoire)
│     └─ Proposer hypothèse
│        └─ TEST la solution
│           └─ TEST-DRIVEN-DEVELOPMENT pour le fix
│              └─ VERIFICATION-BEFORE-COMPLETION
│
├─ CODE EST ÉCRIT, besoin REVIEW
│  └─ REQUESTING-CODE-REVIEW
│
├─ Prêt à FINALISER le travail
│  └─ FINISHING-A-DEVELOPMENT-BRANCH
│
├─ Plusieurs TÂCHES INDÉPENDANTES
│  └─ DISPATCHING-PARALLEL-AGENTS
│
└─ Je dois CRÉER un nouveau SKILL
   └─ WRITING-SKILLS
```

---

## 📋 Répertoire des Skills

### Skills Disponibles (14 total)

| # | Skill | Phase | Durée | Statut | Doc |
|---|-------|-------|-------|--------|-----|
| 1 | **Brainstorming** | Conception | 15-45 min | Core | ✅ [SKILL.md](../skills/brainstorming/SKILL.md) |
| 2 | **Using Git Worktrees** | Setup | 2-5 min | Core | ✅ [SKILL.md](../skills/using-git-worktrees/SKILL.md) |
| 3 | **Writing Plans** | Planification | 30-60 min | Core | ✅ [SKILL.md](../skills/writing-plans/SKILL.md) |
| 4 | **Test-Driven Development** | Implémentation | Per-task | Core | ✅ [SKILL.md](../skills/test-driven-development/SKILL.md) |
| 5 | **Systematic Debugging** | Débogage | 30m-2h | Core | ✅ [SKILL.md](../skills/systematic-debugging/SKILL.md) |
| 6 | **Subagent-Driven Dev** | Exécution | 1-3 hours | Core | ✅ [SKILL.md](../skills/subagent-driven-development/SKILL.md) |
| 7 | **Executing Plans** | Exécution | 30m/batch | Core | ✅ [SKILL.md](../skills/executing-plans/SKILL.md) |
| 8 | **Requesting Code Review** | Review | 10-30 min | Support | ✅ [SKILL.md](../skills/requesting-code-review/SKILL.md) |
| 9 | **Receiving Code Review** | Review | Variable | Support | ✅ [SKILL.md](../skills/receiving-code-review/SKILL.md) |
| 10 | **Verification Before Completion** | Vérification | 5 min | Core | ✅ [SKILL.md](../skills/verification-before-completion/SKILL.md) |
| 11 | **Finishing a Development Branch** | Intégration | 5-10 min | Core | ✅ [SKILL.md](../skills/finishing-a-development-branch/SKILL.md) |
| 12 | **Dispatching Parallel Agents** | Parallélisation | Variable | Support | ✅ [SKILL.md](../skills/dispatching-parallel-agents/SKILL.md) |
| 13 | **Using Workflow** | Méta | - | Core | ✅ [SKILL.md](../skills/using-workflow/SKILL.md) |
| 14 | **Writing Skills** | Création | 1-3 hours | Advanced | ✅ [SKILL.md](../skills/writing-skills/SKILL.md) |

**Legend**: 
- **Core**: Skills essentiels, utilisés souvent
- **Support**: Skills complémentaires, utilisés quand pertinent
- **Advanced**: Skills pour cas spécialisés

---

## 📚 Lecture Recommandée par Profil

### 👤 Profil: Absolument Débutant

1. **QUICK-START-SKILLS.md** (15 min)
   - Comprendre les 3 règles
   - Lire 7 core skills simplement
   
2. **Essayer une petite feature** (2-3 heures)
   - Brainstorming
   - Plans
   - Basic coding avec TDD

3. **CHEAT-SHEET-SKILLS.md** (5 min)
   - Sauvegarder comme marque-page

4. **CAS-D-USAGE-SKILLS.md** (30 min)
   - Lire le cas 1 (feature complète)

---

### 👤 Profil: Développeur avec expérience

1. **GUIDE-UTILISATION-SKILLS.md** (1 hour)
   - Lire section par section
   - Focus: Architecture des skills, quand l'utiliser
   
2. **CHEAT-SHEET-SKILLS.md** (5 min)
   - Sauvegarder comme référence

3. **Skills individuels** (au besoin)
   - Lire skills/*/SKILL.md pour détails spécifiques

---

### 👤 Profil: Team Lead / Manager

1. **QUICK-START-SKILLS.md** (15 min)
   - Comprendre workflow général
   
2. **CAS-D-USAGE-SKILLS.md** (30 min)
   - Voir impact sur délais/qualité

3. **README principal** (../README.md)
   - Voir sponsorship, installation

---

### 👤 Profil: Performance Tuner

1. **CHEAT-SHEET-SKILLS.md** (5 min)
   - Commandes, patterns

2. **Skill spécific** documents
   - Lire skill.md pour depth

3. **Cas d'usage pertinents** (CAS-D-USAGE-SKILLS.md)
   - Patterns relevants

---

## 🔍 Trouver une Réponse Spécifique

### "Comment utiliser skill X?"

Chercher dans cet ordre:

1. **CHEAT-SHEET**: Tableau skill avec durée/usage (2 sec)
2. **GUIDE**: Chercher heading "### X" (2 min)
3. **CAS-D-USAGE**: Chercher mention de X dans cas (5 min)
4. **SKILL.md**: Lire le fichier skill lui-même (5-10 min)

---

### "Que faire si Y se produit?"

1. **La question est technique?** → GUIDE-UTILISATION-SKILLS.md → "Bonnes pratiques"
2. **C'est un red flag?** → CHEAT-SHEET-SKILLS.md → "Red Flags"
3. **Je veux un exemple?** → CAS-D-USAGE-SKILLS.md
4. **C'est dans un skill spécifique?** → skills/*/SKILL.md

---

### "Comment apprendre rapidement?"

1. **5 minutes**: QUICK-START-SKILLS.md
2. **30 min**: Essayer une tiny feature avec Brainstorming + Plans
3. **5 min**: CHEAT-SHEET-SKILLS.md
4. **1 hour**: GUIDE-UTILISATION-SKILLS.md (première pass)
5. **Ongoing**: Consulter selon besoin

---

## 🎯 Objectifs d'Apprentissage par Étape

### Étape 1: Comprendre le concept
- [ ] Lire QUICK-START
- [ ] Comprendre les 3 règles
- [ ] Identifier les 7 core skills

### Étape 2: Essayer en pratique
- [ ] Essayer brainstorming sur une petite feature
- [ ] Utiliser TDD sur une fonction
- [ ] Lire un plan d'implémentation

### Étape 3: Utiliser complètement
- [ ] Faire une feature complète (Brainstorm → Plan → Code → Test)
- [ ] Utiliser subagent-driven-dev
- [ ] Finir, merger, célébrer

### Étape 4: Maîtriser les patterns
- [ ] Lire CAS-D-USAGE completement
- [ ] Reconnaître les anti-patterns
- [ ] Appliquer les Tips & Tricks

### Étape 5: Expertise
- [ ] Lire GUIDE completement
- [ ] Consulter skills individuels
- [ ] Créer custom skills si needed

---

## 🏗️ Structure du Répertoire

```
docs/
  ├── GUIDE-UTILISATION-SKILLS.md      ← Guide complet (tu es ici!)
  ├── QUICK-START-SKILLS.md            ← Pour débutants
  ├── CHEAT-SHEET-SKILLS.md            ← Référence rapide
  ├── CAS-D-USAGE-SKILLS.md            ← Exemples concrets
  ├── INDEX.md                         ← Ce fichier
  ├── plans/                           ← Exemples de plans
  └── windows/
      └── polyglot-hooks.md            ← Configuration spécifique

skills/
  ├── brainstorming/
  ├── using-git-worktrees/
  ├── writing-plans/
  ├── test-driven-development/
  ├── systematic-debugging/
  ├── subagent-driven-development/
  ├── executing-plans/
  ├── requesting-code-review/
  ├── receiving-code-review/
  ├── verification-before-completion/
  ├── finishing-a-development-branch/
  ├── dispatching-parallel-agents/
  ├── using-workflow/
  └── writing-skills/

tests/                                  ← Tests et examples
  ├── github-copilot/
  ├── explicit-skill-requests/
  ├── claude-code/
  └── ...
```

---

## 📞 Support & Ressources

### Fichiers Originaux des Skills
Chaque skill a sa propre doc:
- `skills/<skill-name>/SKILL.md` - Définition et processus exact

### Repository
- GitHub: github.com/obra/superpowers
- Issues: Pour bugs et questions

### Installation
- See top-level README.md for platform-specific setup

---

## 🎓 Ressources Supplémentaires

### Lectures Recommandées
1. **"Red Green Refactor"** - Pattern TDD fondamental
2. **"Root Cause Analysis"** - Pour debugging systématique
3. **"Atomic Commits"** - Pattern de git

### Vidéos (si disponibles)
- Superpowers demo (en développement)
- Subagent-driven-development walkthrough (en développement)

### Communauté
- Discussions sur GitHub
- Issues tracked publicly

---

## ✅ Checklist Avant Utilisation

Avant de démarrer, vérifie que tu sais:

- [ ] Qu'est-ce qu'un skill?
- [ ] Les 3 règles essentielles
- [ ] Arbre de décision: quel skill utiliser?
- [ ] Où trouver une référence rapide (CHEAT-SHEET)
- [ ] Où trouver un exemple (CAS-D-USAGE)
- [ ] Comment annoncer un skill

---

## 🚀 Prochaines Étapes

### ✅ Tu as lu ce Index. Maintenant:

1. **Choisis ton point de départ**:
   - Nouveau? → QUICK-START
   - Curieux? → GUIDE
   - Pressé? → CHEAT-SHEET
   - Pragmatique? → CAS-D-USAGE

2. **Lis le document choisi**

3. **Essaye avec une petite tâche**

4. **Sauve les références** (CHEAT-SHEET) pour consultations rapides

5. **Relis GUIDE au besoin** pour clarifications

---

## 📝 Version & Mise à Jour

- **Version**: 1.0 - Documentation complète
- **Date**: Février 2026
- **Couverture**: 14 skills, 4 approaches, patterns complets
- **Langage**: Français
- **Status**: ✅ Complete et testée

---

**Prêt? Commence par [QUICK-START-SKILLS.md](QUICK-START-SKILLS.md) si tu es nouveau, ou [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md) si tu veux juste une référence rapide!**

