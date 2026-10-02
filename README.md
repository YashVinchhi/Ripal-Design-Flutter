<div align="center">

  <img src="assets/logo/Logo.png" alt="Ripal Design Logo" width="120" height="120" />

  # 🏛️ Ripal Design App

  **A comprehensive, multi-role Flutter application for design agency operations, project tracking, financial invoicing, and client collaboration.**

  [![Flutter](https://img.shields.io/badge/Flutter-^3.11.5-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge)](https://flutter.dev)
  [![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

</div>

---

## 📖 Overview

**Ripal Design** is an all-in-one Enterprise Resource Planning (ERP) and Project Management solution tailored for design studios, architecture firms, and creative agencies. Built using **Flutter**, it delivers a seamless cross-platform experience across mobile and web platforms.

The application serves three distinct user roles—**Admins**, **Workers/Employees**, and **Clients**—providing dedicated workflows for project monitoring, document sharing, team management, leave requests, and automated PDF invoice generation.

---

## ✨ Key Features

### 👑 Admin Workspace
- 📊 **Dashboard Analytics**: Real-time overview of active projects, financial summary, and team status.
- 💼 **Financial & Invoice Engine**: Create customized invoices, preview PDF documents, track payments, and export/print invoices effortlessly.
- 📁 **Project Management**: Create, assign, update, and manage project milestones, deadlines, and asset repositories.
- 👥 **Team & User Management**: Manage employee roles, permissions, activities, and contact rosters.
- 📅 **Leave Approval System**: Review, approve, or reject employee leave requests with detailed history logs.
- 📤 **Document Management**: Upload and organize project blueprints, design assets, and legal documents.

### 👷 Worker / Employee Portal
- 📋 **Project Tasks & Views**: Access assigned projects, specifications, and client feedback in real time.
- 📂 **Asset Submission**: Upload design drafts, revisions, and site progress files directly to project threads.
- 📝 **Leave Requests**: Submit leave applications and view real-time status and historical records.
- 👥 **Team Directory**: View team members, roles, and project allocations.
- 🔒 **Profile & Security**: Manage individual profiles and update security passwords securely.

### 🎨 Client Hub
- 🔍 **Project Progress View**: Track project milestones, design updates, and completion timelines transparently.
- 📞 **Client Support & Inquiries**: Direct contact channels and project application forms for new requests.
- 🖼️ **Portfolio Gallery**: Explore completed studio projects and design showcases.

---

## 🛠️ Tech Stack & Packages

| Package / Technology | Version | Purpose |
| :--- | :--- | :--- |
| **[Flutter SDK](https://flutter.dev)** | `^3.11.5` | Cross-platform UI toolkit |
| **[pdf](https://pub.dev/packages/pdf)** | `^3.11.1` | Programmatic PDF creation & invoice formatting |
| **[printing](https://pub.dev/packages/printing)** | `^5.13.2` | Native PDF previewing, printing, and sharing |
| **[file_picker](https://pub.dev/packages/file_picker)** | `^8.1.7` | Native file selection for document uploads |
| **[image_picker](https://pub.dev/packages/image_picker)** | `^1.1.2` | Camera & gallery image acquisition |
| **[shared_preferences](https://pub.dev/packages/shared_preferences)** | `^2.5.5` | Persistent key-value storage for settings & sessions |
| **[flutter_native_splash](https://pub.dev/packages/flutter_native_splash)** | `^2.4.4` | Custom branded splash screen |
| **[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)** | `^0.13.1` | Native application icon generator |

---

## 📂 Directory Structure

```gcode
lib/
├── main.dart                      # App entry point & theme initialization
├── resource/                      # Reusable UI components & custom widgets
│   ├── checkered_placeholder.dart
│   ├── contact_info_row.dart
│   ├── custom_bottom_nav_bar.dart
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── main_scaffold.dart
│   ├── portfolio_card.dart
│   ├── project_card.dart
│   └── ...
└── screen/                        # Feature screens grouped by role
    ├── admin_activity_screen.dart
    ├── admin_create_invoice_screen.dart
    ├── admin_create_project.dart
    ├── admin_finance_screen.dart
    ├── admin_invoice_screen.dart
    ├── admin_team_screen.dart
    ├── client_project_view.dart
    ├── dashboard_screen.dart
    ├── invoice_pdf_preview_screen.dart
    ├── login_screen.dart
    ├── worker_leave_request_screen.dart
    ├── worker_project_files_screen.dart
    └── ...
```

---

## 🚀 Getting Started

### Prerequisites

Before starting, ensure you have the following installed on your system:
- **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (`v3.11.5` or higher)
- **[Dart SDK](https://dart.dev/get-dart)**
- **Android Studio** / **VS Code** with Flutter extension
- An active emulator or physical device (Android / iOS / Web)

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/YashVinchhi/Ripal-Design-Flutter.git
   cd Ripal-Design-Flutter
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**:
   ```bash
   flutter doctor
   ```

4. **Run the application**:
   ```bash
   # Run on connected device
   flutter run

   # Or specify target platform
   flutter run -d chrome
   ```

---

## 📦 Building for Production

### Android APK / App Bundle
```bash
# Build release APK
flutter build apk --release

# Build Android App Bundle (AAB)
flutter build appbundle --release
```

### Web Release
```bash
flutter build web --release
```

---

## 🎨 Branding & Customization

### Native App Launcher Icons
To update app icons across devices, configure `flutter_launcher_icons` in `pubspec.yaml` and execute:
```bash
dart run flutter_launcher_icons
```

### Native Splash Screen
To customize the branded splash screen (`#FCE6E6` theme), execute:
```bash
dart run flutter_native_splash:create
```

---

## 📄 License

This project is proprietary software developed for **Ripal Design**. All rights reserved.

---

<div align="center">
  <sub>Built with ❤️ using Flutter by <b>Yash Vinchhi</b></sub>
</div>

