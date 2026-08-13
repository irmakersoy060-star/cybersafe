import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'password_screen.dart';
import 'link_scanner_screen.dart';
import 'tips_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State createState() => _MainWrapperState();
}

class _MainWrapperState extends State {
  int _currentIndex = 0;

  final List _pages = const [
    HomeScreen(),
    PasswordScreen(),
    LinkScannerScreen(),
    TipsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFE8E2D5), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFFDFBF7),
          selectedItemColor: const Color(0xFF6F5E53),
          unselectedItemColor: const Color(0xFFC2B8A3),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              activeIcon: Icon(Icons.shield),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock_outline),
              activeIcon: Icon(Icons.lock),
              label: 'Parola',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.link_outlined),
              activeIcon: Icon(Icons.link),
              label: 'Link Tara',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb),
              label: 'İpuçları',
            ),
          ],
        ),
      ),
    );
  }
}