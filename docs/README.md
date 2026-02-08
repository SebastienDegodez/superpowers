# 🎯 Documentation Superpowers Skills - Bienvenue!

## Qu'est-ce que Superpowers?

**Superpowers** est un framework complet de développement logiciel composé de **14 "skills"** réutilisables que les agents codeurs utilisent pour créer du code de qualité.

Au lieu de coder directement, les agents suivent un processus structuré :

```
💭 Concevoir → 📐 Isoler → 📋 Planifier → 🔨 Implémenter → ✅ Vérifier → 🎯 Finaliser
```

---

## 🚀 Commencer en 5 Minutes

### 3 Règles Essentielles

1. **Cherche toujours un skill en premier**
   - Avant de faire quoi que ce soit
   - Même si ça semble simple
   - "Si y a 1% de chance qu'un skill s'applique, invoque-le"

2. **Suis le skill EXACTEMENT**
   - C'est un processus, pas une suggestion
   - Pas de raccourcis "juste cette fois"
   - La discipline = meilleur code

3. **Vérifie avant d'affirmer le succès**
   - Pas de "ça devrait marcher"
   - Lancer la commande, montrer la preuve
   - "Tests pass: 34/34 ✓" (pas juste "Tests pass!")

---

## 📚 Où Lire Quoi?

### 🎯 Tu as 5 minutes?
→ Lis [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md)
- Arbre de décision
- Tableau des skills
- Commandes fréquentes

### 🎯 Tu as 15 minutes?
→ Lis [QUICK-START-SKILLS.md](./QUICK-START-SKILLS.md)
- Les 3 règles
- 7 core skills
- Workflow simple

### 🎯 Tu veux tout comprendre?
→ Lis [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md)
- Tous les 14 skills
- Patterns d'utilisation
- Bonnes pratiques

### 🎯 Tu veux voir des exemples?
→ Lis [CAS-D-USAGE-SKILLS.md](./CAS-D-USAGE-SKILLS.md)
- 4 workflows complets
- Patterns réels
- Code concrete

### 🎯 Tu es perdu?
→ Va à [NAVIGATION.md](./NAVIGATION.md)
- Questions pour trouver le bon doc
- Plans de lecture par profil
- Index des concepts

---

## 💡 Les 7 Core Skills (À Connaître)

### 1. 🧠 Brainstorming
**Quand**: Nouvelle feature, changement majeur  
**Quoi**: Poser des questions, proposer approches, valider design  
**Durée**: 15-45 min

### 2. 🌳 Using Git Worktrees
**Quand**: Avant de coder une feature  
**Quoi**: Créer workspace isolé, vérifier baseline  
**Durée**: 2-5 min

### 3. 📋 Writing Plans
**Quand**: Après design validé  
**Quoi**: Découper en tâches 2-5 min, plan détaillé  
**Durée**: 30-60 min

### 4. 🧪 Test-Driven Development
**Quand**: Toujours, pendant implémentation  
**Quoi**: RED (test fail) → GREEN (code pass) → REFACTOR  
**Durée**: Per task

### 5. 🔍 Systematic Debugging
**Quand**: Bug trouvé, test échoue  
**Quoi**: Trouver cause racine, hypothèse, test, vérifier  
**Durée**: 30 min - 2 hours

### 6. 🤖 Subagent-Driven Development
**Quand**: Exécuter un plan  
**Quoi**: Un subagent par tâche, review auto, commit auto  
**Durée**: 1-3 hours

### 7. ✔️ Finishing a Development Branch
**Quand**: Feature finie, tests passent  
**Quoi**: Vérifier, proposer merge/PR/keep/discard  
**Durée**: 5 min

---

## 📖 Index Complet

| Document | Durée | Pour Qui | Contient |
|----------|-------|---------|---------|
| [QUICK-START-SKILLS.md](./QUICK-START-SKILLS.md) | 15 min | Débutants | 3 règles, 7 skills, workflow |
| [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md) | 1-2h | Qui veut tout | Tous 14 skills, patterns, bonnes pratiques |
| [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md) | 5 min | Pendant le dev | Arbre de décision, commandes, checklists |
| [CAS-D-USAGE-SKILLS.md](./CAS-D-USAGE-SKILLS.md) | 30 min | Qui veut examples | 4 workflows complets, patterns réels |
| [INDEX.md](./INDEX.md) | 5-10 min | Navigation | Répertoire complet, plans de lecture |
| [NAVIGATION.md](./NAVIGATION.md) | 5-10 min | S'orienter | Questions, guides par profil, FAQ |
| [RESUME.md](./RESUME.md) | 5 min | Vue globale | Ce qui a été créé, statistiques |

---

## 🎓 Plan d'Apprentissage Recommandé

### **Jour 1-2** (30 minutes)
1. Lire [QUICK-START-SKILLS.md](./QUICK-START-SKILLS.md) (15 min)
2. Sauvegarder [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md) comme marque-page
3. Essayer 1 petite feature avec brainstorming (15 min)

### **Jour 3-7** (5-10 heures)
1. Essayer 2-3 features avec full workflow
2. Lire [CAS-D-USAGE-SKILLS.md](./CAS-D-USAGE-SKILLS.md) (30 min)
3. Consulter [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md) pour questions spécifiques

### **Semaine 2+** (Ongoing)
1. Consulter [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md) pendant le dev
2. Lire [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md) sections au besoin
3. Se référer aux skills individuels (skills/*/SKILL.md) pour détails

---

## 🚨 Red Flags (Signes d'avoir Oublié un Skill)

Si tu entends l'agent dire:
- ❌ "Je vais juste coder rapidement" → Brainstorming + Plans manquent
- ❌ "Ca devrait marcher" → Verification manque
- ❌ "Je suis confiant" → Tests manquent  
- ❌ "Laisses-moi explorer le code" → Debugging skill manque
- ❌ "One quick fix" → Root cause investigation manque

→ **Rappelle à l'agent de chercher un skill!**

---

## 💻 Exemple Rapide: Ajouter une Feature

```
User: "Ajoute un système de cache"

Agent: "Je vais utiliser brainstorming"
  [Pose questions, explore, design]
  Done ✓
  
Agent: "Je vais utiliser using-git-worktrees"
  [Crée workspace isolé]
  Done ✓
  
Agent: "Je vais utiliser writing-plans"
  [Crée plan détaillé avec 5 tâches]
  Done ✓
  
Agent: "Je vais utiliser subagent-driven-development"
  [Exécute chaque tâche avec review auto]
  Done ✓
  
Agent: "Je vais utiliser finishing-a-development-branch"
  [Merger ou créer PR]
  Done ✓

Temps total: 2-4 heures, Code qualité: Excellent! ✨
```

---

## 📞 Questions Rapides?

### "Quel skill utiliser?"
→ [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md) - Arbre de décision

### "Comment faire X?"
→ [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md) - Chercher skill X

### "Voir un exemple de X?"
→ [CAS-D-USAGE-SKILLS.md](./CAS-D-USAGE-SKILLS.md)

### "Où commencer?"
→ [QUICK-START-SKILLS.md](./QUICK-START-SKILLS.md) - 15 minutes

### "Je suis perdu"
→ [NAVIGATION.md](./NAVIGATION.md) - Guide d'orientation

---

## 🎯 Ce Que Tu Peux Faire Avec Superpowers

✅ **Créer une feature majeure** → brainstorming + plan + subagent-dev  
✅ **Corriger un bug complexe** → systematic debugging + TDD  
✅ **Déboguer rapidement** → root cause analysis + verification  
✅ **Paralléliser le travail** → dispatching parallel agents  
✅ **Vérifier la qualité** → requesting code review  
✅ **Merger en confiance** → finishing branch avec tests vérifiés  

---

## 📊 Statistiques Documentation

- **6 documents** bien structurés
- **~55,000 mots** en français
- **14 skills** couverts complètement
- **4 cas d'usage** complets
- **50+ code examples**
- **15+ diagrammes/flowcharts**
- **100+ checklists & references**

---

## ✨ Prochaines Étapes

### **Option 1: Rapide** (15 min pour commencer)
1. Lis [QUICK-START-SKILLS.md](./QUICK-START-SKILLS.md)
2. Sauvegarde [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md)
3. Essaye une petite feature

### **Option 2: Complet** (1-2 hours pour tout)
1. Lis [GUIDE-UTILISATION-SKILLS.md](./GUIDE-UTILISATION-SKILLS.md)
2. Lis [CAS-D-USAGE-SKILLS.md](./CAS-D-USAGE-SKILLS.md)
3. Sauvegarde [CHEAT-SHEET-SKILLS.md](./CHEAT-SHEET-SKILLS.md)

### **Option 3: Pragmatique** (5 min + pratique)
1. Regarde [NAVIGATION.md](./NAVIGATION.md)
2. Choisis le doc pertinent
3. Lis et applique immédiatement

---

## 🎓 Apprendre en Pratiquant

Le meilleur moyen d'apprendre: **Essayer tout de suite avec une petite feature**

```
1. Lis QUICK-START (15 min)
2. Utilise brainstorming sur une tiny feature (10 min)
3. Lis CHEAT-SHEET (5 min)
4. Essaye full workflow sur une feature medium (2-3 hours)
5. Relire GUIDE selon besoin

Total: 3-4 heures pour 80% de maîtrise
```

---

## 💪 Pas d'Excuses

"Ça prend plus long" → Non! TDD + systématique = moins de rework  
"C'est compliqué" → Non! Juste structuré. Commence par QUICK-START.  
"Je comprends, le skill est overkill" → Non! Cherche quand même.  
"Juste cette fois sans le skill" → **Non.**  

---

## 🎉 Ready?

### 👶 Nouveau? 
[Commence par QUICK-START (15 min)](./QUICK-START-SKILLS.md)

### 📚 Curieux?
[GUIDE complet (1-2 hours)](./GUIDE-UTILISATION-SKILLS.md)

### ⚡ Pressé?
[CHEAT-SHEET (5 min)](./CHEAT-SHEET-SKILLS.md)

### 💼 Pragmatique?
[NAVIGATION pour s'orienter](./NAVIGATION.md)

### 📖 Veux des exemples?
[CAS-D-USAGE (30 min)](./CAS-D-USAGE-SKILLS.md)

---

## 📍 Tu es ici

`docs/` - Documentation des Skills  

Fichiers créés:
- ✅ QUICK-START-SKILLS.md
- ✅ GUIDE-UTILISATION-SKILLS.md
- ✅ CHEAT-SHEET-SKILLS.md
- ✅ CAS-D-USAGE-SKILLS.md
- ✅ INDEX.md
- ✅ NAVIGATION.md
- ✅ RESUME.md
- ✅ README.md (ce fichier)

Accès aux skills originaux: `../skills/*/SKILL.md`

---

## 🙏 Merci!

Cette documentation a été créée pour t'aider à comprendre et utiliser efficacement les Superpowers skills de développement.

**Bonne chance! 🚀**

---

**Version**: 1.0 - Complet  
**Langue**: Français  
**Statut**: ✅ Production Ready  
**Dernière mise à jour**: Février 2026

