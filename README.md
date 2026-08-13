# 🛡️ CyberSafe - Personal Mobile Security & Risk Analyzer

A modern, cross-platform mobile cybersecurity application built with Flutter. CyberSafe helps users evaluate system security configurations, analyze suspicious links for phishing/malware risks, calculate password strengths dynamically, and learn essential digital safety practices. Designed with a custom warm-minimalist aesthetic for an intuitive user experience.

## Key Features

* **System Security Evaluator:** Conducts instant security assessments across device lock settings, biometrics, app permissions, and network status to calculate a real-time safety score.
* **Link & Phishing Scanner:** Analyzes URLs for hidden IP redirects, suspicious executable extensions (.exe, .apk), lack of SSL, and known link shorteners to prevent cyber threats.
* **Dynamic Password Analyzer:** Evaluates password complexity using real-time entropy calculation, providing structural suggestions and leak probability feedback.
* **Interactive Cybersecurity Tips:** Delivers curated, actionable security advice categorized by digital safety domains (Network, Account, Device Security).
* **Warm Ecru/Beige Aesthetic:** Custom luxury-themed warm palette designed for visual clarity, minimal eye strain, and high scannability.

## Technologies Used

* **Framework:** Flutter (3.x) & Dart
* **State Management:** StatefulWidget Architecture
* **UI Components:** Custom Warm-Minimalist Design System, Material Icons
* **Security & Logic:** Custom Regex Engines for Phishing Detection, Password Entropy Calculators
* **Platform:** Cross-Platform (Android & iOS)

## Project Structure

```text
cybersafe/
├── lib/
│   ├── models/                  # Data models
│   │   ├── security_check.dart   # System security check items model
│   │   └── security_tip.dart     # Security tips content model
│   ├── screens/                 # Application view screens
│   │   ├── home_screen.dart      # Main Dashboard & System Security Assessment
│   │   ├── link_scanner_screen.dart # URL/Phishing Scanner Interface
│   │   ├── password_screen.dart  # Dynamic Password Strength Analyzer
│   │   ├── tips_screen.dart      # Cybersecurity Tips & Education Cards
│   │   └── main_wrapper.dart     # Bottom Navigation Wrapper & Tab State
│   ├── services/                # Business logic engines
│   │   └── link_scanner_service.dart # Link Risk Scoring Engine (IP, SSL, Extensions)
│   └── main.dart                # App entry point, Theme Setup & Initialization
├── android/                     # Native Android project configuration
├── ios/                         # Native iOS project configuration
└── pubspec.yaml                 # Dependencies & Asset configurations
