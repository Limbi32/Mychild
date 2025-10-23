# 🔐 Système d'Activation My Child - 100% Hors Ligne

## 🎯 Concept

Application éducative universelle avec **activation unique à 1000 FCFA**, fonctionnant **entièrement sans Internet**.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    DÉVELOPPEUR (VOUS)                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Générer 200 000 clés dans SQLite                        │
│     ↓                                                        │
│  2. Exporter activation_keys.db                             │
│     ↓                                                        │
│  3. Inclure dans assets/activation_keys.db                  │
│     ↓                                                        │
│  4. Compiler APK (contient les 200k clés)                   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                            ↓
                    [Distribution]
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    UTILISATEUR FINAL                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Télécharge l'APK (5-10 MB)                              │
│     • Contient déjà les 200 000 clés                        │
│     • Aucune connexion requise                              │
│                                                              │
│  2. Achète une clé (1000 FCFA)                              │
│     • Vous lui donnez: MYCHILD-123456-789012                │
│                                                              │
│  3. Entre la clé dans l'app (HORS LIGNE)                    │
│     • Vérification dans SQLite local                        │
│     • Si valide → Clé supprimée (usage unique)              │
│     • Utilisateur marqué "activé à vie"                     │
│                                                              │
│  4. ✅ Utilise l'app à vie sans Internet                    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔑 Fonctionnement des Clés

### Format de clé
```
MYCHILD-123456-789012
```

### Cycle de vie d'une clé

```
[Générée] → [Stockée dans SQLite] → [Vendue] → [Utilisée] → [Supprimée]
                                                                  ↓
                                                          [Ne peut plus être réutilisée]
```

### Sécurité

1. **Usage unique** : Une fois utilisée, la clé est supprimée de la base
2. **Vérification locale** : Pas de serveur = pas de piratage réseau
3. **200 000 clés uniques** : Chaque clé est différente
4. **Activation permanente** : Stockée dans SharedPreferences

---

## 📱 Flux Utilisateur

### Première utilisation

```
[Ouvre l'app]
     ↓
[Écran d'activation]
     ↓
[Entre la clé achetée]
     ↓
[Clique sur "Valider"]
     ↓
[Vérification SQLite locale] ← HORS LIGNE
     ↓
[Clé valide ?]
     ├─ OUI → [Supprime la clé] → [Active à vie] → [Accès complet]
     └─ NON → [Message d'erreur] → [Réessayer]
```

### Utilisations suivantes

```
[Ouvre l'app]
     ↓
[Vérifie SharedPreferences]
     ↓
[Déjà activé ?]
     └─ OUI → [Accès direct] ← Pas de vérification réseau
```

---

## 💾 Base de Données SQLite

### Structure

```sql
CREATE TABLE activation_keys (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key_value TEXT UNIQUE NOT NULL,
    created_at INTEGER NOT NULL
);

CREATE INDEX idx_key_value ON activation_keys(key_value);
```

### Taille

- **200 000 clés** ≈ 5-6 MB
- **1 000 000 clés** ≈ 25-30 MB

### Emplacement

**Pendant le développement :**
- Windows: `C:\Users\[User]\AppData\Local\mychild\activation_keys.db`
- Android: `/data/data/com.example.mychild/databases/activation_keys.db`

**Dans l'APK final :**
- `assets/activation_keys.db` (inclus dans l'APK)
- Copié vers le dossier local au premier lancement

---

## 🛠️ Guide de Mise en Place

### Étape 1 : Générer les clés

```bash
# Lancer sur Windows
flutter run -d windows

# Dans l'app :
# 1. Cliquer sur ⚙️ (bouton settings)
# 2. Cliquer sur "Générer 200 000 clés"
# 3. Attendre 5-10 minutes
```

### Étape 2 : Exporter la base

```bash
# Option A : Bouton dans l'app
# Cliquer sur "Exporter la base de données"

# Option B : Manuellement
# Windows :
copy %LOCALAPPDATA%\mychild\activation_keys.db assets\

# Android :
adb pull /data/data/com.example.mychild/databases/activation_keys.db assets/
```

### Étape 3 : Vérifier pubspec.yaml

```yaml
flutter:
  assets:
    - assets/activation_keys.db  # ← Doit être présent
```

### Étape 4 : Compiler

```bash
# Android
flutter build apk --release

# Windows
flutter build windows --release

# iOS
flutter build ios --release
```

---

## 🧪 Tests

### Test 1 : Générer des clés

```bash
flutter run -d windows
# ⚙️ → Générer 10 clés
# Vérifier : "10 clés générées"
```

### Test 2 : Voir les clés

```bash
# ⚙️ → Voir toutes les clés
# Copier une clé affichée
```

### Test 3 : Activer avec une clé

```bash
# Retour à l'écran d'accueil
# Coller la clé → Valider
# ✅ Devrait activer l'app
```

### Test 4 : Vérifier l'usage unique

```bash
# ⚙️ → Réinitialiser l'activation
# Essayer la même clé
# ❌ Devrait être refusée (déjà utilisée)
```

### Test 5 : Persistance

```bash
# Fermer et rouvrir l'app
# ✅ Devrait rester activé
```

---

## 💰 Modèle Commercial

### Prix
- **1 clé = 1000 FCFA** (≈ 1.50 EUR)
- **Activation à vie**
- **Aucun abonnement**

### Vente des clés

**Option 1 : Manuel**
1. Ouvrir `activation_keys.db` avec un outil SQLite
2. Consulter les clés disponibles
3. Noter la clé vendue
4. Donner la clé au client

**Option 2 : Export**
1. Utiliser le bouton "Exporter les clés"
2. Obtenir un fichier texte avec toutes les clés
3. Vendre ligne par ligne

**Option 3 : Automatisé**
1. Créer un système de vente en ligne
2. Base de données séparée pour tracking
3. API pour marquer les clés comme vendues

---

## 🔒 Sécurité

### Protections

1. **Usage unique** : Clé supprimée après utilisation
2. **Pas de serveur** : Pas de point d'attaque réseau
3. **Vérification locale** : Fonctionne hors ligne
4. **Obfuscation** : Utiliser ProGuard/R8 pour Android

### Recommandations

1. ✅ Ne jamais partager `activation_keys.db` publiquement
2. ✅ Garder une copie de sauvegarde
3. ✅ Noter les clés vendues
4. ✅ Utiliser l'obfuscation du code
5. ✅ Vérifier la signature de l'app

### Limitations acceptables

- Si l'utilisateur désinstalle l'app → Perd l'activation
- Si l'utilisateur root son téléphone → Peut accéder à la base
- **Solution** : Prix accessible (1000 FCFA) rend le piratage peu intéressant

---

## 📊 Statistiques

### Capacité

- **200 000 clés** = 200 000 activations possibles
- **Taille APK** : +5-6 MB
- **Génération** : ~5-10 minutes
- **Vérification** : <100ms (locale)

### Performance

- ✅ Activation instantanée (hors ligne)
- ✅ Pas de latence réseau
- ✅ Fonctionne partout (même sans réseau)
- ✅ Pas de coûts serveur

---

## ❓ FAQ

**Q : Que se passe-t-il si l'utilisateur désinstalle l'app ?**
R : Il perd l'activation et doit racheter une clé. C'est normal.

**Q : Peut-on réutiliser une clé ?**
R : Non, une fois utilisée, elle est supprimée de la base.

**Q : Comment éviter le piratage ?**
R : Le prix bas (1000 FCFA) rend le piratage peu intéressant. Utilisez aussi l'obfuscation.

**Q : Combien de clés générer ?**
R : Commencez avec 10 000, puis générez plus selon les ventes.

**Q : L'app fonctionne vraiment sans Internet ?**
R : Oui, 100% ! Tout est local (SQLite + SharedPreferences).

---

## 🎉 Avantages de cette Solution

✅ **Pas de serveur** → Pas de coûts d'hébergement
✅ **Hors ligne** → Fonctionne partout
✅ **Simple** → Facile à comprendre et maintenir
✅ **Sécurisé** → Usage unique des clés
✅ **Scalable** → Générez autant de clés que nécessaire
✅ **Accessible** → Prix bas (1000 FCFA)

---

## 🚀 Prochaines Étapes

1. [ ] Générer 200 000 clés
2. [ ] Tester l'activation
3. [ ] Exporter la base de données
4. [ ] Inclure dans assets/
5. [ ] Compiler l'APK final
6. [ ] Tester sur un appareil propre
7. [ ] Distribuer ! 🎉
