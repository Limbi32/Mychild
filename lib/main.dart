import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'services/activation_service.dart';
import 'services/localization_service.dart';
import 'services/storage_service.dart';
import 'services/tts_service.dart';
import 'services/speech_recognition_service.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/colors.dart';

/// Point d'entrée de l'application My Child
/// Application 100% HORS LIGNE - Aucune connexion Internet requise
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation des services hors ligne
  await _initServices();
  
  // Vérifier l'activation
  final storageService = Get.find<StorageService>();
  final isActivated = storageService.isActivated;

  runApp(MyChildApp(isActivated: isActivated));
}

/// Initialise tous les services nécessaires (hors ligne)
Future<void> _initServices() async {
  // Service de stockage local (SharedPreferences)
  await Get.putAsync(() => StorageService().init());
  
  // Service TTS (Text-to-Speech) - Voix système
  await Get.putAsync(() => TtsService().init());
  
  // Service de reconnaissance vocale - Système
  await Get.putAsync(() => SpeechRecognitionService().init());
  
  // Service d'activation (SQLite local)
  Get.put(ActivationService());
}

class MyChildApp extends StatelessWidget {
  final bool isActivated;

  const MyChildApp({super.key, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      
      // Thème personnalisé
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.primaryBlue,
        useMaterial3: true,
        
        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.accentBlue,
          foregroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
        ),
        
        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.accentBlue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        
        // Card Theme
        cardTheme: CardThemeData(
          color: AppColors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      
      // Multilingue (FR/EN)
      translations: LocalizationService(),
      locale: LocalizationService.fallbackLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      
      // Écran initial selon activation
      home: isActivated ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
