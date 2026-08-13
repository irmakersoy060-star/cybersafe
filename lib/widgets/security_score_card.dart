import 'package:flutter/material.dart';

class SecurityScoreCard extends StatelessWidget {
  final int score;

  const SecurityScoreCard({super.key, required this.score});

  Color _getScoreColor() {
    if (score >= 80) return const Color(0xFFA3B18A); // Soft Yeşil / Zeytin
    if (score >= 50) return const Color(0xFFE0A96D); // Sıcak Amber / Soft Turuncu
    return const Color(0xFFC96868); // Soft Kırmızı
  }

  String _getScoreStatus() {
    if (score >= 80) return 'Sisteminiz Güvende 🛡️';
    if (score >= 50) return 'Orta Düzey Risk Var ⚠️';
    return 'Yüksek Risk Altındasınız! 🚨';
  }

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, // Saf Beyaz Kart
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8E2D5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F5E53).withOpacity(0.06), // Zarif soft gölge
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFFF3EFE6), // Krem halkanın zemini
                  color: color,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6F5E53), // Açık kahve tonu
                    ),
                  ),
                  const Text(
                    '/ 100',
                    style: TextStyle(color: Color(0xFF8D7B68), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getScoreStatus(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}