import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/password_service.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State {
  final PasswordService _passwordService = PasswordService();
  final TextEditingController _controller = TextEditingController();
  double _strength = 0.0;

  void _onPasswordChanged(String value) {
    setState(() {
      _strength = _passwordService.calculatePasswordStrength(value);
    });
  }

  void _generatePassword() {
    final newPassword = _passwordService.generateStrongPassword();
    _controller.text = newPassword;
    _onPasswordChanged(newPassword);
  }

  Color _getStrengthColor() {
    if (_strength < 0.4) return const Color(0xFFC96868); // Zayıf - Red
    if (_strength < 0.75) return const Color(0xFFE0A96D); // Orta - Amber
    return const Color(0xFFA3B18A); // Güçlü - Green
  }

  String _getStrengthText() {
    if (_controller.text.isEmpty) return 'Parolanızı girin veya oluşturun';
    if (_strength < 0.4) return 'Zayıf Parola ⚠️';
    if (_strength < 0.75) return 'Orta Düzey Parola 🔒';
    return 'Çok Güçlü Parola 🛡️';
  }

  @override
  Widget build(BuildContext context) {
    final strengthColor = _getStrengthColor();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        title: const Text(
          'Parola Analiz & Oluşturucu 🔑',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6F5E53)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parola Giriş Kartı
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    onChanged: _onPasswordChanged,
                    style: const TextStyle(
                      color: Color(0xFF6F5E53),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Parola yazın veya üretin...',
                      hintStyle: const TextStyle(color: Color(0xFFC2B8A3)),
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
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.copy_rounded, color: Color(0xFF8D7B68)),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            Clipboard.setData(ClipboardData(text: _controller.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Parola kopyalandı! 📋'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Color(0xFF6F5E53),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Güç Göstergesi Barı
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _strength,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFF3EFE6),
                      color: strengthColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getStrengthText(),
                    style: TextStyle(
                      color: strengthColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Parola Üret Butonu
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F5E53),
                  foregroundColor: const Color(0xFFFDFBF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: _generatePassword,
                icon: const Icon(Icons.autorenew_rounded),
                label: const Text(
                  'Güçlü Parola Üret',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}