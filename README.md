# UniAssist

> An open-source, AI-powered student productivity and campus assistant app—adaptable to any academic environment.  
> All-in-one dashboard for assignments, attendance, notifications, schedules, and more.

![UniAssist Demo](assets/demo.gif)  
<!-- Replace with your actual demo GIF or screenshot -->

## ✨ Features

| Feature               | Description                                                                                             |
|-----------------------|---------------------------------------------------------------------------------------------------------|
| Unified Dashboard     | See all academic updates, notifications, assignments, and schedules in one place.                      |
| Smart Notifications   | AI-powered, priority-sorted alerts ensure you never miss what matters.                                 |
| Attendance Tracker    | Real-time, visual analytics and threshold monitoring tailored to academic policies (e.g., 75% alerts).  |
| Assignment & Calendar | Instantly view, track, and get reminders for deadlines and academic events.                            |
| Customizable Widgets  | Drag-and-drop dashboard: personalize your experience to your needs.                                    |
| Privacy-First         | No data leaves your device without consent. Strong open-source security best practices applied.         |
| 100% Free & Open Source | Built using Flutter, Firebase/Supabase, OpenAI API (free tier), and open standards.                  |
| Platform-Agnostic     | Designed for effortless adaptation to any school, college, or university setup globally.                |

> **Demo Preview:** [UniAssist Live](https://preview.builtwithrocket.new/campus-copilot-7wx0o81)  
>  
> **Source Code:** [https://github.com/Vibhor-choudhary/UniAssist.git](https://github.com/Vibhor-choudhary/UniAssist.git)

## 🚀 Get Started

### Requirements
- Flutter SDK (^3.29.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for iOS development)
- Free Firebase or Supabase account for backend services
- OpenAI API key (optional; free tier supported for AI features)

### Installation Steps

```bash
git clone https://github.com/Vibhor-choudhary/UniAssist.git
cd UniAssist
flutter pub get
```

### Configuration

- Copy `env.json.example` to `env.json` and configure your Firebase/Supabase and OpenAI keys.
- Review database security rules in `/docs/deployment/security.md`.

### Running Locally

```bash
flutter run
```

### Building for Production

```bash
# For Android
flutter build apk --release

# For iOS
flutter build ios --release
```

## 📁 Project Structure

```
UniAssist/
├── android/            # Android-specific configuration
├── ios/                # iOS-specific configuration
├── lib/
│   ├── core/           # Core utilities and services
│   │   └── utils/      # Utility classes
│   ├── presentation/   # UI screens and widgets
│   │   └── splash_screen/ # Splash screen implementation
│   ├── routes/         # Application routing
│   ├── theme/          # Theme configuration
│   ├── widgets/        # Reusable UI components
│   └── main.dart       # Application entry point
├── assets/             # Static assets (images, fonts, etc.)
├── pubspec.yaml        # Project dependencies and configuration
└── README.md           # Project documentation
```

## 📖 Documentation & Architecture

- `/lib/presentation` - App screens like Dashboard, Notifications, Attendance  
- `/lib/widgets` - Reusable UI elements  
- `/lib/core` - API calls, data processing modules  
- `/lib/models` - Data schemas and types  
- `/docs` - Technical guides, architecture overviews, onboarding  

## 💡 Contributing

We welcome all contributors!

- See [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines.
- Check out good first issues [here](https://github.com/Vibhor-choudhary/UniAssist/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22).
- Join discussions and cooperative efforts via [GitHub Discussions](https://github.com/Vibhor-choudhary/UniAssist/discussions).

## 🗺️ Roadmap

- [x] Unified Dashboard  
- [x] Attendance, Assignments, Calendar Widgets  
- [x] AI-powered Notifications  
- [ ] Multi-language Support  
- [ ] Dark Mode & Accessibility    
- [ ] OAuth Login Integration  
- [ ] Peer Study Buddy and Collaboration Features  
- [ ] One-click Deploy/Docker Setup

See [GitHub Projects](https://github.com/Vibhor-choudhary/UniAssist/projects) for the full roadmap.

## 🔎 Feedback & Support

- Report bugs or request features: [GitHub Issues](https://github.com/Vibhor-choudhary/UniAssist/issues)
- General discussion & ideas: [GitHub Discussions](https://github.com/Vibhor-choudhary/UniAssist/discussions)
- Beta testing and user feedback form: [Example Google Form](https://forms.gle/your-form) *(replace with actual form)*

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## 🤝 Acknowledgments

- Thanks to all contributors, open-source technologies, and hackathon mentors.
- Special mentions: Flutter, Firebase, OpenAI, Supabase.

---

