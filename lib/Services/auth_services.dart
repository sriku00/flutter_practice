import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;
  Future<User?> signInAnonymously();
  Future<void> signOutAnonymously();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  User? get currentUser => _firebaseAuth.currentUser;

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
}
