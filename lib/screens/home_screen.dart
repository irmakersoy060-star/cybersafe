import 'package:flutter/material.dart';
import '../models/security_check.dart';
import '../services/security_service.dart';
import '../widgets/security_score_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SecurityService _securityService = SecurityService();
  late List<SecurityCheck> _checks;
  late int _score;

  @override
  void initState() {
    super.initState();
    _checks = _securityService.getInitialChecks();
    _score = _securityService.calculateScore(_checks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Krem / Ekru Arka Plan
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        title: const Text(
          'CyberSafe 🛡️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF6F5E53), // Açık kahve başlık
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecurityScoreCard(score: _score),
            const SizedBox(height: 28),
            const Text(
              'Güvenlik Kontrolleri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F5E53),
              ),
            ),
            const SizedBox(height: 14),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _checks.length,
              itemBuilder: (context, index) {
                final check = _checks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE8E2D5)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6F5E53).withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: Icon(
                      check.isPassed
                          ? Icons.check_circle_rounded
                          : Icons.warning_amber_rounded,
                      color: check.isPassed
                          ? const Color(0xFFA3B18A)
                          : const Color(0xFFE0A96D),
                      size: 28,
                    ),
                    title: Text(
                      check.title,
                      style: const TextStyle(
                        color: Color(0xFF6F5E53),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      check.description,
                      style: const TextStyle(
                        color: Color(0xFF8D7B68),
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '+${check.points} Puan',
                      style: TextStyle(
                        color: check.isPassed
                            ? const Color(0xFFA3B18A)
                            : const Color(0xFF8D7B68),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}