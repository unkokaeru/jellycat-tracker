# Jellycat Collection Tracker

A Flutter mobile application for tracking your Jellycat plushie collection. Built with Clean Architecture principles, Riverpod state management, and offline-first SQLite storage.

## Features

✨ **Comprehensive Catalog** - Browse 900+ Jellycat releases across all collections
🎯 **Collection Tracking** - Mark owned items and track your collection progress
❤️ **Wishlist Management** - Create and manage your wishlist of desired Jellycats
💰 **Value Estimation** - Calculate the total value of your collection and wishlist
🎨 **Jellycat Branding** - Beautiful UI with authentic Jellycat colors and design
📱 **Offline-First** - Full functionality without internet connection
🔍 **Smart Filtering** - Filter by collection (Bashful, Amuseables, Cordy Roy, etc.)

## Architecture

This app follows **Clean Architecture** principles with three main layers:

- **Presentation Layer**: UI components, pages, widgets, and Riverpod providers
- **Domain Layer**: Business logic, entities, and repository interfaces
- **Data Layer**: Data sources, models, and repository implementations

### Tech Stack

- **Flutter** - Cross-platform mobile framework
- **Riverpod 2.5** - Type-safe state management
- **SQLite** - Local database for offline storage
- **Freezed** - Immutable models and unions
- **Material Design 3** - Modern UI components

## Project Structure

```
lib/
├── core/                      # Core utilities, constants, theme
├── features/                  # Feature modules
│   ├── catalog/              # Browse Jellycats
│   ├── collection/           # User collection tracking
│   └── wishlist/             # Wishlist management
├── services/                  # Platform services (database, etc.)
├── shared/                    # Shared widgets and providers
└── main.dart                 # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (3.4.0 or higher)
- Dart SDK (3.4.0 or higher)
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
```bash
git clone https://github.com/unkokaeru/jellycat-tracker.git
cd jellycat-tracker/jellycat_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run code generation for Freezed and JSON serialization:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## Sample Data

The app comes pre-loaded with sample Jellycat data including:
- Bashful Bunny
- Bashful Black & Cream Puppy  
- Amuseable Avocado
- Amuseable Strawberry
- Cordy Roy Lion
- Bashful Dino
- Fuddlewuddle Bear
- Bashful Lamb

## Development

### Running Tests

```bash
flutter test
```

### Code Generation

When you make changes to Freezed models or JSON serialization:

```bash
flutter pub run build_runner watch
```

### Linting

```bash
flutter analyze
```

## Database Schema

The app uses SQLite with the following main tables:
- `jellycats` - Catalog of all Jellycat items
- `user_collection` - User's owned Jellycats
- `wishlist` - User's wishlist items
- `collections` - Collection groupings (Bashful, Amuseables, etc.)

## Future Enhancements

- 🌐 Cloud sync with Firebase Firestore
- 🤝 Social features - share collections with friends
- 📊 Market data - real-time secondary market prices
- 📷 OCR recognition - photograph Jellycat to identify and add
- 🔔 Notifications - alerts when wishlist items restock
- 🔍 Duplicate detection - find variants you already own

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Acknowledgments

- Jellycat® is a registered trademark of Jellycat Ltd.
- This is an unofficial fan-made application
- All Jellycat designs and characters are property of Jellycat Ltd.

---

Made with ❤️ for Jellycat collectors
