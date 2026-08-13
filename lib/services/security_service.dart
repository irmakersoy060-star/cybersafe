import '../models/security_check.dart';

class SecurityService {
  // Dönüş tipini açıkça List<SecurityCheck> olarak tanımladık
  List<SecurityCheck> getInitialChecks() {
    return <SecurityCheck>[
      SecurityCheck(
        id: '1',
        title: 'Ekran Kilidi',
        description: 'Cihazınızda PIN veya Biyometrik kilit aktif mi?',
        isPassed: true,
        points: 30,
      ),
      SecurityCheck(
        id: '2',
        title: 'Güçlü Parola Kullanımı',
        description: 'Hesaplarınızda karmaşık parolalar tercih ediyor musunuz?',
        isPassed: false,
        points: 25,
      ),
      SecurityCheck(
        id: '3',
        title: 'İki Faktörlü Doğrulama (2FA)',
        description: 'Önemli hesaplarınızda 2FA açık mı?',
        isPassed: true,
        points: 25,
      ),
      SecurityCheck(
        id: '4',
        title: 'Güncel Yazılım',
        description: 'İşletim sisteminiz en son sürüme güncellendi mi?',
        isPassed: false,
        points: 20,
      ),
    ];
  }

  // Puan Hesaplayıcı
  int calculateScore(List<SecurityCheck> checks) {
    int totalScore = 0;
    for (var check in checks) {
      if (check.isPassed) {
        totalScore += check.points;
      }
    }
    return totalScore;
  }
}