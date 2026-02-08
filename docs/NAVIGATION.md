# Superpowers Documentation - Navigation Guide

## 📖 Quel Document Lire ?

Réponds à ces questions pour trouver le bon document :

### Question 1: Quel est ton niveau d'expérience avec Superpowers?

- **Je découvre pour la première fois** → Va à [Question 2](#question-2)
- **Je l'ai utilisé un peu** → Va à [Question 3](#question-3)
- **Je sais comment ça marche** → Va à [Question 4](#question-4)

### Question 2: Tu as combien de temps?

- **5 minutes maximum** → [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md) - Référence rapide
- **15-30 minutes** → [QUICK-START-SKILLS.md](QUICK-START-SKILLS.md) - Tutorial pour débutants
- **1-2 heures** → [GUIDE-UTILISATION-SKILLS.md](GUIDE-UTILISATION-SKILLS.md) - Complet et détaillé

### Question 3: Tu veux quoi maintenant?

- **Voir comment ça marche en pratique** → [CAS-D-USAGE-SKILLS.md](CAS-D-USAGE-SKILLS.md) - Exemples concrets
- **Une référence rapide** → [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md) - Tables et checklists
- **Comprendre les détails** → [GUIDE-UTILISATION-SKILLS.md](GUIDE-UTILISATION-SKILLS.md) - Explication complète

### Question 4: Que fais-tu maintenant?

- **Je dois utiliser un skill spécifique** → [skills/<skill-name>/SKILL.md](../skills) - Doc du skill
- **J'ai besoin d'une réponse rapide** → [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md) - Arbre de décision
- **Je veux connaître les patterns** → [CAS-D-USAGE-SKILLS.md](CAS-D-USAGE-SKILLS.md) - Workflows réels
- **Je déboue un problème** → [GUIDE-UTILISATION-SKILLS.md](GUIDE-UTILISATION-SKILLS.md#bonnes-pratiques) - Section troubleshooting

---

## 📚 Résumé Rapide des Documents

### 🚀 QUICK-START-SKILLS.md
**Pour qui**: Débutants absolus  
**Durée**: 15 minutes  
**Contient**: 3 règles, 7 core skills, workflow simple  
**Lire si**: C'est ta première fois

### 📖 GUIDE-UTILISATION-SKILLS.md
**Pour qui**: Qui veut tout comprendre  
**Durée**: 1-2 heures (première pass)  
**Contient**: Tous les details, tous les 14 skills, patterns, troubleshooting  
**Lire si**: Tu veux expertise complète

### ⚡ CHEAT-SHEET-SKILLS.md
**Pour qui**: Qui a besoin d'une reference rapide  
**Durée**: 5 minutes par consultation  
**Contient**: Tableaux, arbre de décision, commandes, checklists  
**Consulter**: 10-20 fois par jour pendant qu'on code

### 💼 CAS-D-USAGE-SKILLS.md
**Pour qui**: Qui veut voir des exemples concrets  
**Durée**: 30-45 minutes  
**Contient**: 4 workflows complets, patterns d'intégration, anti-patterns  
**Lire si**: Tu veux voir comment c'est utilisé en pratique

### 📍 INDEX.md
**Pour qui**: Navigation entre tous les documents  
**Durée**: 5-10 minutes  
**Contient**: Organisation, arbre de décision, checklist d'apprentissage  
**Lire si**: Tu as besoin de t'orienter

---

## 🎯 Plans de Lecture par Profil

### 👶 Débutant absolu

**Jour 1-2 (30 min total)**:
1. QUICK-START-SKILLS.md (15 min)
2. Essayer une toute petite feature (15 min)

**Jour 3 (5 min)**:
1. Sauvegarder CHEAT-SHEET comme marque-page

**Jour 4-5 (1-2 heures)**:
1. CAS-D-USAGE-SKILLS.md - Cas 1 (30 min)
2. Essayer une feature moyenne (1 hour)

**Semaine 2**:
1. GUIDE-UTILISATION-SKILLS.md au besoin (par question)
2. Continuer avec features réelles

---

### 💻 Développeur expérimenté

**Session 1 (1 hour)**:
1. GUIDE-UTILISATION-SKILLS.md → "Architecture" + "Catalogue"
2. Consulter skills individuels pour détails

**Session 2 (30 min)**:
1. CAS-D-USAGE-SKILLS.md → Cas 1 & 2
2. CHEAT-SHEET comme reference

**Ongoing**:
1. Utiliser CHEAT-SHEET pendant le dev
2. Relire GUIDE sections spécifiques au besoin

---

### 👨‍💼 Team Lead / Manager

**Lecture (30 min)**:
1. QUICK-START-SKILLS.md (15 min)
2. CAS-D-USAGE-SKILLS.md - Cas 1 & 2 (15 min)

**Takeaways**:
- Workflow structure
- Impact sur délais et qualité
- Comment monitorer le progress

---

### ⚙️ Performance Tuner

**Reference (15 min)**:
1. CHEAT-SHEET-SKILLS.md (5 min)
2. Cas d'usage spécifiques dans CAS-D-USAGE (10 min)

**Consulting**:
1. CHEAT-SHEET comme reference continue
2. GUIDE sections "Bonnes Pratiques"

---

## 🗺️ Map des Concepts

```
Skills Superpowers
├── Conception
│   └── brainstorming (QUICK: section 2, GUIDE: section Brainstorming)
├── Setup
│   └── using-git-worktrees (QUICK: section 2, GUIDE: section Git Worktrees)
├── Planification
│   └── writing-plans (QUICK: section 2, GUIDE: section Plans)
├── Implémentation
│   ├── test-driven-development (tous les docs)
│   ├── subagent-driven-development (GUIDE: section Subagent, CAS: Cas 1)
│   └── executing-plans (GUIDE: section Executing, CAS: Cas 3)
├── Débogage
│   └── systematic-debugging (QUICK: section 2, GUIDE: section Debug, CAS: Cas 2)
├── Review
│   ├── requesting-code-review (GUIDE section)
│   └── receiving-code-review (GUIDE section)
├── Vérification
│   └── verification-before-completion (tous les docs)
└── Finalisation
    └── finishing-a-development-branch (tous les docs)

Support Skills:
├── dispatching-parallel-agents (GUIDE: section, CAS: Cas 4)
├── using-workflow (Concept dans tous les docs)
└── writing-skills (GUIDE: section, avancé)
```

---

## 🔍 Index par Concept

### Quand je dois faire X, lire:

| Je dois... | Lis | Durée |
|-----------|-----|-------|
| Créer une feature | QUICK 3 + GUIDE "Brainstorming" | 20 min |
| Comprendre TDD | QUICK 2 + GUIDE "Test-Driven Dev" | 30 min |
| Déboguer un bug | GUIDE "Debugging" + CAS 2 | 45 min |
| Exécuter un plan | GUIDE "Executing Plans" + CAS 3 | 20 min |
| Vérifier mon code | GUIDE "Verification" + CHEAT section | 10 min |
| Voir un workflow complet | CAS 1 (feature) ou CAS 2 (bug) | 30 min |
| Trouver une commande | CHEAT "Commandes Fréquentes" | 2 min |
| Comprendre un skill X | skills/X/SKILL.md + GUIDE | 10-20 min |
| Merger mon travail | GUIDE "Finishing" + CHEAT checklist | 10 min |
| Troubleshooter un problème | GUIDE "Bonnes Pratiques" + CHEAT "Red Flags" | 15 min |

---

## 📋 Checklists de Lecture

### ✅ Checklist: Devenir Expert Superpowers

- [ ] Lire QUICK-START-SKILLS (15 min)
- [ ] Essayer 1 feature avec Brainstorming + Plan (2-3 heures)
- [ ] Lire CHEAT-SHEET (5 min) et le sauvegarder
- [ ] Lire CAS-D-USAGE cas 1 & 2 (30 min)
- [ ] Essayer 1 feature avec subagent-driven-development (2-3 heures)
- [ ] Lire GUIDE-UTILISATION complètement (1-2 heures)
- [ ] Essayer 1 débogage avec systematic-debugging (1-2 heures)
- [ ] Lire CAS-D-USAGE cas 3 & 4 (20 min)
- [ ] Consulter GUIDE au besoin pendant le dev (ongoing)

**Temps total**: 15-20 heures réparties sur 2-4 semaines

---

### ✅ Checklist: Commencer Aujourd'hui (30 min)

- [ ] Lire QUICK-START-SKILLS (15 min)
- [ ] Sauvegarder CHEAT-SHEET comme marque-page
- [ ] Essayer 1 tiny feature avec brainstorming (15 min)
- [ ] Recommander à un collègue

---

### ✅ Checklist: Débuter Tout de Suite

- [ ] Ouvrir CHEAT-SHEET arbre de décision
- [ ] Identifier ton besoin actuel
- [ ] Lancer le skill recommandé
- [ ] Revenir à CHEAT-SHEET si tu as une question

---

## 🚨 Avertissements

### ⚠️ NE PAS faire:

- Lire tous les documents d'un coup (overthinking)
- Lire GUIDE en detail avant d'avoir essayé (théorie trop tôt)
- Penser que c'est compliqué (c'est simple, juste structuré)
- Skipp une phase du skill "pour aller plus vite" (ca prend longet après)

### ✅ À FAIRE:

- Commencer par QUICK-START si nouveau
- Essayer une feature immédiatement après
- Sauvegarder CHEAT-SHEET
- Consulter GUIDE ou skill.md au besoin
- Revoir CAS-D-USAGE pour patterns

---

## 📱 Pour Mobile/Offline

Si tu dois lire offline:

1. **Minimal** (essentiels seulement):
   - QUICK-START-SKILLS.md
   - CHEAT-SHEET-SKILLS.md

2. **Standard** (bon équilibre):
   - QUICK-START-SKILLS.md
   - CHEAT-SHEET-SKILLS.md
   - CAS-D-USAGE-SKILLS.md

3. **Complet** (reference totale):
   - Tous les docs dans docs/
   - Tous les skills.md dans skills/

---

## 🔗 Navigation Rapide

### Depuis n'importe quel document:

**Comment revenir à l'index?**
→ Va à [INDEX.md](INDEX.md)

**Comment trouver un skill spécifique?**
→ Va à [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md) "Skills Summary Table"

**Comment voir un exemple?**
→ Va à [CAS-D-USAGE-SKILLS.md](CAS-D-USAGE-SKILLS.md)

**Comment avoir une reference rapide?**
→ Va à [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md)

**Comment apprendre depuis zéro?**
→ Va à [QUICK-START-SKILLS.md](QUICK-START-SKILLS.md)

---

## 👥 Partager avec d'Autres

### Pour un collègue nouveau:
1. Share: [QUICK-START-SKILLS.md](QUICK-START-SKILLS.md)
2. Demande qu'il essaye une feature
3. Share: [CHEAT-SHEET-SKILLS.md](CHEAT-SHEET-SKILLS.md)

### Pour un manager:
1. Share: [INDEX.md](INDEX.md) "Profil: Team Lead"

### Pour un team:
1. Share: [INDEX.md](INDEX.md)
2. Laisser chacun choisir son chemin

---

## 📞 Questions Fréquentes de Navigation

**Q: Comment lire rapidement?**
A: QUICK-START (15 min) + CHEAT-SHEET (bookmark)

**Q: Où consulter une commande?**
A: CHEAT-SHEET section "Commandes Fréquentes"

**Q: Où trouver les red flags?**
A: CHEAT-SHEET section "Red Flags & Stops"

**Q: Où voir un workflow complet?**
A: CAS-D-USAGE-SKILLS.md "Cas d'Usage 1"

**Q: Où apprendre un skill spécifique?**
A: skills/<skill-name>/SKILL.md ou GUIDE section du skill

**Q: Où trouver les bonnes pratiques?**
A: GUIDE "Bonnes Pratiques" ou CAS-D-USAGE "Conseils Pratiques"

---

## 🎓 Progression Recommandée

### Week 1: Découverte
- Day 1-2: QUICK-START (théorie)
- Day 3-5: Essayer 1-2 features simples
-Day 6-7: Relire QUICK-START, sauvegarder CHEAT-SHEET

### Week 2: Pratique
- Day 1-3: Essayer features avec plans
- Day 4-5: Essayer subagent-driven-dev
- Day 6-7: Déboguer avec systematic-debugging

### Week 3-4: Maîtrise
- Lire GUIDE progressivement
- Essayer tous les patterns d'intégration
- Consulter CAS-D-USAGE pour patterns avancés

---

## 📊 Statistiques de Documentation

- **4 guides principaux**: QUICK, GUIDE, CHEAT, CAS
- **1 index**: INDEX.md (ce fichier)
- **14 skills individuels**: skills/*/SKILL.md
- **~30,000 mots**: Documentation complète
- **Temps lecture complète**: 3-4 heures
- **Temps apprentissage pratique**: 15-20 heures over 2-4 weeks

---

## ✨ Tips pour Apprendre Vite

1. **Lis QUICK-START d'abord** - 15 min, donne les bases
2. **Essaye tout de suite** - Theorie + pratique = apprentissage
3. **Utilise CHEAT-SHEET** - Sauvegarde, consulte souvent
4. **Relis les sections pertinentes** - Comprendre vient avec repetition
5. **Pose des questions** - Postes des issues, cherche dans docs
6. **Partage avec d'autres** - Teaching reinforces learning

---

**Prêt? Clique sur le document de ton choix dans le tableau ci-dessus et begin!**

