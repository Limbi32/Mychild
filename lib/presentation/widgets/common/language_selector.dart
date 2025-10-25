import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/asset_paths.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sélecteur de langue réutilisable
class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final Function(String, Locale) onLanguageChanged;
  
  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLanguageButton(
          'Français',
          AssetPaths.flagFrance,
          AppColors.primaryDarkBlue,
          selectedLanguage == 'Français',
          const Locale('fr', 'FR'),
        ),
        const SizedBox(height: 12),
        _buildLanguageButton(
          'English',
          AssetPaths.flagEnglish,
          AppColors.orange,
          selectedLanguage == 'English',
          const Locale('en', 'US'),
        ),
      ],
    );
  }

  Widget _buildLanguageButton(
    String text,
    String flagPath,
    Color color,
    bool isSelected,
    Locale locale,
  ) {
    return InkWell(
      onTap: () => onLanguageChanged(text, locale),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.white, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Drapeau
            Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  flagPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Texte
            Text(
              text,
              style: GoogleFonts.bubblegumSans(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
