import 'package:flutter_practice/app/SignInPage/EmailSignIn/validaters.dart';

enum EmailSignInType {
  signIn,
  register,
}

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.formType = EmailSignInType.signIn,
      this.email = "",
      this.isLoading = false,
      this.isSubmitted = false,
      this.password = ""});
  final String email;
  final String password;
  final bool? isLoading;
  final bool? isSubmitted;
  final EmailSignInType? formType;

  EmailSignInModel copyWith(
      {String? email,
      String? password,
      bool? isLoading,
      bool? isSubmitted,
      EmailSignInType? formType}) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      formType: formType ?? this.formType,
    );
  }

  String? get primaryButtonText {
    return formType == EmailSignInType.signIn ? "Sign IN" : "Create an Account";
  }

  String? get secondaryButtonText {
    return formType == EmailSignInType.signIn
        ? "don't have account? register"
        : "Already have an account? SignIn";
  }

  bool? get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        isLoading!;
  }

  String? get passwordErrorText {
    bool showErrorText = canSubmit! && (passwordValidator.isValid(password));
    return showErrorText ? passwordValidatorText : null;
  }

  String? get emailErrorText {
    bool showErrorText = canSubmit! && (emailValidator.isValid(email));
    return showErrorText ? emailValidatorText : null;
  }
}
