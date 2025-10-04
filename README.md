
# 🧾 Customer Portal App

A modern Flutter application for managing customer accounts, viewing transactions, and tracking interactions efficiently.

## ✨ Features

- 👤 **User Authentication** - Secure login and signup system
- 📊 **Dashboard** - Overview of accounts and financial information
- 💰 **Payment Management** - Track installment plans and payment logs
- 🧾 **Invoice Management** - View and manage customer invoices
- 👥 **Customer Registration** - Register new customers with detailed information
- 🌐 **Multi-language Support** - Support for multiple languages
- ⚙️ **App Settings** - Customizable application settings
- 🔔 **Notifications** - Stay updated with important alerts
- 📱 **Responsive Design** - Works seamlessly on mobile and tablet devices

## 📸 Screenshots

### Authentication & Dashboard
| Login Screen | Signup Screen | Dashboard |
|--------------|---------------|-----------|
| <img src="https://github.com/user-attachments/assets/1ead88cd-688e-4690-b1b6-f37eaa21807f" width="200"> | <img src="https://github.com/user-attachments/assets/4805d223-6894-4a80-abbf-d414ec3d4bab" width="200"> | <img src="https://github.com/user-attachments/assets/36fb2e18-5f72-4d17-ac2f-9bf2fd0c5154" width="200"> |

### Customer Management
| Customer Registration | Installment Plans | Payment Logs |
|----------------------|-------------------|--------------|
| <img src="https://github.com/user-attachments/assets/2e9815e1-4b20-4f4e-963e-925e8f6fcb07" width="200"> | <img src="https://github.com/user-attachments/assets/4cc3745f-c52a-477e-8789-19151254170c" width="200"> | <img src="https://github.com/user-attachments/assets/7ef37155-ffbc-4e51-aa5e-5b19dbc0dc35" width="200"> |

### Profile & Settings
| Profile Screen | Notifications | App Settings |
|----------------|---------------|--------------|
| <img src="https://github.com/user-attachments/assets/d7311bf5-3436-4015-bad4-f02446c65046" width="200"> | <img src="https://github.com/user-attachments/assets/09937211-70f6-4512-ad16-36394b4f8a9b" width="200"> | <img src="https://github.com/user-attachments/assets/4102a8ab-4710-43c3-bdc4-677461284120" width="200"> |

## 🛠️ Technical Features

- **Flutter Framework** - Cross-platform mobile development
- **Firebase Integration** - Backend services and authentication
- **Provider State Management** - Efficient state management
- **Localization** - Multi-language support
- **Material Design** - Modern UI/UX components
- **Device Preview** - Development and testing tools

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── pages/                   # Main application screens
│   ├── login.page.dart
│   ├── signup.page.dart
│   ├── dashboard.dart
│   ├── customer_registration_screen.dart
│   ├── installment_plan_screen.dart
│   ├── payment_log_screen.dart
│   └── invoice_list_screen.dart
├── screens/                 # Additional feature screens
│   ├── profile_screen.dart
│   ├── edit_profile_screen.dart
│   ├── notifications_screen.dart
│   ├── app_settings_screen.dart
│   ├── customer_support_screen.dart
│   ├── rate_us_screen.dart
│   ├── terms_conditions_screen.dart
│   └── language_screen.dart
├── providers/              # State management
│   └── language_provider.dart
└── generated/             # Auto-generated files
    └── l10n/             # Localization files
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- Android Studio/VSCode
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/customer-portal.git
   cd customer-portal
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the respective directories

4. **Run the application**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Firebase Setup
1. Enable Authentication (Email/Password)
2. Set up Firestore Database
3. Configure Storage (if needed for files)

### Localization
The app supports multiple languages. To add new languages:
1. Update the `arb` files in `lib/l10n`
2. Run `flutter gen-l10n` to generate new localization files

## 📱 Build Releases

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

We welcome contributions! Please feel free to submit pull requests, report bugs, or suggest new features.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 👨‍💻 Author

### Muhammad Husnain Shahid

<p align="left">
  <a href="https://github.com/muhammadhusnainshahid">
    <img src="https://img.shields.io/badge/GitHub-Follow-blue?logo=github" alt="GitHub Follow"/>
  </a>
  <a href="https://www.instagram.com/the.husnainshahid">
    <img src="https://img.shields.io/badge/Instagram-Follow-e4405f?logo=instagram" alt="Instagram"/>
  </a>
  <a href="https://www.linkedin.com/in/muhammad-husnain-shahid-36b34b26b">
    <img src="https://img.shields.io/badge/LinkedIn-Connect-0077B5?logo=linkedin" alt="LinkedIn"/>
  </a>
</p>

If you liked this project, consider giving it a ⭐ and sharing it with others.

## ☕ Support My Work

If this project helped you, you can support me to keep building more open-source Flutter projects:

<p align="left">
  <a href="https://www.buymeacoffee.com/muhammadhusnainshahid" target="_blank">
    <img src="https://img.shields.io/badge/BuyMeACoffee-Support-FFDD00?logo=buymeacoffee" alt="Buy Me a Coffee"/>
  </a>
</p>

---

<div align="center">
  
**⭐ Don't forget to star this repository if you find it helpful! ⭐**

</div>
```

## Key Improvements Made:

1. **Organized Screenshots** - Grouped them logically by feature category
2. **Proper Formatting** - Used markdown tables for better organization
3. **Descriptive Labels** - Added clear titles for each screenshot group
4. **Technical Details** - Added project structure and technical features
5. **Installation Guide** - Comprehensive setup instructions
6. **Better Structure** - Clear sections with proper headings
7. **Professional Layout** - Clean and professional appearance
