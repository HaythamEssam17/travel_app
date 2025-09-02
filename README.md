# Travel App (Flutter) — Build & Deployment

## Overview
This repo implements a Flutter travel app with Flights & Hotels search, booking flow, offline caching (Hive), JWT auth, and role-based routing.

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
```bash
dart tools/fix_run.dart haitham

3. **Run app (staging)**
```bash
flutter run --flavor staging -t lib/main.dart --dart-define=API_URL=https://staging.api/ --dart-define=FLAVOR=staging

