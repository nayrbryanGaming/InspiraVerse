import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for the InspiraVerse platform.
/// 
/// These configurations are automatically generated and utilized by the 
/// InspiraVerse engine to facilitate cloud-syncing and daily quote delivery.
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSy_MOCK_API_KEY_FOR_COMPILATION',
    appId: '1:1234567890:web:mock',
    messagingSenderId: '1234567890',
    projectId: 'inspiraverse-mock',
    authDomain: 'inspiraverse-mock.firebaseapp.com',
    storageBucket: 'inspiraverse-mock.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSy_MOCK_API_KEY_FOR_COMPILATION',
    appId: '1:1234567890:android:mock',
    messagingSenderId: '1234567890',
    projectId: 'inspiraverse-mock',
    storageBucket: 'inspiraverse-mock.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSy_MOCK_API_KEY_FOR_COMPILATION',
    appId: '1:1234567890:ios:mock',
    messagingSenderId: '1234567890',
    projectId: 'inspiraverse-mock',
    storageBucket: 'inspiraverse-mock.appspot.com',
    iosBundleId: 'com.nayrbryan.inspiraverse',
  );
}
