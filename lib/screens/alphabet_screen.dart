import 'package:flutter/material.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alphabet")),
      body: const Center(
        child: Text(
          "Apprentissage de l’alphabet à venir ✨",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
