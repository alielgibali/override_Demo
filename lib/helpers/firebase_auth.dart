import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<AuthResult> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    return _auth.signInWithCredential(credential);
  }

  static Future<AuthResult> singInWithFacebook() async {
    final facebookLogIn = FacebookLogin();
    var result = await facebookLogIn.logIn(["id"]);
    print(result.accessToken);

    if (result.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken myToken = result.accessToken;
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: myToken.token);

      return _auth.signInWithCredential(credential);
    }
  }
}
