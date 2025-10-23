import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'services/activation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = ActivationService();
  final savedKey = await service.getKey();

  runApp(MyChildApp(isActivated: savedKey != null));
}

class MyChildApp extends StatelessWidget {
  final bool isActivated;

  const MyChildApp({super.key, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Child',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isActivated ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
