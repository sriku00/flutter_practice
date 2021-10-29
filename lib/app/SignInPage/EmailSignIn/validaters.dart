abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringvalidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringvalidator();
  final StringValidator passwordValidator = NonEmptyStringvalidator();
  final String passwordValidatorText = "password can't be empty";
  final String emailValidatorText = "email can't be empty";
}
