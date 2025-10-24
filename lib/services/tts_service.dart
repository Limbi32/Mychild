import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../core/constants/app_constants.dart';

/// Service de Text-to-Speech (TTS) - Fonctionne 100% hors ligne
/// Utilise les voix système du téléphone
class TtsService extends GetxService {
  late FlutterTts _flutterTts;
  
  final RxBool isSpeaking = false.obs;
  final RxString currentLanguage = 'fr-FR'.obs;
  
  Future<TtsService> init() async {
    _flutterTts = FlutterTts();
    await _initializeTts();
    return this;
  }
  
  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage('fr-FR');
    await _flutterTts.setSpeechRate(AppConstants.ttsDefaultRate);
    await _flutterTts.setPitch(AppConstants.ttsDefaultPitch);
    await _flutterTts.setVolume(AppConstants.ttsDefaultVolume);
    
    _flutterTts.setStartHandler(() {
      isSpeaking.value = true;
    });
    
    _flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
    });
    
    _flutterTts.setErrorHandler((msg) {
      isSpeaking.value = false;
      Get.snackbar('Erreur TTS', msg);
    });
  }
  
  /// Parler un texte dans la langue spécifiée
  Future<void> speak(String text, {String? language}) async {
    if (text.isEmpty) return;
    
    await stop();
    
    if (language != null) {
      await setLanguage(language);
    }
    
    await _flutterTts.speak(text);
  }
  
  /// Parler en français
  Future<void> speakFrench(String text) async {
    await speak(text, language: 'fr-FR');
  }
  
  /// Parler en anglais
  Future<void> speakEnglish(String text) async {
    await speak(text, language: 'en-US');
  }
  
  /// Arrêter la lecture
  Future<void> stop() async {
    await _flutterTts.stop();
    isSpeaking.value = false;
  }
  
  /// Changer la langue
  Future<void> setLanguage(String language) async {
    currentLanguage.value = language;
    await _flutterTts.setLanguage(language);
  }
  
  /// Changer la vitesse de lecture
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }
  
  /// Changer le pitch (hauteur de voix)
  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }
  
  /// Changer le volume
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }
  
  /// Obtenir les langues disponibles
  Future<List<dynamic>> getLanguages() async {
    return await _flutterTts.getLanguages;
  }
  
  /// Obtenir les voix disponibles
  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }
  
  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
