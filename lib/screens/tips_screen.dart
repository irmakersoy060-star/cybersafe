import 'package:flutter/material.dart';
import '../models/security_tip.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  List _getTips() {
    return [
      SecurityTip(
        title: 'Olta Saldırılarına (Phishing) Dikkat!',
        description: 'E-posta veya SMS ile gelen acil eylem gerektiren bağlantılara tıklamadan önce gönderici adresini mutlaka kontrol edin.',
        icon: Icons.phishing_rounded,
        category: 'E-Posta Güvenliği',
      ),
      SecurityTip(
        title: 'Ortak Wi-Fi Ağlarında VPN Kullanın',
        description: 'Kütüphane, kafe gibi halka açık Wi-Fi ağlarında şifresiz veri trafiği dinlenebilir. Hassas işlemler için VPN kullanın.',
        icon: Icons.wifi_lock_rounded,
        category: 'Ağ Güvenliği',
      ),
      SecurityTip(
        title: 'İki Faktörlü Doğrulama (2FA) Şart',
        description: 'Sadece şifre yeterli değildir. WhatsApp, Instagram ve banka hesaplarınızda SMS veya Authenticator ile 2FA aktifleştirin.',
        icon: Icons.verified_user_rounded,
        category: 'Hesap Güvenliği',
      ),
      SecurityTip(
        title: 'Parola Yöneticisi Kullanın',
        description: 'Her platform için farklı ve karmaşık şifreler belirleyin. Şifrelerinizi aklınızda tutmak yerine güvenli parola yöneticileri tercih edin.',
        icon: Icons.key_rounded,
        category: 'Parola Yönetimi',
      ),
      SecurityTip(
        title: 'Yazılımlarınızı Güncel Tutun',
        description: 'Sistem güncellemeleri sadece yeni özellikler getirmez, bilinen güvenlik açıklarını da kapatır.',
        icon: Icons.system_update_rounded,
        category: 'Cihaz Güvenliği',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tips = _getTips();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        title: const Text(
          'Güvenlik İpuçları 💡',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6F5E53)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE8E2D5)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6F5E53).withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EFE6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        tip.icon,
                        color: const Color(0xFF6F5E53),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.category,
                            style: const TextStyle(
                              color: Color(0xFF8D7B68),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            tip.title,
                            style: const TextStyle(
                              color: Color(0xFF6F5E53),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  tip.description,
                  style: const TextStyle(
                    color: Color(0xFF8D7B68),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}