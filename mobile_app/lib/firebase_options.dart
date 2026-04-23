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
    apiKey: 'REPLACE_WITH_PRODUCTION_WEB_API_KEY',
    appId: '1:XXXXXXXXXXXX:web:XXXXXXXXXXXXXXXXXXXXXX',
    messagingSenderId: 'XXXXXXXXXXXX',
    projectId: 'inspiraverse-production',
    authDomain: 'inspiraverse-production.firebaseapp.com',
    storageBucket: 'inspiraverse-production.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_PRODUCTION_ANDROID_API_KEY',
    appId: '1:XXXXXXXXXXXX:android:XXXXXXXXXXXXXXXXXXXXXX',
    messagingSenderId: 'XXXXXXXXXXXX',
    projectId: 'inspiraverse-production',
    storageBucket: 'inspiraverse-production.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_PRODUCTION_IOS_API_KEY',
    appId: '1:XXXXXXXXXXXX:ios:XXXXXXXXXXXXXXXXXXXXXX',
    messagingSenderId: 'XXXXXXXXXXXX',
    projectId: 'inspiraverse-production',
    storageBucket: 'inspiraverse-production.appspot.com',
    iosBundleId: 'com.nayrbryan.inspiraverse',
  );
}
