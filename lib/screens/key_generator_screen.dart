import 'package:flutter/material.dart';
import '../services/activation_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class KeyGeneratorScreen extends StatefulWidget {
  const KeyGeneratorScreen({super.key});

  @override
  State<KeyGeneratorScreen> createState() => _KeyGeneratorScreenState();
}

class _KeyGeneratorScreenState extends State<KeyGeneratorScreen> {
  final ActivationService _service = ActivationService();
  int _remainingKeys = 0;
  bool _isLoading = false;
  bool _isGenerating = false;
  String? _usedKey;
  List<String> _generatedKeys = [];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    if (kIsWeb) {
      setState(() {
        _remainingKeys = 0;
      });
      return;
    }

    setState(() => _isLoading = true);
    try {
      final remaining = await _service.getRemainingKeysCount();
      final usedKey = await _service.getUsedKey();
      setState(() {
        _remainingKeys = remaining;
        _usedKey = usedKey;
      });
    } catch (e) {
      print('Erreur: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _generateKeys(int count) async {
    if (kIsWeb) {
      _showMessage('SQLite non supporté sur le web', isError: true);
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedKeys.clear();
    });

    try {
      // Génère les clés
      await _service.generateKeys(count);
      
      // Récupère quelques clés pour affichage
      final db = await _service.database;
      final result = await db.query(
        'activation_keys',
        orderBy: 'id DESC',
        limit: 10,
      );
      
      setState(() {
        _generatedKeys = result
            .map((row) => row['key_value'] as String)
            .toList();
      });

      await _loadStats();
      
      if (mounted) {
        _showMessage('✅ $count clés générées avec succès !');
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Erreur: $e', isError: true);
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  Future<void> _showAllKeys() async {
    if (kIsWeb) {
      _showMessage('SQLite non supporté sur le web', isError: true);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final db = await _service.database;
      final result = await db.query(
        'activation_keys',
        orderBy: 'id ASC',
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Toutes les clés (${result.length})'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                final key = result[index]['key_value'] as String;
                return ListTile(
                  leading: Text('${index + 1}.'),
                  title: SelectableText(key),
                  dense: true,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        ),
      );
    } catch (e) {
      _showMessage('Erreur: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetActivation() async {
    await _service.resetActivation();
    _showMessage('Activation réinitialisée');
    await _loadStats();
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Générateur de clés'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              '⚠️ SQLite n\'est pas supporté sur le web.\n\n'
              'Veuillez lancer l\'application sur:\n'
              '• Windows (flutter run -d windows)\n'
              '• Android (flutter run -d android)\n'
              '• iOS (flutter run -d ios)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Générateur de clés'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Statistiques
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            '📊 Statistiques',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Clés restantes: $_remainingKeys',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                          if (_usedKey != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              'Clé utilisée: $_usedKey',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Boutons de génération
                  const Text(
                    '🔑 Générer des clés',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  _buildGenerateButton('10 clés', 10),
                  const SizedBox(height: 10),
                  _buildGenerateButton('100 clés', 100),
                  const SizedBox(height: 10),
                  _buildGenerateButton('1 000 clés', 1000),
                  const SizedBox(height: 10),
                  _buildGenerateButton('10 000 clés', 10000, Colors.orange),
                  const SizedBox(height: 10),
                  _buildGenerateButton('200 000 clés', 200000, Colors.red),

                  const SizedBox(height: 30),

                  // Actions
                  ElevatedButton.icon(
                    onPressed: _isGenerating ? null : _showAllKeys,
                    icon: const Icon(Icons.list),
                    label: const Text('Voir toutes les clés'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(15),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: _isGenerating ? null : _resetActivation,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Réinitialiser l\'activation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.all(15),
                    ),
                  ),

                  // Clés générées récemment
                  if (_generatedKeys.isNotEmpty) ...[
                    const SizedBox(height: 30),
                    const Text(
                      '📋 Dernières clés générées',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _generatedKeys
                              .map((key) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: SelectableText(
                                      key,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],

                  if (_isGenerating) ...[
                    const SizedBox(height: 30),
                    const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 15),
                          Text(
                            'Génération en cours...',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildGenerateButton(String label, int count, [Color? color]) {
    return ElevatedButton(
      onPressed: _isGenerating ? null : () => _generateKeys(count),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue,
        padding: const EdgeInsets.all(15),
      ),
      child: Text(
        'Générer $label',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
