import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alphabet_screen.dart';
import 'pronunciation_screen.dart';
import 'sign_language_screen.dart';
import 'morality_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5DADE2), // Même dégradé que welcome screen
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              "home_title".tr,
              style: GoogleFonts.bubblegumSans(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: const [Shadow(color: Colors.black26, blurRadius: 3)],
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Liste des boutons de menu
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      _menuButton(
                        context,
                        icon: "✍️",
                        label: "alphabet".tr,
                        color: Colors.white,
                        onTap: () => Get.to(() => const AlphabetScreen()),
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "🔊",
                        label: "numbers".tr,
                        color: Colors.white,
                        onTap: () => Get.to(() => const PronunciationScreen()),
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "🤟",
                        label: "signs".tr,
                        color: Colors.white,
                        onTap: () => Get.to(() => const SignLanguageScreen()),
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "📖",
                        label: "morality".tr,
                        color: Colors.white,
                        onTap: () => Get.to(() => const MoralityLoadingScreen()),
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "⚙️",
                        label: "settings".tr,
                        color: Colors.white,
                        onTap: () => Get.to(() => const SettingsScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Bienvenue dans l'univers éducatif universel 🌍",
                textAlign: TextAlign.center,
                style: GoogleFonts.bubblegumSans(color: Colors.white70, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour chaque bouton de menu
  Widget _menuButton(
    BuildContext context, {
    required String icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Text(icon, style: GoogleFonts.bubblegumSans(fontSize: 28)),
            const SizedBox(width: 20),
            Text(
              label,
              style: GoogleFonts.bubblegumSans(
                color: const Color(0xFF007BFF),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
