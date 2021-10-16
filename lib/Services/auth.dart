import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInAnonymously();
  Future<void> signOutAnonymously();
  Future<User?> signInwithGoogle();
  Future<void> signOUtGoogle();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  User? get currentUser => _firebaseAuth.currentUser;
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  // signIn anonymously finction

  @override
  Future<User?> signInAnonymously() async {
    try {
      final UserCredential userCredentials = await _firebaseAuth.signInAnonymously();
      return userCredentials.user;
    } catch (e) {
      print(e.toString());
    }
  }

  //SignOut functoini

  @override
  Future<void> signOutAnonymously() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Google signiN function
  @override
  Future<User?> signInwithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final UserCredential? userCredential =
            await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential!.user;
      } else {
        throw FirebaseAuthException(
            code: "ERROR_MISSING_GOOGLE_IDTOKEN", message: "Missing gooogle Id Token");
      }
    } else {
      throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER", message: "SignIn aborted by user");
    }
  }

  @override
  Future<void> signOUtGoogle() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}