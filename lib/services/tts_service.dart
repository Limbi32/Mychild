import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../core/constants/app_constants.dart';

/// Service de Text-to-Speech (TTS)
/// Désactivé automatiquement sur les plateformes non supportées
class TtsService extends GetxService {
  FlutterTts? _flutterTts; // nullable si feature désactivée
  
  final RxBool isSpeaking = false.obs;
  final RxString currentLanguage = 'fr-FR'.obs;
  
  bool get isSupported {
    // TTS supporté UNIQUEMENT Android + iOS
    if (kIsWeb) return true; // FlutterTTS fonctionne via WebSpeech API
    return Platform.isAndroid || Platform.isIOS;
  }

  Future<TtsService> init() async {
    if (!isSupported) {
      print("🔇 TTS désactivé : plateforme non supportée.");
      return this;
    }

    _flutterTts = FlutterTts();
    await _initializeTts();
    return this;
  }
  
  Future<void> _initializeTts() async {
    if (_flutterTts == null) return;

    await _flutterTts!.setLanguage('fr-FR');
    await _flutterTts!.setSpeechRate(AppConstants.ttsDefaultRate);
    await _flutterTts!.setPitch(AppConstants.ttsDefaultPitch);
    await _flutterTts!.setVolume(AppConstants.ttsDefaultVolume);
    
    _flutterTts!.setStartHandler(() {
      isSpeaking.value = true;
    });
    
    _flutterTts!.setCompletionHandler(() {
      isSpeaking.value = false;
    });
    
    _flutterTts!.setErrorHandler((msg) {
      isSpeaking.value = false;
      Get.snackbar('Erreur TTS', msg);
    });
  }
  
  /// --- MÉTHODES TTS (protégées si non supporté) ---
  
  Future<void> speak(String text, {String? language}) async {
    if (!isSupported || _flutterTts == null) {
      print("🔇 TTS ignoré (plateforme non supportée)");
      return;
    }

    if (text.isEmpty) return;
    
    await stop();
    
    if (language != null) {
      await setLanguage(language);
    }
    
    await _flutterTts!.speak(text);
  }
  
  Future<void> speakFrench(String text) async {
    await speak(text, language: 'fr-FR');
  }
  
  Future<void> speakEnglish(String text) async {
    await speak(text, language: 'en-US');
  }
  
  Future<void> stop() async {
    if (!isSupported || _flutterTts == null) return;
    await _flutterTts!.stop();
    isSpeaking.value = false;
  }
  
  Future<void> setLanguage(String language) async {
    if (!isSupported || _flutterTts == null) return;
    currentLanguage.value = language;
    await _flutterTts!.setLanguage(language);
  }
  
  Future<void> setSpeechRate(double rate) async {
    if (!isSupported || _flutterTts == null) return;
    await _flutterTts!.setSpeechRate(rate);
  }
  
  Future<void> setPitch(double pitch) async {
    if (!isSupported || _flutterTts == null) return;
    await _flutterTts!.setPitch(pitch);
  }
  
  Future<void> setVolume(double volume) async {
    if (!isSupported || _flutterTts == null) return;
    await _flutterTts!.setVolume(volume);
  }
  
  Future<List<dynamic>> getLanguages() async {
    if (!isSupported || _flutterTts == null) return [];
    return await _flutterTts!.getLanguages;
  }
  
  Future<List<dynamic>> getVoices() async {
    if (!isSupported || _flutterTts == null) return [];
    return await _flutterTts!.getVoices;
  }
  
  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
