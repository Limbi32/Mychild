class AppConstants {
  // App Info
  static const String appName = 'My Child';
  static const String appTagline = 'Learn, Speak & Grow';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String dbName = 'mychild.db';
  static const int dbVersion = 1;
  
  // SharedPreferences Keys
  static const String keyIsActivated = 'is_activated';
  static const String keyActivationKey = 'activation_key';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyFirstLaunch = 'first_launch';
  
  // Languages
  static const String langFrench = 'fr';
  static const String langEnglish = 'en';
  
  // TTS Settings
  static const double ttsDefaultRate = 0.5;
  static const double ttsDefaultPitch = 1.0;
  static const double ttsDefaultVolume = 1.0;
  
  // Alphabet
  static const int alphabetLetterCount = 26;
  
  // Grid Settings
  static const int alphabetGridColumns = 5;
  static const int signsGridColumns = 3;
  
  // Animation Durations
  static const int splashDuration = 3000; // milliseconds
  static const int navigationDuration = 300;
  
  // Offline Mode
  static const bool isOfflineOnly = true;
  static const String offlineMessage = 'Cette application fonctionne 100% hors ligne';
}
