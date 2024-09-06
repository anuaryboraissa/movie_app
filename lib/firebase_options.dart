// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWXLb8If_zJ2ay2MjsGf-SMFFHsvkncvg',
    appId: '1:931179511065:android:6896534be90f90dc539988',
    messagingSenderId: '931179511065',
    projectId: 'movie-app-c029a',
    storageBucket: 'movie-app-c029a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYvL1XsSuDaidCFiTZ04LkuN_3HpnimnI',
    appId: '1:931179511065:ios:d74c9661ed43e3ee539988',
    messagingSenderId: '931179511065',
    projectId: 'movie-app-c029a',
    storageBucket: 'movie-app-c029a.appspot.com',
    androidClientId: '931179511065-48a7ci5hp0p7ljcs123u59idcok244nc.apps.googleusercontent.com',
    iosClientId: '931179511065-3cv553tgd737bdr4m3hojuevukqqm4ai.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieApp',
  );

}