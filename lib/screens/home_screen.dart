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
      backgroundColor: const Color(0xFF007BFF), // Bleu fond principal
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // ✅ espace bien réparti
          children: [
            const SizedBox(height: 20),

            const Text(
              "Menu principal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
              ),
            ),

            // ✅ Boutons ajustés sans scroll
            Padding(
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
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
                  _menuButton(
                    context,
                    icon: "📖",
                    label: "Contes & moralité",
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoralityScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
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

            const Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
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

  // ✅ Bouton réutilisable
  Widget _menuButton(
    BuildContext context, {
    required String icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 60, // ✅ hauteur réduite pour tout afficher
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF007BFF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
