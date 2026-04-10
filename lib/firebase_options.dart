import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// ─────────────────────────────────────────────────────────────────────────────
/// HOW TO CONFIGURE
/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Go to https://console.firebase.google.com and create a project.
/// 2. Inside the project, add apps for each platform (Web, Android, iOS).
/// 3. Copy each app's config values and replace the placeholders below.
/// 4. Enable Firestore Database (Native mode) and Authentication
///    (Email/Password) in the Firebase Console.
/// ─────────────────────────────────────────────────────────────────────────────
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  // ── Web ─────────────────────────────────────────────────────────────────────
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYOfULcm558-goG0OzNCv7Dd0hsou4W70',
    appId: '1:872303369079:web:3f767427afb9cf0d4bdf72',
    messagingSenderId: '872303369079',
    projectId: 'nak-online-shop',
    authDomain: 'nak-online-shop.firebaseapp.com',
    storageBucket: 'nak-online-shop.firebasestorage.app',
    measurementId: 'G-X430EEXXJN',
  );

  // ── Android ─────────────────────────────────────────────────────────────────
  // TODO: In Firebase Console → Add Android app → download google-services.json
  // Then copy the android apiKey and appId from that file.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: '872303369079',
    projectId: 'nak-online-shop',
    storageBucket: 'nak-online-shop.firebasestorage.app',
  );

  // ── iOS ──────────────────────────────────────────────────────────────────────
  // TODO: In Firebase Console → Add iOS app → download GoogleService-Info.plist
  // Then copy the iOS apiKey and appId from that file.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: '872303369079',
    projectId: 'nak-online-shop',
    storageBucket: 'nak-online-shop.firebasestorage.app',
    iosBundleId: 'com.example.nakElectronics',
  );

  // ── macOS ────────────────────────────────────────────────────────────────────
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: '872303369079',
    projectId: 'nak-online-shop',
    storageBucket: 'nak-online-shop.firebasestorage.app',
    iosBundleId: 'com.example.nakElectronics',
  );
}
