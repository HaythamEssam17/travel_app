✈️ Travel Booking App
📖 Overview

A Flutter-based travel booking application that supports flights and hotels with:

Local caching

Smooth booking flow

Real-time updates

Flavor-based builds (staging & production)

🚀 Features

🔐 Authentication (Login / Logout)

🏨 Hotel & Flight search with pagination

💾 Local caching using Hive

📅 Booking flow (select → details → confirm)

🔔 Real-time booking status updates (WebSocket simulation)

🎨 Beautiful responsive UI (Material + Cupertino)

⚡ Optimized for performance on low-end devices

✅ Unit, Widget, and Integration Tests

🏗️ Flavor-based builds (Staging & Production)

🛠️ Tech Stack

Flutter (3.x)

State Management: GetX / BLoC

Hive (local caching)

GoRouter (navigation)

Mockito / Mocktail (testing)

CI/CD ready

📂 Project Structure
lib/
 ┣ features/
 ┃ ┣ auth/...        → Authentication
 ┃ ┣ search/...      → Search (onion architecture)
 ┃ ┣ booking/...     → Booking flow
 ┣ app_config.dart   → Environment config (via --dart-define)
 ┣ main_staging.dart → Entry point for staging
 ┣ main_production.dart → Entry point for production

⚙️ Setup & Installation
1. Clone the repo
git clone https://github.com/HaythamEssam17/travel_app.git
cd your-repo

2. Install dependencies
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

3. Run the app (staging / production)
Staging
flutter run --flavor staging -t lib/main_staging.dart \
  --dart-define=API_URL=https://staging.api/ \
  --dart-define=FLAVOR=staging

Production
flutter run --flavor production -t lib/main_production.dart \
  --dart-define=API_URL=https://production.api/ \
  --dart-define=FLAVOR=production

🔗 API Endpoints

POST /login → Authenticate user

GET /hotels?page={n} → Paginated hotels list

GET /flights?page={n} → Paginated flights list

POST /bookings → Create booking

WS /booking-status/{id} → Booking status updates (simulated)

🧪 Testing

Run all tests:

flutter test


Run integration tests:

flutter drive --target=test_driver/app.dart

🛠️ Local Development Notes

Prerequisites:

Flutter SDK (stable)

Android SDK / Xcode (for iOS)

Before running the app:

dart tools/fix_run.dart haitham

📦 Build Release (APK / IPA)
Android (APK)
flutter build apk --flavor production -t lib/main_production.dart

iOS (IPA)
flutter build ipa --flavor production -t lib/main_production.dart

✅ Production Readiness

Supports staging & production flavors

Build-ready for Android APK and iOS IPA

Clear documentation for setup, testing, and deployment

CI/CD ready for pipelines
