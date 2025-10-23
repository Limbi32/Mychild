import 'package:flutter/material.dart';
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
            const Text(
              "Menu principal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
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
                        label: "Alphabet",
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AlphabetScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "🔊",
                        label: "Prononciation",
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PronunciationScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "🤟",
                        label: "Langage des signes",
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignLanguageScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "📖",
                        label: "Contes & moralité",
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoralityLoadingScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      _menuButton(
                        context,
                        icon: "⚙️",
                        label: "Paramètres",
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Bienvenue dans l’univers éducatif universel 🌍",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
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
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF007BFF),
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
