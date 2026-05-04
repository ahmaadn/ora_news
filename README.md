# Ora News

![Ora News Cover](./assets/cover/ora-news-cover.png)

Ora News is a modern mobile news application built with Flutter. It provides a seamless experience for users to stay updated with the latest news, search for specific topics, and even contribute by managing their own news articles.

## 🚀 Features

- **Authentication System**: Secure user registration, login, and password recovery.
- **Dynamic News Feed**:
    - **Headline Carousel**: Featured news displayed in an interactive slider.
    - **Trending News**: Stay informed with what's popular.
    - **Highlights**: A curated list of important stories.
- **Search & Discovery**: Easily find news articles based on keywords and categories.
- **News Management (User Contributions)**:
    - Create new news articles.
    - Update existing content.
    - Delete personal news entries.
- **Profile Management**: Customize user details and manage personal news archives.
- **Responsive Design**: Polished UI with custom typography, spacing, and theming.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://docs.flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: [HTTP](https://pub.dev/packages/http)
- **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **UI Components**: Carousel Slider, Cached Network Image, Image Picker.

## 📂 Project Structure

```text
lib/
├── app/
│   ├── config/       # Theming, routing, and spacing definitions
│   ├── constants/    # API endpoints and route names
│   └── utils/        # Formatters, validators, and notification helpers
├── data/
│   ├── api/          # Service classes for network requests
│   ├── models/       # Data models for Auth, News, and User
│   └── provider/     # State management logic
└── views/
    ├── features/     # Feature-specific pages and widgets
    └── widgets/      # Reusable global UI components
```

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE (VS Code, Android Studio) with Flutter/Dart plugins.

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahmaadn/ora_news
   cd ora_news
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 🌐 Backend & API

This frontend application requires a backend service to function fully. You can find the source code and setup instructions for the backend API here:

- **Backend Repository**: [ora-news-backend](https://github.com/ahmaadn/ora-news-backend)

Within this Flutter project, the API configuration and endpoints can be found and modified in `lib/app/constants/api_constants.dart`.

## 📄 License

See [LICENSE](LICENSE) for more information.