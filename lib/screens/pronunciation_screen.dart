import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_fonts/google_fonts.dart';

class PronunciationScreen extends StatefulWidget {
  const PronunciationScreen({super.key});

  @override
  State<PronunciationScreen> createState() => _PronunciationScreenState();
}

class _PronunciationScreenState extends State<PronunciationScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();
  final TextEditingController _controller = TextEditingController();

  String _selectedLang = 'fr-FR';
  String _recognizedText = '';
  bool _isSpeaking = false;
  bool _isListening = false;
  bool _isInitializing = false; // ⚡ Flag pour éviter multiple initialize

  // 🔊 Lecture vocale
  Future<void> _speak() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSpeaking = true);
    await flutterTts.setLanguage(_selectedLang);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.9);
    await flutterTts.speak(text);
    setState(() => _isSpeaking = false);
  }

  // 🎤 Reconnaissance vocale
  Future<void> _listen() async {
    if (_isListening || _isInitializing) return;

    _isInitializing = true;
    bool available = await speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        debugPrint("Erreur micro: $error");
        setState(() => _isListening = false);
      },
    );
    _isInitializing = false;

    if (available) {
      setState(() {
        _isListening = true;
        _recognizedText = '';
      });
      await speech.listen(
        localeId: _selectedLang,
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
            _controller.text = _recognizedText;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B57CF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B57CF),
        elevation: 0,
        title: Text(
          "Prononciation",
          style: GoogleFonts.bubblegumSans(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Module de prononciation bilingue 🇫🇷 / 🇬🇧",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bubblegumSans(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                // 📝 Champ de texte
                TextField(
                  controller: _controller,
                  style: GoogleFonts.bubblegumSans(fontSize: 18, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Entre un mot à prononcer...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 🌍 Choix de la langue
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedLang,
                      items: const [
                        DropdownMenuItem(
                          value: 'fr-FR',
                          child: Text("🇫🇷 Français"),
                        ),
                        DropdownMenuItem(
                          value: 'en-US',
                          child: Text("🇬🇧 Anglais"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedLang = value!);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // 🔊 Bouton écouter
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0B57CF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(
                    _isSpeaking ? Icons.volume_down : Icons.volume_up,
                    size: 28,
                  ),
                  label: Text(
                    _isSpeaking
                        ? "Lecture en cours..."
                        : "Écouter la prononciation",
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _isSpeaking ? null : _speak,
                ),
                const SizedBox(height: 25),
                // 🎤 Bouton parler
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isListening
                        ? Colors.redAccent
                        : Colors.white,
                    foregroundColor: _isListening
                        ? Colors.white
                        : const Color(0xFF0B57CF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    size: 28,
                  ),
                  label: Text(
                    _isListening ? "Arrêter" : "Essayer ta prononciation 🎤",
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _listen,
                ),
                const SizedBox(height: 30),
                // 📊 Résultat
                if (_recognizedText.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "🗣️ Tu as dit :",
                          style: GoogleFonts.bubblegumSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _recognizedText,
                          style: GoogleFonts.bubblegumSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  "Entraîne-toi à parler et à écouter\npour améliorer ton accent 🎧🎙️",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bubblegumSans(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
