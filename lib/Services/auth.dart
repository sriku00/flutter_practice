import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/Services/general_firebase_service.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/show_exception_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInAnonymously(BuildContext context);

  Future<User?> signInwithGoogle();
  Future<void> signOUt();
  Future<User?> signInWithEmailWithPassword(String email, String password);
  Future<User?> createUserwithEmailAndPassword(String email, String password);
}

final authServiceProvider = Provider<Auth>((ref) {
  return Auth(ref.read);
});

class Auth implements AuthBase {
  Auth(this._read);

  final Reader _read;

  @override
  User? get currentUser => _read(firebaseAuthProvider).currentUser;
  @override
  Stream<User?> authStateChanges() => _read(firebaseAuthProvider).authStateChanges();
  // signIn anonymously finction

  @override
  Future<User?> signInAnonymously(BuildContext context) async {
    try {
      final UserCredential userCredentials = await _read(firebaseAuthProvider).signInAnonymously();
      return userCredentials.user;
    } on Exception catch (e) {
      showExceptionDialog(context, title: "SignIN Failed", exception: e);
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
            await _read(firebaseAuthProvider).signInWithCredential(GoogleAuthProvider.credential(
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
  Future<void> signOUt() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _read(firebaseAuthProvider).signOut();
  }

  @override
  Future<User?> signInWithEmailWithPassword(email, password) async {
    final UserCredential? userCredential = await _read(firebaseAuthProvider)
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential!.user;
  }

  @override
  Future<User?> createUserwithEmailAndPassword(String email, String password) async {
    final UserCredential? userCredential = await _read(firebaseAuthProvider)
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential!.user;
  }
}
