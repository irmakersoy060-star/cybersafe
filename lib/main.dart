import 'package:flutter/material.dart';
import 'screens/main_wrapper.dart';

void main() {
  runApp(const CyberSafeApp());
}

class CyberSafeApp extends StatelessWidget {
  const CyberSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberSafe',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFDFBF7),
        fontFamily: 'Sans-Serif',
      ),
      home: const MainWrapper(),
    );
  }
}