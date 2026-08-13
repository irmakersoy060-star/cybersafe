import 'dart:math';

class PasswordService {
  // Parola Güç Puanı Hesaplama (0 - 100 arası)
  double calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    double score = 0;

    // Uzunluk kontrolü
    if (password.length >= 8) score += 0.25;
    if (password.length >= 12) score += 0.25;

    // Karakter türü kontrolleri
    if (password.contains(RegExp(r'[A-Z]'))) score += 0.15; // Büyük harf
    if (password.contains(RegExp(r'[a-z]'))) score += 0.15; // Küçük harf
    if (password.contains(RegExp(r'[0-9]'))) score += 0.10; // Rakam
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score += 0.10; // Özel karakter

    return score.clamp(0.0, 1.0);
  }

  // Rastgele Güçlü Parola Oluşturucu
  String generateStrongPassword({int length = 14}) {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const digits = '0123456789';
    const special = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    const allChars = uppercase + lowercase + digits + special;
    final random = Random.secure();

    // Her türden en az 1 tane garanti et
    List password = [
      uppercase[random.nextInt(uppercase.length)],
      lowercase[random.nextInt(lowercase.length)],
      digits[random.nextInt(digits.length)],
      special[random.nextInt(special.length)],
    ];

    // Kalanı rastgele doldur
    for (int i = 4; i < length; i++) {
      password.add(allChars[random.nextInt(allChars.length)]);
    }

    // Karıştır
    password.shuffle(random);
    return password.join();
  }
}