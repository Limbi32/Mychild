import 'package:flutter/material.dart';

class MoralityScreen extends StatelessWidget {
  const MoralityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contes & moralité")),
      body: const Center(
        child: Text(
          "Contes, proverbes et leçons de vie 📖",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
