import 'package:flutter/material.dart';
import 'sign_detail_screen.dart'; // <-- importe la nouvelle page

class SignLanguageScreen extends StatelessWidget {
  const SignLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> letters = List.generate(
      26,
      (i) => String.fromCharCode(65 + i),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0B57CF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔹 Titre
            const Text(
              "Alphabet des signes",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Conteneur central avec la grille
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GridView.builder(
                  itemCount: letters.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final letter = letters[index];
                    final imagePath =
                        'assets/signs/${letter.toLowerCase()}.jpg';

                    return GestureDetector(
                      onTap: () {
                        // 👇 Navigation vers les détails du signe
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignDetailScreen(
                              letter: letter,
                              imagePath: imagePath,
                              description:
                                  "Le signe de la lettre $letter en langue des signes. "
                                  "Ce geste se forme avec la main d’une manière spécifique pour représenter la lettre $letter.",
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            letter,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Bienvenue dans\nl’univers éducatif universel",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
