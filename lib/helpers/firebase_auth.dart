import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  static final _auth = FirebaseAuth.instance;
  static Future<AuthResult> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResult> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
