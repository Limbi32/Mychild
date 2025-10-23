import 'package:flutter/material.dart';

class SignLanguageScreen extends StatelessWidget {
  const SignLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Langage des signes")),
      body: const Center(
        child: Text(
          "Vidéos et quiz en LSF et ASL 👐",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
