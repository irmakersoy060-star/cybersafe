class LinkAnalysisResult {
  final String url;
  final bool isHttps;
  final bool isIpAddress;
  final bool isShortenedUrl;
  final bool hasSuspiciousExtension;
  final int riskScore;

  LinkAnalysisResult({
    required this.url,
    required this.isHttps,
    required this.isIpAddress,
    required this.isShortenedUrl,
    required this.hasSuspiciousExtension,
    required this.riskScore,
  });
}

class LinkScannerService {
  LinkAnalysisResult analyzeUrl(String inputUrl) {
    String originalInput = inputUrl.trim().toLowerCase();

    // Gerçekten kullanıcı https:// yazdı mı kontrol edelim
    bool isHttps = originalInput.startsWith('https://');

    String formattedUrl = originalInput;
    if (!formattedUrl.startsWith('http://') && !formattedUrl.startsWith('https://')) {
      formattedUrl = 'https://$formattedUrl';
    }

    // IP Adresi Tespiti (Örn: 192.168.1.1 veya http://192.168.1.1/login)
    bool isIpAddress = RegExp(r'(\d{1,3}\.){3}\d{1,3}').hasMatch(originalInput);

    // Kısa Link Tespiti
    List<String> shorteners = ['bit.ly', 'tinyurl.com', 't.co', 'goo.gl', 'is.gd', 'buff.ly'];
    bool isShortened = shorteners.any((domain) => originalInput.contains(domain));

    // Şüpheli Uzantı Tespiti (.exe, .apk vb. parametrelerden önce veya sonda mı)
    List<String> suspiciousExts = ['.exe', '.apk', '.zip', '.scr', '.bat', '.iso'];
    bool hasSuspiciousExt = suspiciousExts.any((ext) => originalInput.contains(ext));

    // Risk Puanı Hesaplama (Daha hassas ağırlıklar)
    int risk = 0;
    if (!isHttps) risk += 25;
    if (isIpAddress) risk += 45; // IP adresi doğrudan yüksek risktir!
    if (isShortened) risk += 20;
    if (hasSuspiciousExt) risk += 50; // .exe/.apk tespiti doğrudan kırmızı bayraktır!

    int finalScore = risk.clamp(0, 100);

    return LinkAnalysisResult(
      url: formattedUrl,
      isHttps: isHttps,
      isIpAddress: isIpAddress,
      isShortenedUrl: isShortened,
      hasSuspiciousExtension: hasSuspiciousExt,
      riskScore: finalScore,
    );
  }
}