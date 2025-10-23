import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Exemple : chaque lettre avec son son local (prévu en assets)
  final List<Map<String, String>> letters = List.generate(26, (i) {
    String letter = String.fromCharCode(65 + i);
    return {
      "letter": letter,
      "lower": letter.toLowerCase(),
      "soundFr": "assets/sounds/fr/$letter.mp3",
      "soundEn": "assets/sounds/en/$letter.mp3",
    };
  });

  String currentLang = "fr"; // "fr" ou "en"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC), // Bleu clair
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        title: const Text(
          "Alphabet",
          style: TextStyle(fontFamily: 'ComicNeue'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: () {
              setState(() {
                currentLang = currentLang == "fr" ? "en" : "fr";
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            currentLang == "fr"
                ? "Apprends les lettres !"
                : "Learn the alphabet!",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontFamily: 'ComicNeue',
            ),
          ),
          const SizedBox(height: 10),

          // ✅ Grille des lettres A-Z
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: letters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 colonnes
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = letters[index];
                return _buildLetterCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterCard(Map<String, String> item) {
    return InkWell(
      onTap: () async {
        String sound = currentLang == "fr"
            ? item["soundFr"]!
            : item["soundEn"]!;
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource(sound));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item["letter"]!,
                style: const TextStyle(
                  fontSize: 38,
                  color: Color(0xFF007BFF),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ComicNeue',
                ),
              ),
              Text(
                item["lower"]!,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'ComicNeue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
