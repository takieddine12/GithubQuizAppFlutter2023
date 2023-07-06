
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthManager {
  late final GoogleSignIn _googleSignIn;

  AuthManager(this._googleSignIn);

  Future signInWithGoogle() async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Get the authentication details
        Get.offNamed('/home',arguments: [googleUser.email,googleUser.displayName,googleUser.photoUrl]);
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
  GoogleSignInAccount? get googleAccount {
    return _googleSignIn.currentUser;
  }

}