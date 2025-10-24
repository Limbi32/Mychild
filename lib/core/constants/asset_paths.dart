class AssetPaths {
  // Logo
  static const String logo = 'assets/logo.jpeg';
  static const String logoJpg = 'assets/logo.jpg';
  
  // Flags
  static const String flagFrance = 'assets/france.png';
  static const String flagEnglish = 'assets/anglais.jpeg';
  
  // Menu Icons
  static const String iconHome = 'assets/accueil.jpeg';
  static const String iconMenu = 'assets/menu.jpeg';
  static const String iconRecto = 'assets/recto.jpeg';
  
  // Morality Stories
  static const String moralityBase = 'assets/moralite/';
  static String moralityImage(int index) => '${moralityBase}$index.jpg';
  
  // Sign Language
  static const String signsBase = 'assets/signs/';
  static String signImage(String letter) => '$signsBase${letter.toLowerCase()}.jpg';
  
  // Database
  static const String activationKeysDb = 'assets/activation_keys.db';
  
  // Retouch Images
  static const String retouch1 = 'assets/retouch_2025101508330906.jpg';
  static const String retouch2 = 'assets/retouch_2025101508335673.jpg';
  static const String retouch3 = 'assets/retouch_2025101508351271.jpg';
  static const String retouch4 = 'assets/retouch_2025101508360788.jpg';
}
