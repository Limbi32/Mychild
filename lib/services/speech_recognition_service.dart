import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Service de reconnaissance vocale - Fonctionne hors ligne si voix téléchargées
class SpeechRecognitionService extends GetxService {
  late stt.SpeechToText _speech;
  
  final RxBool isListening = false.obs;
  final RxBool isAvailable = false.obs;
  final RxString recognizedText = ''.obs;
  final RxString currentLocale = 'fr_FR'.obs;
  
  bool _isInitializing = false;
  
  Future<SpeechRecognitionService> init() async {
    _speech = stt.SpeechToText();
    await _checkAvailability();
    return this;
  }
  
  Future<void> _checkAvailability() async {
    isAvailable.value = await _speech.initialize(
      onStatus: _onStatus,
      onError: _onError,
    );
  }
  
  void _onStatus(String status) {
    if (status == 'notListening') {
      isListening.value = false;
    } else if (status == 'listening') {
      isListening.value = true;
    }
  }
  
  void _onError(dynamic error) {
    isListening.value = false;
    Get.snackbar('Erreur', 'Erreur de reconnaissance vocale: $error');
  }
  
  /// Démarrer l'écoute
  Future<void> startListening({
    String? localeId,
    Function(String)? onResult,
  }) async {
    if (isListening.value || _isInitializing) return;
    
    if (!isAvailable.value) {
      _isInitializing = true;
      isAvailable.value = await _speech.initialize(
        onStatus: _onStatus,
        onError: _onError,
      );
      _isInitializing = false;
    }
    
    if (!isAvailable.value) {
      Get.snackbar('Erreur', 'Microphone non disponible');
      return;
    }
    
    recognizedText.value = '';
    
    await _speech.listen(
      localeId: localeId ?? currentLocale.value,
      onResult: (result) {
        recognizedText.value = result.recognizedWords;
        if (onResult != null) {
          onResult(result.recognizedWords);
        }
      },
    );
  }
  
  /// Écouter en français
  Future<void> listenFrench({Function(String)? onResult}) async {
    await startListening(localeId: 'fr_FR', onResult: onResult);
  }
  
  /// Écouter en anglais
  Future<void> listenEnglish({Function(String)? onResult}) async {
    await startListening(localeId: 'en_US', onResult: onResult);
  }
  
  /// Arrêter l'écoute
  Future<void> stopListening() async {
    await _speech.stop();
    isListening.value = false;
  }
  
  /// Annuler l'écoute
  Future<void> cancelListening() async {
    await _speech.cancel();
    isListening.value = false;
    recognizedText.value = '';
  }
  
  /// Obtenir les locales disponibles
  Future<List<stt.LocaleName>> getLocales() async {
    if (!isAvailable.value) return [];
    return await _speech.locales();
  }
  
  @override
  void onClose() {
    stopListening();
    super.onClose();
  }
}
