# ✈️ Travel Booking App

## Overview
A Flutter-based travel booking application supporting flights and hotels with caching, booking flow, and real-time updates.

---

## 🚀 Features
- 🔐 Authentication (login/logout)
- 🏨 Hotel & Flight search with pagination
- 💾 Local caching using Hive
- 📅 Booking flow (select → details → confirm)
- 🔔 Real-time booking status updates (WebSocket simulation)
- 🎨 Beautiful responsive UI (Material + Cupertino)
- ⚡ Optimized for performance on low-end devices
- ✅ Unit, Widget, and Integration Tests
- 🏗️ Flavor-based builds (staging & production)

---

## 🛠️ Tech Stack
- **Flutter** (3.x)
- **State Management**: GetX / BLoC (depending on your implementation)
- **Hive** (local caching)
- **GoRouter** (navigation)
- **Mockito/Mocktail** (testing)
- **CI/CD ready**

---

## 📦 Setup
1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo

---

## Project structure
- `lib/features/search/...` — Search (onion architecture)
- `lib/features/booking/...` — Booking flow
- `lib/features/auth/...` — Authentication
- `lib/app_config.dart` — environment config (via `--dart-define`)

---

## Local setup

1. **Prerequisites**
   - Flutter SDK (stable)
   - Android SDK / Xcode (for iOS)
   - `flutter pub get`

2. **Before running the app**
   `dart tools/fix_run.dart haitham`

4. **Run app (staging)**
```bash
flutter run --flavor staging -t lib/main.dart --dart-define=API_URL=https://staging.api/ --dart-define=FLAVOR=staging

