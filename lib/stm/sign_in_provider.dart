import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/google_sign_in.dart';

class SignInProvider with ChangeNotifier {
  Map<String, dynamic>? _user;
  bool _signInAttempt = false;

  Map<String, dynamic>? get user => _user;
  bool get signInAttempt => _signInAttempt;

  void signIn() async {
    _signInAttempt = true;
    User? user = await GoogleSignInProvider().signInWithGoogle();
    debugPrint("User attempted: $user");
    if (user != null) {
      _user = {"user": user, "success": true};
    } else {
      _user = {"user": null, "success": false};
    }
    _signInAttempt = false;
    notifyListeners();
  }

  signOut() async {
    await GoogleSignInProvider().signOut();
  }
}
