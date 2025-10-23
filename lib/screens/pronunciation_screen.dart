import 'package:flutter/material.dart';

class PronunciationScreen extends StatelessWidget {
  const PronunciationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prononciation")),
      body: const Center(
        child: Text(
          "Module de prononciation bilingue FR/EN 🎧",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
