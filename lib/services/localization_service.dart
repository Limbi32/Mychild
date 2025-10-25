import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  static const fallbackLocale = Locale('fr', 'FR');
  
  static final locales = [
    const Locale('fr', 'FR'),
    const Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'fr_FR': {
      // Welcome Screen
      'learn_speak_grow': 'Learn, Speak & Grow',
      'activate_with_key': 'Activer avec ma clé',
      'validate': 'Valider',
      'key_valid_lifetime': 'Clé valide à vie',
      'no_subscription': 'Aucun abonnement requis',
      'enter_key': 'Veuillez entrer une clé d\'activation',
      'invalid_key': 'Clé invalide ou déjà utilisée',
      'validation_error': 'Erreur lors de la validation',
      
      // Home Screen
      'home_title': 'My Child',
      'alphabet': 'Alphabet',
      'numbers': 'Chiffres',
      'colors': 'Couleurs',
      'animals': 'Animaux',
      'morality': 'Moralité',
      'signs': 'Panneaux',
      
      // Alphabet Screen
      'alphabet_title': 'Alphabet',
      'listen': 'Écouter',
      'repeat': 'Répéter',
      'next': 'Suivant',
      'previous': 'Précédent',
      
      // Common
      'french': 'Français',
      'english': 'English',
      'settings': 'Paramètres',
      'back': 'Retour',
      'close': 'Fermer',
      
      // Settings Screen
      'language': 'Langue',
      'choose_language': 'Choisir la langue',
      'language_changed': 'Langue changée avec succès',
      'activation': 'Activation',
      'activated': 'Activé',
      'your_key': 'Votre clé',
      'lifetime_access': 'Accès à vie - Aucun abonnement requis',
      'about': 'À propos',
      'version': 'Version',
      'mode': 'Mode',
      'offline_mode': 'Hors ligne',
      'modules': 'Modules',
    },
    'en_US': {
      // Welcome Screen
      'learn_speak_grow': 'Learn, Speak & Grow',
      'activate_with_key': 'Activate with my key',
      'validate': 'Validate',
      'key_valid_lifetime': 'Lifetime valid key',
      'no_subscription': 'No subscription required',
      'enter_key': 'Please enter an activation key',
      'invalid_key': 'Invalid or already used key',
      'validation_error': 'Validation error',
      
      // Home Screen
      'home_title': 'My Child',
      'alphabet': 'Alphabet',
      'numbers': 'Numbers',
      'colors': 'Colors',
      'animals': 'Animals',
      'morality': 'Morality',
      'signs': 'Signs',
      
      // Alphabet Screen
      'alphabet_title': 'Alphabet',
      'listen': 'Listen',
      'repeat': 'Repeat',
      'next': 'Next',
      'previous': 'Previous',
      
      // Common
      'french': 'Français',
      'english': 'English',
      'settings': 'Settings',
      'back': 'Back',
      'close': 'Close',
      
      // Settings Screen
      'language': 'Language',
      'choose_language': 'Choose language',
      'language_changed': 'Language changed successfully',
      'activation': 'Activation',
      'activated': 'Activated',
      'your_key': 'Your key',
      'lifetime_access': 'Lifetime access - No subscription required',
      'about': 'About',
      'version': 'Version',
      'mode': 'Mode',
      'offline_mode': 'Offline',
      'modules': 'Modules',
    },
  };
}
