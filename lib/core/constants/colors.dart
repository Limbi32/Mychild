import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF5DADE2);
  static const Color primaryDarkBlue = Color(0xFF3498DB);
  static const Color accentBlue = Color(0xFF1E3A8A);
  static const Color electricBlue = Color(0xFF0B57CF);
  
  // Secondary Colors
  static const Color orange = Color(0xFFE67E22);
  static const Color orangeLight = Color(0xFFFFB84D);
  static const Color orangeDark = Color(0xFFF39C12);
  
  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryDarkBlue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [orangeLight, orangeDark],
  );
  
  // Shadows
  static BoxShadow defaultShadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    blurRadius: 10,
    offset: const Offset(0, 5),
  );
  
  static BoxShadow lightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 5,
    offset: const Offset(0, 2),
  );
}
