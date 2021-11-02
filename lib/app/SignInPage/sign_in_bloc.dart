import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_practice/Services/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInBlocProvider = Provider.autoDispose<SignInBloc>((ref) {
  return SignInBloc(ref.read);
});

class SignInBloc {
  SignInBloc(this._reader);

  final Reader _reader;

  final StreamController<bool?> _isLoadingController =
      StreamController<bool?>.broadcast();

  Stream<bool?> get isLoadingStream => _isLoadingController.stream;
  void dispose() {
    _isLoadingController.close();
  }

  void setIsLoading(bool? isLoading) => _isLoadingController.add(isLoading);

  Future<User?> signInAnonymously() async {
    try {
      setIsLoading(true);
      await _reader(authServiceProvider).signInAnonymously();
    } catch (e) {
      setIsLoading(false);
      rethrow;  
    } 
  }

  Future<User?> signInwithGoogle() async {
    try {
      setIsLoading(true);
      await _reader(authServiceProvider).signInwithGoogle();
    } catch (e) {
      setIsLoading(false);
      rethrow;
    }
  }
}
