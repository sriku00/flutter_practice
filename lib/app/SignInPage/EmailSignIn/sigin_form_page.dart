import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/form_submitbutton.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/show_exception_dialog.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/validaters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum EmailSignInType {
  signIn,
  register,
}

class EmailFormPage extends StatefulWidget with EmailAndPasswordValidators {
  EmailFormPage({Key? key}) : super(key: key);

  @override
  State<EmailFormPage> createState() => _EmailFormPageState();
}

class _EmailFormPageState extends State<EmailFormPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  // getter for the email and password

  String? get _email => _emailTextController.text;
  String? get _password => _passwordTextController.text;
  EmailSignInType _formType = EmailSignInType.signIn;

  bool? _submitted = false;
  bool? _isLoading = false;

  Future<void> _onSubmit(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInType.signIn) {
        await auth.signInWithEmailWithPassword(_email!, _password!);
      } else {
        await auth.createUserwithEmailAndPassword(_email!, _password!);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionDialog(context, title: "SignIn Failded", exception: e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onEditingEmailComplete() {
    final onFocus = widget.emailValidator.isValid(_email!) ? _focusNodePassword : _focusNodeEmail;
    FocusScope.of(context).requestFocus(onFocus);
  }

//
  void _toggle() {
    setState(() {
      _submitted = false;
      _formType =
          _formType == EmailSignInType.signIn ? EmailSignInType.register : EmailSignInType.signIn;
    });
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  List<Widget> _buildChildren(BuildContext context) {
    final primaryText = _formType == EmailSignInType.signIn ? "Sign IN" : "Create an Account";
    final secondaryText =
        _formType == EmailSignInType.signIn ? "Need an account? Register" : "Sign In";

    bool submitEnabled = widget.emailValidator.isValid(_email!) &&
        widget.passwordValidator.isValid(_password!) &&
        !_isLoading!;
    return [
      _buildEmailField(),
      _buildPasswordField(),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        color: submitEnabled ? Colors.indigo : Colors.grey,
        onpressed: submitEnabled ? () => _onSubmit(context) : null,
      ),
      TextButton(
        child: Text(
          secondaryText,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        onPressed: !_isLoading! ? _toggle : null,
      )
    ];
  }

  TextField _buildPasswordField() {
    bool showErrorText = _submitted! && (!widget.passwordValidator.isValid(_password!));
    return TextField(
      onChanged: (password) => upDateField(),
      focusNode: _focusNodePassword,
      controller: _passwordTextController,
      textAlign: TextAlign.center,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "password",
        errorText: showErrorText ? widget.passwordValidatorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _onSubmit(context),
    );
  }

  TextField _buildEmailField() {
    bool showErrorText = _submitted! && !widget.emailValidator.isValid(_email!);
    return TextField(
      onChanged: (email) => upDateField(),
      focusNode: _focusNodeEmail,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      controller: _emailTextController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "abcdd@gmai.com",
        errorText: showErrorText ? widget.emailValidatorText : null,
        enabled: _isLoading == false,
      ),
      onEditingComplete: _onEditingEmailComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(context),
      ),
    );
  }

  upDateField() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }
}
