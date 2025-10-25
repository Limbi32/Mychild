import 'package:flutter/material.dart';
import '../services/activation_service.dart';
import '../utils/key_generator.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ActivationService _service = ActivationService();
  int _remainingKeys = 0;
  bool _isLoading = false;
  String? _usedKey;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
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
    setState(() => _isLoading = true);
    try {
      await KeyGenerator.generateAndInsertKeys(count);
      await _loadStats();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$count clés générées avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Statistiques',
                            style: GoogleFonts.bubblegumSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Clés restantes: $_remainingKeys',
                            style: GoogleFonts.bubblegumSans(fontSize: 18),
                          ),
                          if (_usedKey != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              'Clé utilisée: $_usedKey',
                              style: GoogleFonts.bubblegumSans(
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
                  Text(
                    'Générer des clés',
                    style: GoogleFonts.bubblegumSans(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _generateKeys(100),
                    child: const Text('Générer 100 clés'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _generateKeys(1000),
                    child: const Text('Générer 1 000 clés'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _generateKeys(10000),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Générer 10 000 clés'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _generateKeys(200000),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Générer 200 000 clés'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _loadStats,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Actualiser'),
                  ),
                ],
              ),
            ),
    );
  }
}
