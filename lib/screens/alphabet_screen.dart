import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

// Le widget est converti en StatefulWidget pour gérer l'initialisation du TTS
class AlphabetScreen extends StatefulWidget {
   const AlphabetScreen({super.key});

   @override
   State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
   // Couleurs enfantines comme les autres écrans
   static const Color primaryBackgroundColor = Color(0xFF5DADE2); // Bleu ciel comme home_screen
   static const Color accentColor = Color(0xFF1E3A8A); // Bleu sombre des maquettes

   // Initialisation de l'objet TTS
   late FlutterTts flutterTts;

   // Liste de toutes les lettres de l'alphabet
   final List<String> alphabet = List.generate(
     26,
     (index) => String.fromCharCode('A'.codeUnitAt(0) + index),
   );

   // État pour le clavier virtuel
   bool _showKeyboard = false;
   String? _selectedLetter;
   Set<String> _favorites = {};

   @override
   void initState() {
     super.initState();
     flutterTts = FlutterTts();
     _initializeTts();
   }

   Future<void> _initializeTts() async {
     await flutterTts.setLanguage("fr-FR");
     await flutterTts.setSpeechRate(0.5);
   }

   Future<void> _speak(String text, {String language = "fr-FR"}) async {
     await flutterTts.stop();
     await flutterTts.setLanguage(language);
     await flutterTts.speak(text);
   }

   void _toggleFavorite(String letter) {
     setState(() {
       if (_favorites.contains(letter)) {
         _favorites.remove(letter);
       } else {
         _favorites.add(letter);
       }
     });
   }

   @override
   void dispose() {
     flutterTts.stop();
     super.dispose();
   }

   // Fonction pour afficher le clavier virtuel
   void _onLetterTap(String letter) {
     setState(() {
       _selectedLetter = letter;
       _showKeyboard = true;
     });
     _speak(letter);
   }

   // Fermer le clavier virtuel
   void _closeKeyboard() {
     setState(() {
       _showKeyboard = false;
       _selectedLetter = null;
     });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: primaryBackgroundColor,
       body: SafeArea(
         child: Stack(
           children: [
             // Contenu principal
             Column(
               children: [
                 // AppBar style enfantin
                 Container(
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: accentColor,
                     borderRadius: const BorderRadius.only(
                       bottomLeft: Radius.circular(20),
                       bottomRight: Radius.circular(20),
                     ),
                   ),
                   child: Row(
                     children: [
                       IconButton(
                         icon: const Icon(Icons.arrow_back, color: Colors.white),
                         onPressed: () => Navigator.of(context).pop(),
                       ),
                       Expanded(
                         child: Text(
                           "Module Alphabet",
                           style: GoogleFonts.bubblegumSans(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: 24,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ),
                       const SizedBox(width: 48), // Pour équilibrer
                     ],
                   ),
                 ),

                 const SizedBox(height: 20),

                 // Titre enfantin avec Google Fonts
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Text(
                     "Apprends l'Alphabet !",
                     style: GoogleFonts.bubblegumSans(
                       color: Colors.white,
                       fontSize: 28,
                       fontWeight: FontWeight.w900,
                       shadows: [
                         Shadow(
                           color: accentColor.withOpacity(0.8),
                           offset: const Offset(2.0, 2.0),
                           blurRadius: 3.0,
                         ),
                         Shadow(
                           color: accentColor.withOpacity(0.8),
                           offset: const Offset(-2.0, -2.0),
                           blurRadius: 3.0,
                         ),
                         Shadow(
                           color: accentColor.withOpacity(0.8),
                           offset: const Offset(2.0, -2.0),
                           blurRadius: 3.0,
                         ),
                         Shadow(
                           color: accentColor.withOpacity(0.8),
                           offset: const Offset(-2.0, 2.0),
                           blurRadius: 3.0,
                         ),
                       ],
                     ),
                     textAlign: TextAlign.center,
                   ),
                 ),

                 const SizedBox(height: 20),

                 // Grille des lettres dans un container enfantin
                 Expanded(
                   child: Container(
                     margin: const EdgeInsets.symmetric(horizontal: 20),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.15),
                           blurRadius: 10,
                           offset: const Offset(0, 5),
                         ),
                       ],
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(20),
                       child: GridView.builder(
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: alphabet.length,
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 5,
                           childAspectRatio: 1.0,
                           crossAxisSpacing: 10.0,
                           mainAxisSpacing: 10.0,
                         ),
                         itemBuilder: (context, index) {
                           final letter = alphabet[index];
                           return AlphabetLetter(
                             letter: letter,
                             onTap: () => _onLetterTap(letter),
                           );
                         },
                       ),
                     ),
                   ),
                 ),

                 // Texte d'encouragement avec Google Fonts
                 Padding(
                   padding: const EdgeInsets.all(20),
                   child: Text(
                     "Bienvenue dans l'univers éducatif universel 🌟",
                     textAlign: TextAlign.center,
                     style: GoogleFonts.bubblegumSans(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w900,
                       shadows: [
                         Shadow(
                           color: accentColor.withOpacity(0.6),
                           offset: const Offset(1.0, 1.0),
                           blurRadius: 2.0,
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
             ),

             // Clavier virtuel en overlay
             if (_showKeyboard)
               Positioned.fill(
                 child: GestureDetector(
                   onTap: _closeKeyboard,
                   child: Container(
                     color: Colors.black.withOpacity(0.5),
                     child: BackdropFilter(
                       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                       child: Container(
                         color: Colors.transparent,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             LetterDetailPanel(
                               selectedLetter: _selectedLetter!,
                               isFavorite: _favorites.contains(_selectedLetter!),
                               onClose: _closeKeyboard,
                               onSpeakFrench: () => _speak(_selectedLetter!, language: "fr-FR"),
                               onSpeakEnglish: () => _speak(_selectedLetter!, language: "en-US"),
                               onToggleFavorite: () => _toggleFavorite(_selectedLetter!),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
           ],
         ),
       ),
     );
   }
}

// =========================================================
// WIDGET SÉPARÉ POUR CHAQUE LETTRE (Le bouton interactif)
// =========================================================
class AlphabetLetter extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;

  const AlphabetLetter({required this.letter, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Couleur de fond de la lettre (Blanc)
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: GoogleFonts.bubblegumSans(
            fontSize: 40, // Grande taille de police
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E3A8A), // Bleu sombre pour le texte
          ),
        ),
      ),
    );
  }
}

// =========================================================
// WIDGET PANEL DE DÉTAIL DE LETTRE
// =========================================================
class LetterDetailPanel extends StatelessWidget {
   final String selectedLetter;
   final bool isFavorite;
   final VoidCallback onClose;
   final VoidCallback onSpeakFrench;
   final VoidCallback onSpeakEnglish;
   final VoidCallback onToggleFavorite;

   const LetterDetailPanel({
     required this.selectedLetter,
     required this.isFavorite,
     required this.onClose,
     required this.onSpeakFrench,
     required this.onSpeakEnglish,
     required this.onToggleFavorite,
     super.key,
   });

   @override
   Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.all(20),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.3),
             blurRadius: 20,
             offset: const Offset(0, -5),
           ),
         ],
       ),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           // Barre supérieure avec bouton fermer et favoris
           Container(
             padding: const EdgeInsets.all(16),
             decoration: const BoxDecoration(
               color: Color(0xFF1E3A8A),
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(20),
                 topRight: Radius.circular(20),
               ),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 IconButton(
                   icon: const Icon(Icons.close, color: Colors.white),
                   onPressed: onClose,
                 ),
                 IconButton(
                   icon: Icon(
                     isFavorite ? Icons.favorite : Icons.favorite_border,
                     color: isFavorite ? Colors.red : Colors.white,
                   ),
                   onPressed: onToggleFavorite,
                 ),
               ],
             ),
           ),

           // Lettre principale avec Google Fonts
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
             child: Text(
               selectedLetter,
               style: GoogleFonts.bubblegumSans(
                 fontSize: 120,
                 fontWeight: FontWeight.w900,
                 color: const Color(0xFF1E3A8A),
                 shadows: [
                   Shadow(
                     color: const Color(0xFF1E3A8A).withOpacity(0.3),
                     offset: const Offset(4.0, 4.0),
                     blurRadius: 8.0,
                   ),
                   Shadow(
                     color: const Color(0xFF1E3A8A).withOpacity(0.3),
                     offset: const Offset(-4.0, -4.0),
                     blurRadius: 8.0,
                   ),
                   Shadow(
                     color: const Color(0xFF1E3A8A).withOpacity(0.3),
                     offset: const Offset(4.0, -4.0),
                     blurRadius: 8.0,
                   ),
                   Shadow(
                     color: const Color(0xFF1E3A8A).withOpacity(0.3),
                     offset: const Offset(-4.0, 4.0),
                     blurRadius: 8.0,
                   ),
                 ],
               ),
             ),
           ),

           // Boutons de lecture
           Padding(
             padding: const EdgeInsets.all(20),
             child: Column(
               children: [
                 // Bouton Français avec Google Fonts
                 Container(
                   width: double.infinity,
                   height: 60,
                   margin: const EdgeInsets.only(bottom: 15),
                   child: ElevatedButton.icon(
                     onPressed: onSpeakFrench,
                     icon: const Icon(Icons.volume_up, size: 30),
                     label: Text(
                       "ÉCOUTER EN FRANÇAIS",
                       style: GoogleFonts.bubblegumSans(
                         fontSize: 18,
                         fontWeight: FontWeight.w900,
                       ),
                     ),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: const Color(0xFF1E3A8A),
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       padding: const EdgeInsets.symmetric(vertical: 15),
                     ),
                   ),
                 ),

                 // Bouton Anglais avec Google Fonts
                 Container(
                   width: double.infinity,
                   height: 60,
                   child: ElevatedButton.icon(
                     onPressed: onSpeakEnglish,
                     icon: const Icon(Icons.volume_up, size: 30),
                     label: Text(
                       "LISTEN IN ENGLISH",
                       style: GoogleFonts.bubblegumSans(
                         fontSize: 18,
                         fontWeight: FontWeight.w900,
                       ),
                     ),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.blue.shade600,
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       padding: const EdgeInsets.symmetric(vertical: 15),
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
   }
}
