import 'dart:math';
import '../services/activation_service.dart';

class KeyGenerator {
  static final Random _random = Random();

  // Génère une clé unique avec format: MYCHILD-XXXXXX-YYYYYY
  static String generateKey() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random1 = _random.nextInt(999999).toString().padLeft(6, '0');
    final random2 = _random.nextInt(999999).toString().padLeft(6, '0');
    return 'MYCHILD-$random1-$random2';
  }

  // Génère et insère un nombre spécifique de clés
  static Future<void> generateAndInsertKeys(int count) async {
    final service = ActivationService();
    print('Génération de $count clés...');
    
    final startTime = DateTime.now();
    await service.generateKeys(count);
    final endTime = DateTime.now();
    
    final duration = endTime.difference(startTime);
    print('✅ $count clés générées en ${duration.inSeconds} secondes');
    
    final remaining = await service.getRemainingKeysCount();
    print('📊 Total de clés dans la base: $remaining');
  }
}
