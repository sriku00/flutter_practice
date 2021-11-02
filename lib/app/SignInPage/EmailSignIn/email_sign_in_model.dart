enum EmailSignInType {
  signIn,
  register,
}

class EmailSignInModel {
  const EmailSignInModel(
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
}
