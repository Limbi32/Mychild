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
    const MoralityItem(
      title: "Le Colibri et le Feu",
      description: "Il était une fois, dans une grande forêt, un terrible feu se déclara. Les flammes dévoraient les arbres, les animaux fuyaient dans tous les sens, et la fumée assombrissait le ciel. Tous les animaux se réunirent loin du danger, impuissants. Sauf un tout petit colibri. Lui, il volait jusqu'à la rivière, prenait une goutte d'eau dans son bec, et la jetait sur le feu. Les autres animaux le regardaient, étonnés : « Colibri, tu es minuscule! Tu ne peux pas éteindre ce feu avec une goutte d'eau! » Le colibri répondit calmement : « Peut-être. Mais je fais ma part. » Touchés par son courage, les autres animaux commencèrent à l'aider : les éléphants apportèrent de l'eau avec leurs trompes, les singes creusèrent des tranchées, les oiseaux volèrent en groupe. Petit à petit, le feu fut maîtrisé. Même les plus petits gestes peuvent inspirer de grands changements. Il suffit d'oser commencer.",
      imagePath: "assets/moralite/5.jpg",
    ),
    const MoralityItem(
      title: "Le Renard et la Pierre Magique",
      description: "Dans un village entouré de montagnes, vivait un jeune renard nommé Kimo. Curieux et malin, il adorait explorer les bois. Un jour, il découvrit une pierre brillante au fond d'une grotte. Elle changeait de couleur selon ses émotions : rouge quand il était en colère, bleue quand il était triste, et dorée quand il était heureux. Kimo pensa : « Si je garde cette pierre, je serai toujours joyeux. » Mais très vite, il réalisa que la pierre ne brillait en doré que lorsqu'il aidait les autres. Alors, il commença à partager : il aida la tortue à traverser la rivière, consola le hibou qui avait perdu ses lunettes, et même offrit un abri au hérisson pendant la pluie. Chaque fois qu'il faisait une bonne action, la pierre brillait plus fort. Les animaux du village vinrent le voir, et bientôt, Kimo n'avait plus besoin de la pierre : son cœur brillait tout seul. La vraie magie ne vient pas des objets, mais des gestes qu'on fait avec le cœur.",
      imagePath: "assets/moralite/6.jpg",
    ),
    const MoralityItem(
      title: "Le Papillon et la Goutte de Rosée",
      description: "Il était une fois, dans un jardin baigné par la première lumière du matin, un magnifique papillon nommé Céleste. Ses ailes étaient d'un bleu et d'un or éclatants. Il se posa délicatement sur la feuille d'une rose et remarqua une petite goutte de rosée, parfaitement ronde et brillante. « Que tu es minuscule ! » s'exclama Céleste, se pavanant. « Regarde-moi ! Je peux voler au-dessus des plus hautes fleurs et danser avec le vent. Mon existence est une aventure sans fin. » La goutte de rosée, sans bouger, répondit d'une voix cristalline : « C'est vrai, tes voyages sont grandioses, papillon. Mais regarde bien en moi. » Intrigué, Céleste pencha sa tête. Dans la petite sphère d'eau, il vit son propre reflet, mais aussi le jardin entier : la rose écarlate, l'herbe verte, le ciel pâle et même un rayon de soleil. Tout l'univers du jardin était contenu et reflété, plus beau encore, dans cette minuscule goutte. La goutte sourit : « Tu voyages partout pour voir le monde. Moi, je reste ici, mais le monde entier vient à moi. La grandeur ne se mesure pas toujours par la taille ou la distance parcourue, mais par la profondeur de ce que l'on sait contenir. » Céleste resta silencieux, méditant sur la sagesse de cette petite goutte. Il comprit qu'il y a de la beauté et de la richesse dans l'immobilité et la contemplation, tout autant que dans le mouvement et l'aventure.",
      imagePath: "assets/moralite/7.jpg",
    ),
    const MoralityItem(
      title: "Le Vieux Saule et le Petit Ruisseau",
      description: "Au bord d'une prairie verdoyante se tenait un vieux saule pleureur, les branches lourdes et pendantes comme de longs cheveux verts. Il avait vu passer des siècles et ses racines profondes s'enfonçaient dans la terre humide, juste à côté d'un petit ruisseau. Le ruisseau, nommé Vif-Argent, était jeune, rapide et incroyablement impatient. Chaque jour, il grondait contre le saule : « Tu es si lent, si statique ! Regarde-moi ! Je cours, je bondis, je traverse la forêt et je me jette dans la rivière ! J'ai tellement de choses à voir et si peu de temps ! » Le saule souriait avec la sagesse des choses anciennes. « Calme-toi, petit Vif-Argent. Où cours-tu avec tant de hâte ? » « Vers l'océan, bien sûr ! C'est l'aventure ultime ! » répondit le ruisseau. Un jour, une grande sécheresse s'abattit sur la région. Le ruisseau Vif-Argent, qui s'était tellement pressé, commença à faiblir. Il devint un simple filet d'eau, et bientôt, il ne fut plus qu'une flaque boueuse. « Vieux saule, » murmura Vif-Argent, « je meurs. Je n'atteindrai jamais l'océan. » Le saule pencha l'une de ses branches et fit doucement de l'ombre au filet d'eau restant. « N'aie crainte, petit ami. Mes racines sont profondes. Elles puisent l'eau loin sous la terre. » Puis, le saule laissa échapper de ses feuilles une infime quantité de cette eau stockée, juste assez pour maintenir Vif-Argent en vie, jusqu'à ce que la pluie revienne. Lorsque la pluie tomba enfin, Vif-Argent s'arrêta un instant près du saule. « Merci, cher ami. Je pensais que le voyage était la seule chose qui comptait. Mais sans tes racines pour te garder ici, je n'aurais même pas pu continuer le mien. » Le vieux saule sourit dans la brise. « Le monde a besoin de ceux qui courent et de ceux qui restent immobiles. L'action est nécessaire, mais la patience et la profondeur le sont tout autant. »",
      imagePath: "assets/moralite/8.jpg",
    ),
    const MoralityItem(
      title: "Sagesse et Citations",
      description: "« La seule chose que je sais, c'est que je ne sais rien. » - Socrate. « L'imagination est plus importante que le savoir. » - Albert Einstein. « La vie, ce n'est pas d'attendre que les orages passent, c'est d'apprendre à danser sous la pluie. » - Sénèque. « Aimer, ce n'est pas se regarder l'un l'autre, c'est regarder ensemble dans la même direction. » - Antoine de Saint-Exupéry. « Choisissez un travail que vous aimez et vous n'aurez pas à travailler un seul jour de votre vie. » - Confucius. Mieux vaut prévenir que guérir. Qui sème le vent récolte la tempête. Après la pluie, le beau temps. L'argent est un bon serviteur, mais un mauvais maître. Un tiens vaut mieux que deux tu l'auras.",
      imagePath: "assets/moralite/2.jpg",
    ),
    const MoralityItem(
      title: "Leçons de Vie",
      description: "L'imperfection est humaine. Acceptez vos erreurs et vos défauts. L'échec n'est pas l'opposé du succès, mais une étape nécessaire pour y arriver. Connais-toi toi-même. La quête de soi est le voyage d'une vie. Comprendre vos valeurs, vos forces et vos faiblesses est fondamental. La gratitude transforme. Se concentrer sur ce que l'on a, plutôt que sur ce qui nous manque, est la clé d'un bonheur durable. Le courage n'est pas l'absence de peur, mais la capacité d'agir malgré elle. L'instant présent est tout. Votre pouvoir réside uniquement dans le moment présent. C'est le seul moment où l'on peut agir. La constance est plus forte que la vitesse. Les petits efforts réguliers produisent des résultats bien plus grands. Les relations sont la richesse. L'amour, l'amitié et les liens familiaux sont la source la plus importante de bonheur. Le bonheur est un voyage, pas une destination. Il se trouve dans l'appréciation des petits moments de la vie quotidienne. Le changement est la seule constante. Accepter et s'adapter au changement est la clé de la sérénité.",
      imagePath: "assets/moralite/2.jpg",
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
                      style: GoogleFonts.bubblegumSans(
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
                            style: GoogleFonts.bubblegumSans(
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
                                  style: GoogleFonts.bubblegumSans(fontSize: isSmallScreen ? 12 : 14),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _getBadgeText(currentItem.title),
                                    style: GoogleFonts.bubblegumSans(
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
                              style: GoogleFonts.bubblegumSans(
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
                                    style: GoogleFonts.bubblegumSans(
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
                        Text(
                          'Contes & Moralité',
                          style: GoogleFonts.bubblegumSans(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Text(
                          'Découvrez des histoires merveilleuses qui enseignent des leçons de vie précieuses pour les enfants.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bubblegumSans(
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
                              _currentIndex = 1; // Passer au premier conte
                            });
                          },
                        ),

                        const SizedBox(height: 30),

                        // Texte d'encouragement
                        Text(
                          'Chaque histoire apporte sagesse et joie 💫',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bubblegumSans(
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
              Text(icon, style: GoogleFonts.bubblegumSans(fontSize: 24)),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.bubblegumSans(
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
        style: GoogleFonts.bubblegumSans(fontWeight: FontWeight.bold),
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
