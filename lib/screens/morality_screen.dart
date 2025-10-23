import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoralityLoadingScreen extends StatelessWidget {
  // Couleur exacte du fond bleu sombre/électrique de la maquette
  static const Color primaryBlue = Color(0xFF1E3A8A);

  const MoralityLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // La taille du texte est relative à la taille de l'écran (MediaQuery)
    double screenHeight = MediaQuery.of(context).size.height;

    // Navigation automatique après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MoralityScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: primaryBlue,
      body: Column(
        // Aligner les enfants en haut de l'écran
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ===========================================
          // 1. IMAGE (La Carte de l'histoire)
          // ===========================================
          Container(
            // Hauteur déterminée pour correspondre au ratio visuel
            height: screenHeight * 0.55,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white, // Fond blanc visible
              borderRadius: BorderRadius.circular(15.0),
              // Optionnel: légère ombre si l'image est dans un Card
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/moralite/2.jpg', // Chemin vers votre image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Espace entre l'image et le titre
          SizedBox(height: screenHeight * 0.05),

          // ===========================================
          // 2. TEXTE DU TITRE (Section contes & moralité)
          // ===========================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Section contes\n& moralité', // Titre sur deux lignes
              textAlign: TextAlign.center,
              style: GoogleFonts.bubblegumSans(
                fontSize: screenHeight * 0.08, // Taille relative pour un grand titre
                fontWeight: FontWeight.w900,
                color: Colors.white, // Couleur blanche
                // REPRODUCTION DE L'EFFET D'OMBRE ET DE CONTOUR
                shadows: [
                  // Ombre/Contour Bleu Foncé/Bleu Primaire (l'effet est créé par plusieurs ombres)
                  Shadow(
                    color: primaryBlue.withOpacity(0.8),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 5.0,
                  ),
                  Shadow(
                    color: primaryBlue.withOpacity(0.8),
                    offset: const Offset(-4.0, -4.0),
                    blurRadius: 5.0,
                  ),
                  Shadow(
                    color: primaryBlue.withOpacity(0.8),
                    offset: const Offset(4.0, -4.0),
                    blurRadius: 5.0,
                  ),
                  Shadow(
                    color: primaryBlue.withOpacity(0.8),
                    offset: const Offset(-4.0, 4.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoralityItem {
  final String title;
  final String description;
  final String imagePath;

  const MoralityItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class MoralityScreen extends StatefulWidget {
  const MoralityScreen({super.key});

  @override
  State<MoralityScreen> createState() => _MoralityScreenState();
}

class _MoralityScreenState extends State<MoralityScreen> {
  bool _hasStarted = false;

  final List<MoralityItem> _moralityItems = [
    const MoralityItem(
      title: "Le Lion et la Petite Souris",
      description: "Un jour, une petite souris courait dans la savane et marcha sans le vouloir sur la patte d'un grand lion endormi. Réveillé en sursaut, le lion faillit la dévorer, mais la souris le supplia de lui laisser la vie sauve, promettant qu'un jour elle lui rendrait service. Le lion éclata de rire, mais la laissa partir. Quelques semaines plus tard, le lion fut pris dans un piège de chasseurs. En entendant ses rugissements, la souris accourut et rongea les cordes jusqu'à le libérer. Le lion comprit alors que même les plus petits peuvent sauver les plus grands.",
      imagePath: "assets/moralite/1.jpg",
    ),
    const MoralityItem(
      title: "La Tortue et le Léopard",
      description: "La tortue, connue pour sa lenteur, fut un jour défiée par le léopard dans une course. Tous les animaux se moquaient d'elle, mais la tortue usa de sa sagesse : elle plaça des amies tortues tout le long du chemin. Chaque fois que le léopard pensait l'avoir distancée, une autre tortue apparaissait plus loin, criant : « Me voilà déjà arrivée ! ». Le léopard, épuisé, abandonna, et la tortue gagna par intelligence. Depuis ce jour, les anciens disent : « Ce n'est pas la force qui fait gagner, mais la ruse et la patience. »",
      imagePath: "assets/moralite/3.jpg",
    ),
    const MoralityItem(
      title: "Le Singe et la Lune",
      description: "Une nuit, un singe vit la lune se refléter dans l'eau d'un puits. Pensant qu'elle était tombée, il appela tous les animaux pour la sauver. Ensemble, ils formèrent une chaîne pour la repêcher, mais en tirant, ils glissèrent tous dans le puits. Quand ils remontèrent trempés, la lune brillait encore dans le ciel. Ils comprirent alors que les apparences trompent, et qu'il faut réfléchir avant d'agir.",
      imagePath: "assets/moralite/4.jpg",
    ),
  ];

  int _currentIndex = 0;

  void _nextItem() {
    setState(() {
      if (_currentIndex < _moralityItems.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _prevItem() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _moralityItems[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF5DADE2),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            final horizontalPadding = isSmallScreen ? 16.0 : 24.0;
            final verticalPadding = isSmallScreen ? 12.0 : 20.0;
            final titleFontSize = isSmallScreen ? 18.0 : 22.0;
            final bodyFontSize = isSmallScreen ? 14.0 : 16.0;
            final buttonHeight = isSmallScreen ? 60.0 : 70.0;

            return CustomScrollView(
              slivers: [
                // AppBar qui se rétracte avec l'image (style React Native)
                SliverAppBar(
                  backgroundColor: const Color(0xFF5DADE2),
                  elevation: 0,
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      currentItem.imagePath,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      currentItem.title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [Shadow(color: Colors.black45, blurRadius: 3)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // Indicateur de progression
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding / 2,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (_currentIndex + 1) / _moralityItems.length,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "${_currentIndex + 1}/${_moralityItems.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Contenu principal
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
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
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge du type de contenu
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            constraints: BoxConstraints(
                              maxWidth: isSmallScreen ? 120 : 150,
                            ),
                            decoration: BoxDecoration(
                              color: _getBadgeColor(currentItem.title),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _getBadgeBorderColor(currentItem.title),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _getBadgeEmoji(currentItem.title),
                                  style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _getBadgeText(currentItem.title),
                                    style: TextStyle(
                                      color: _getBadgeTextColor(currentItem.title),
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 10 : 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: isSmallScreen ? 16 : 20),

                          // Texte avec meilleure typographie
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: bodyFontSize,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                              children: _buildTextSpans(currentItem.description),
                            ),
                            textAlign: TextAlign.justify,
                          ),

                          SizedBox(height: isSmallScreen ? 16 : 20),

                          // Citation décorative pour la dernière phrase
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5DADE2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border(
                                left: BorderSide(
                                  color: const Color(0xFF5DADE2),
                                  width: 4,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.format_quote,
                                  color: const Color(0xFF5DADE2).withOpacity(0.6),
                                  size: isSmallScreen ? 18 : 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _getLastSentence(currentItem.description),
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF5DADE2),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Boutons de navigation
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Bouton Précédent
                            Expanded(
                              child: _menuButton(
                                icon: "⬅️",
                                label: "Précédent",
                                color: Colors.white,
                                isEnabled: _currentIndex > 0,
                                onTap: _currentIndex > 0 ? _prevItem : null,
                                height: buttonHeight,
                                fontSize: isSmallScreen ? 16 : 18,
                              ),
                            ),

                            SizedBox(width: isSmallScreen ? 10 : 15),

                            // Bouton Suivant
                            Expanded(
                              child: _menuButton(
                                icon: "➡️",
                                label: "Suivant",
                                color: Colors.white,
                                isEnabled: _currentIndex < _moralityItems.length - 1,
                                onTap: _currentIndex < _moralityItems.length - 1 ? _nextItem : null,
                                height: buttonHeight,
                                fontSize: isSmallScreen ? 16 : 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Écran d'accueil des contes
  Widget _buildWelcomeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5DADE2), // Même dégradé que welcome screen
      body: SafeArea(
        child: Column(
          children: [
            // Bouton retour en haut à gauche
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image d'accueil
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/moralite/2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Titre
                        const Text(
                          'Contes & Moralité',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'Découvrez des histoires merveilleuses qui enseignent des leçons de vie précieuses pour les enfants.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Bouton Commencer (style menu principal)
                        _menuButton(
                          icon: "🚀",
                          label: "Commencer l'aventure",
                          color: Colors.white,
                          isEnabled: true,
                          onTap: () {
                            setState(() {
                              _hasStarted = true;
                              _currentIndex = 1; // Passer au premier conte
                            });
                          },
                        ),

                        const SizedBox(height: 30),

                        // Texte d'encouragement
                        const Text(
                          'Chaque histoire apporte sagesse et joie 💫',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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

  // Widget bouton style menu principal
  Widget _menuButton({
    required String icon,
    required String label,
    required Color color,
    required bool isEnabled,
    required VoidCallback? onTap,
    double height = 70,
    double fontSize = 18,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isEnabled ? [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(2, 3),
              ),
            ] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF007BFF),
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLastSentence(String description) {
    final sentences = description.split('. ');
    if (sentences.length <= 1) return description;
    return sentences.last;
  }

  List<TextSpan> _buildTextSpans(String description) {
    // Supposons que la dernière phrase est celle à mettre en gras
    final sentences = description.split('. ');
    if (sentences.length <= 1) {
      return [TextSpan(text: description)];
    }

    final lastSentence = sentences.last;
    final bodyText = '${sentences.sublist(0, sentences.length - 1).join('. ')}. ';

    return [
      TextSpan(text: bodyText),
      TextSpan(
        text: lastSentence,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ];
  }

  Color _getBadgeColor(String title) {
    if (title.contains('Lion')) return Colors.orange.shade100;
    if (title.contains('Conte d\'accueil')) return Colors.green.shade100;
    if (title.contains('Tortue')) return Colors.blue.shade100;
    if (title.contains('Singe')) return Colors.purple.shade100;
    return Colors.blue.shade100;
  }

  Color _getBadgeBorderColor(String title) {
    if (title.contains('Lion')) return Colors.orange.shade300;
    if (title.contains('Conte d\'accueil')) return Colors.green.shade300;
    if (title.contains('Tortue')) return Colors.blue.shade300;
    if (title.contains('Singe')) return Colors.purple.shade300;
    return Colors.blue.shade300;
  }

  Color _getBadgeShadowColor(String title) {
    if (title.contains('Lion')) return Colors.orange.shade200;
    if (title.contains('Conte d\'accueil')) return Colors.green.shade200;
    if (title.contains('Tortue')) return Colors.blue.shade200;
    if (title.contains('Singe')) return Colors.purple.shade200;
    return Colors.blue.shade200;
  }

  String _getBadgeEmoji(String title) {
    if (title.contains('Lion')) return '🦁';
    if (title.contains('Conte d\'accueil')) return '📚';
    if (title.contains('Tortue')) return '🐢';
    if (title.contains('Singe')) return '🐵';
    return '📖';
  }

  String _getBadgeText(String title) {
    if (title.contains('Lion')) return 'Conte du Lion';
    if (title.contains('Conte d\'accueil')) return 'Accueil';
    if (title.contains('Tortue')) return 'Conte de la Tortue';
    if (title.contains('Singe')) return 'Conte du Singe';
    return 'Conte';
  }

  Color _getBadgeTextColor(String title) {
    if (title.contains('Lion')) return Colors.orange.shade800;
    if (title.contains('Conte d\'accueil')) return Colors.green.shade800;
    if (title.contains('Tortue')) return Colors.blue.shade800;
    if (title.contains('Singe')) return Colors.purple.shade800;
    return Colors.blue.shade800;
  }
}
