import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;

class ActivationService {
  static const String _activatedKey = 'is_activated';
  static const String _usedKeyValue = 'used_key';
  static Database? _database;

  // Vérifie si l'utilisateur est déjà activé localement
  Future<bool> isActivated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_activatedKey) ?? false;
  }

  // Récupère la clé utilisée par cet utilisateur
  Future<String?> getUsedKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usedKeyValue);
  }

  // Initialise la base de données
  Future<Database> get database async {
    if (kIsWeb) {
      throw Exception('SQLite n\'est pas supporté sur le web');
    }

    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activation_keys.db');

    // Vérifie si la base existe déjà
    final exists = await databaseExists(path);

    if (!exists) {
      // Copie la base pré-remplie depuis les assets (si elle existe)
      try {
        // Crée le dossier si nécessaire
        await Directory(dirname(path)).create(recursive: true);

        // Essaie de copier depuis les assets
        final data = await rootBundle.load('assets/activation_keys.db');
        final bytes = data.buffer.asUint8List();
        await File(path).writeAsBytes(bytes, flush: true);
        
        print('✅ Base de données copiée depuis les assets');
      } catch (e) {
        print('⚠️ Pas de base pré-remplie trouvée, création d\'une nouvelle base');
      }
    }

    // Ouvre ou crée la base de données
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE activation_keys (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key_value TEXT UNIQUE NOT NULL,
            created_at INTEGER NOT NULL
          )
        ''');

        // Index pour recherche rapide
        await db.execute('''
          CREATE INDEX idx_key_value ON activation_keys(key_value)
        ''');

        print('✅ Base de données créée');
      },
    );
  }

  // Valide une clé et la supprime si elle existe (ACTIVATION HORS LIGNE)
  Future<bool> validateAndConsumeKey(String key) async {
    print('\n🔍 Tentative de validation de la clé: $key');

    if (kIsWeb) {
      // Sur le web, validation simple pour tests
      return _validateWebKey(key);
    }

    try {
      final db = await database;

      // Vérifie si la clé existe dans la base locale
      final result = await db.query(
        'activation_keys',
        where: 'key_value = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (result.isEmpty) {
        print('❌ Clé invalide ou déjà utilisée');
        return false;
      }

      print('✅ Clé valide trouvée dans la base de données locale');

      // Supprime la clé de la base (elle ne peut plus être réutilisée)
      await db.delete(
        'activation_keys',
        where: 'key_value = ?',
        whereArgs: [key],
      );

      print('🗑️ Clé supprimée de la base (usage unique)');

      // Marque l'utilisateur comme activé à vie
      await _markAsActivated(key);

      print('✅ Utilisateur activé avec succès à vie\n');

      return true;
    } catch (e) {
      print('❌ Erreur lors de la validation: $e\n');
      return false;
    }
  }

  // Validation simple pour le web (tests uniquement)
  Future<bool> _validateWebKey(String key) async {
    if (key == "MYCHILD2025" || key.startsWith("TEST-")) {
      await _markAsActivated(key);
      return true;
    }
    return false;
  }

  // Marque l'utilisateur comme activé à vie
  Future<void> _markAsActivated(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_activatedKey, true);
    await prefs.setString(_usedKeyValue, key);
  }

  // Réinitialise l'activation (pour tests uniquement)
  Future<void> resetActivation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activatedKey);
    await prefs.remove(_usedKeyValue);
    print('🔄 Activation réinitialisée');
  }

  // Compte le nombre de clés restantes
  Future<int> getRemainingKeysCount() async {
    if (kIsWeb) return 0;

    try {
      final db = await database;
      final result =
          await db.rawQuery('SELECT COUNT(*) as count FROM activation_keys');
      final count = Sqflite.firstIntValue(result) ?? 0;
      print('📊 Nombre de clés restantes: $count');
      return count;
    } catch (e) {
      print('❌ Erreur lors du comptage: $e');
      return 0;
    }
  }

  // Affiche toutes les clés (pour debug/vente)
  Future<List<String>> getAllKeys() async {
    if (kIsWeb) return [];

    try {
      final db = await database;
      final result = await db.query('activation_keys', orderBy: 'id ASC');
      return result.map((row) => row['key_value'] as String).toList();
    } catch (e) {
      print('❌ Erreur: $e');
      return [];
    }
  }

  // Génère et insère des clés (POUR VOUS, le développeur)
  Future<void> generateKeys(int count) async {
    if (kIsWeb) {
      throw Exception('Génération non supportée sur le web');
    }

    final db = await database;
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    print('\n========================================');
    print('🔑 GÉNÉRATION DE $count CLÉS D\'ACTIVATION');
    print('========================================\n');

    int generated = 0;

    for (int i = 0; i < count; i += 1000) {
      final batch = db.batch();
      final endIndex = (i + 1000 > count) ? count : i + 1000;

      for (int j = i; j < endIndex; j++) {
        final key = _generateUniqueKey(j, timestamp);
        batch.insert('activation_keys', {
          'key_value': key,
          'created_at': timestamp,
        });
        generated++;
      }

      await batch.commit(noResult: true);
      print('✅ $generated/$count clés générées...');
    }

    print('\n========================================');
    print('✅ GÉNÉRATION TERMINÉE: $count clés créées');
    print('========================================\n');
  }

  // Génère une clé unique au format MYCHILD-XXXXXX-YYYYYY
  String _generateUniqueKey(int index, int timestamp) {
    // Utilise l'index et le timestamp pour garantir l'unicité
    final part1 = ((timestamp + index) % 999999).toString().padLeft(6, '0');
    final part2 = ((timestamp * 7 + index * 13) % 999999)
        .toString()
        .padLeft(6, '0');
    return 'MYCHILD-$part1-$part2';
  }

  // Exporte les clés dans un fichier texte (pour vente)
  Future<String> exportKeysToFile() async {
    if (kIsWeb) throw Exception('Export non supporté sur le web');

    try {
      final keys = await getAllKeys();
      final dbPath = await getDatabasesPath();
      final exportPath = join(dbPath, 'exported_keys.txt');

      final file = File(exportPath);
      await file.writeAsString(keys.join('\n'));

      print('✅ ${keys.length} clés exportées vers: $exportPath');
      return exportPath;
    } catch (e) {
      print('❌ Erreur lors de l\'export: $e');
      rethrow;
    }
  }

  // Copie la base de données vers un emplacement accessible
  Future<String> exportDatabase() async {
    if (kIsWeb) throw Exception('Export non supporté sur le web');

    try {
      final dbPath = await getDatabasesPath();
      final sourcePath = join(dbPath, 'activation_keys.db');
      final exportPath = join(dbPath, 'activation_keys_export.db');

      final sourceFile = File(sourcePath);
      await sourceFile.copy(exportPath);

      print('✅ Base de données exportée vers: $exportPath');
      return exportPath;
    } catch (e) {
      print('❌ Erreur lors de l\'export: $e');
      rethrow;
    }
  }
}
