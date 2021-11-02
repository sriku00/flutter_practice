import 'dart:async';
import 'package:flutter_practice/Services/auth.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/email_sign_in_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailSignInBlocProvider = Provider.autoDispose<EmailSignInBloc>((ref) {
  return EmailSignInBloc(ref.read);
});

class EmailSignInBloc {
  EmailSignInBloc(this._reader);

  final Reader _reader;
  EmailSignInModel _emailSignInModel = const EmailSignInModel();
  final StreamController<EmailSignInModel?> _emailStreamCotroller =
      StreamController<EmailSignInModel?>.broadcast();

  Stream<EmailSignInModel?> get modelStream => _emailStreamCotroller.stream;

  void dispose() {
    _emailStreamCotroller.close();
  }

  Future<void> onSubmit() async {
    final auth = _reader(authServiceProvider);
    updateWith(isLoading: true, isSubmitted: true);
    try {
      if (_emailSignInModel.formType == EmailSignInType.signIn) {
        await auth.signInWithEmailWithPassword(
            _emailSignInModel.email, _emailSignInModel.password);
      } else {
        await auth.createUserwithEmailAndPassword(
            _emailSignInModel.email, _emailSignInModel.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith(
      {String? email,
      String? password,
      bool? isLoading,
      bool? isSubmitted,
      EmailSignInType? formType}) {
    _emailSignInModel = _emailSignInModel.copyWith(
      email: email,
      password: password,
      isLoading: isLoading,
      isSubmitted: isSubmitted,
      formType: formType,
    );
    _emailStreamCotroller.add(_emailSignInModel);
  }
}
