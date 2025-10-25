import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/colors.dart';
import '../core/constants/asset_paths.dart';
import '../services/storage_service.dart';
import '../services/activation_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storageService = Get.find<StorageService>();
  final activationService = ActivationService();
  
  String _currentLanguage = 'Français';
  String? _usedKey;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final locale = Get.locale;
    setState(() {
      _currentLanguage = locale?.languageCode == 'en' ? 'English' : 'Français';
    });
    
    _usedKey = await activationService.getUsedKey();
    setState(() {
      _isLoading = false;
    });
  }

  void _changeLanguage(String language, Locale locale) {
    setState(() {
      _currentLanguage = language;
    });
    Get.updateLocale(locale);
    storageService.setLanguage(locale.languageCode);
    
    Get.snackbar(
      'language'.tr,
      'language_changed'.tr,
      backgroundColor: AppColors.success.withOpacity(0.9),
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: GoogleFonts.bubblegumSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.accentBlue,
        foregroundColor: AppColors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.white))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Langue
                    _buildSectionTitle('🌍 ${'language'.tr}'),
                    const SizedBox(height: 15),
                    _buildLanguageCard(),
                    
                    const SizedBox(height: 30),
                    
                    // Section Activation
                    _buildSectionTitle('🔑 ${'activation'.tr}'),
                    const SizedBox(height: 15),
                    _buildActivationCard(),
                    
                    const SizedBox(height: 30),
                    
                    // Section À propos
                    _buildSectionTitle('ℹ️ ${'about'.tr}'),
                    const SizedBox(height: 15),
                    _buildAboutCard(),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.bubblegumSans(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLanguageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'choose_language'.tr,
            style: GoogleFonts.bubblegumSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.accentBlue,
            ),
          ),
          const SizedBox(height: 15),
          
          // Bouton Français
          _buildLanguageButton(
            'Français',
            AssetPaths.flagFrance,
            AppColors.primaryDarkBlue,
            _currentLanguage == 'Français',
            const Locale('fr', 'FR'),
          ),
          
          const SizedBox(height: 12),
          
          // Bouton English
          _buildLanguageButton(
            'English',
            AssetPaths.flagEnglish,
            AppColors.orange,
            _currentLanguage == 'English',
            const Locale('en', 'US'),
          ),
        ],
      ),
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
      onTap: () => _changeLanguage(text, locale),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.accentBlue, width: 3)
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              const Icon(Icons.check_circle, color: AppColors.white, size: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActivationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 28),
              const SizedBox(width: 10),
              Text(
                'activated'.tr,
                style: GoogleFonts.bubblegumSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (_usedKey != null) ...[
            Text(
              'your_key'.tr,
              style: GoogleFonts.bubblegumSans(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.greyLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _usedKey!,
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentBlue,
                ),
              ),
            ),
          ],
          const SizedBox(height: 15),
          Text(
            'lifetime_access'.tr,
            style: GoogleFonts.bubblegumSans(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [AppColors.lightShadow],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AssetPaths.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Nom de l'app
          Center(
            child: Text(
              'My Child',
              style: GoogleFonts.bubblegumSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accentBlue,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              'Learn, Speak & Grow',
              style: GoogleFonts.bubblegumSans(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Version
          _buildInfoRow('📱 ${'version'.tr}', '1.0.0'),
          const SizedBox(height: 10),
          _buildInfoRow('🌐 ${'mode'.tr}', 'offline_mode'.tr),
          const SizedBox(height: 10),
          _buildInfoRow('🎓 ${'modules'.tr}', '5'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.bubblegumSans(
            fontSize: 14,
            color: AppColors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.bubblegumSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.accentBlue,
          ),
        ),
      ],
    );
  }
}
