import 'package:flutter/material.dart';
import '../services/link_scanner_service.dart';

class LinkScannerScreen extends StatefulWidget {
  const LinkScannerScreen({super.key});

  @override
  State createState() => _LinkScannerScreenState();
}

class _LinkScannerScreenState extends State {
  final TextEditingController _urlController = TextEditingController();
  final LinkScannerService _scannerService = LinkScannerService();
  LinkAnalysisResult? _analysisResult;

  void _scanLink() {
    if (_urlController.text.trim().isEmpty) return;
    setState(() {
      _analysisResult = _scannerService.analyzeUrl(_urlController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        title: const Text(
          'Link Tarayıcı 🔗',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6F5E53)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Kartı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E2D5)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6F5E53).withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _urlController,
                    style: const TextStyle(color: Color(0xFF6F5E53)),
                    decoration: InputDecoration(
                      hintText: 'Şüpheli bir bağlantı (URL) yapıştırın...',
                      hintStyle: const TextStyle(color: Color(0xFFC2B8A3)),
                      prefixIcon: const Icon(Icons.link_rounded, color: Color(0xFF8D7B68)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE8E2D5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE8E2D5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF6F5E53)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F5E53),
                        foregroundColor: const Color(0xFFFDFBF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _scanLink,
                      icon: const Icon(Icons.search_rounded),
                      label: const Text(
                        'Bağlantıyı Tara',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Analiz Sonucu Kartı
            if (_analysisResult != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _analysisResult!.riskScore > 40
                        ? const Color(0xFFC96868)
                        : const Color(0xFFA3B18A),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6F5E53).withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _analysisResult!.riskScore > 40
                              ? Icons.gpp_bad_rounded
                              : Icons.gpp_good_rounded,
                          color: _analysisResult!.riskScore > 40
                              ? const Color(0xFFC96868)
                              : const Color(0xFFA3B18A),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _analysisResult!.riskScore > 40
                                ? 'Şüpheli Bağlantı! ⚠️'
                                : 'Güvenli Görünüyor 🛡️',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _analysisResult!.riskScore > 40
                                  ? const Color(0xFFC96868)
                                  : const Color(0xFFA3B18A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: Color(0xFFE8E2D5)),
                    _buildResultRow(
                      'SSL Sertifikası (HTTPS)',
                      _analysisResult!.isHttps ? 'Var' : 'Yok (Riskli)',
                      _analysisResult!.isHttps,
                    ),
                    _buildResultRow(
                      'IP Adresi Yönlendirmesi',
                      _analysisResult!.isIpAddress ? 'Tespit Edildi (Tehlike)' : 'Temiz',
                      !_analysisResult!.isIpAddress,
                    ),
                    _buildResultRow(
                      'Kısaltılmış Link',
                      _analysisResult!.isShortenedUrl ? 'Evet (Gizli URL)' : 'Hayır',
                      !_analysisResult!.isShortenedUrl,
                    ),
                    _buildResultRow(
                      'Zararlı Dosya Uzantısı',
                      _analysisResult!.hasSuspiciousExtension ? 'Şüpheli Uzantı!' : 'Yok',
                      !_analysisResult!.hasSuspiciousExtension,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String status, bool isSafe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF8D7B68), fontSize: 13),
          ),
          Text(
            status,
            style: TextStyle(
              color: isSafe ? const Color(0xFFA3B18A) : const Color(0xFFC96868),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}