import 'package:flutter/material.dart';
import 'package:flutter_practice/app/SignInPage/form_submitbutton.dart';

enum EmailSignInType {
  signIn,
  register,
}

class EmailFormPage extends StatefulWidget {
  const EmailFormPage({Key? key}) : super(key: key);

  @override
  State<EmailFormPage> createState() => _EmailFormPageState();
}

class _EmailFormPageState extends State<EmailFormPage> {
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  void _onSubmit() {
    print("email: ${_emailTextController.text} password:${_passwordTextController.text}");
  }

  void _toggle() {
    setState(() {
      _formType =
          _formType == EmailSignInType.signIn ? EmailSignInType.register : EmailSignInType.signIn;
    });
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  EmailSignInType _formType = EmailSignInType.signIn;

  List<Widget> _buildChildren(BuildContext context) {
    final primaryText = _formType == EmailSignInType.signIn ? "Sign IN" : "Create an Account";
    final secondaryText =
        _formType == EmailSignInType.signIn ? "Need an account? Register" : "Sign In";
    return [
      TextField(
        controller: _emailTextController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: "Email", hintText: "abcdd@gmai.com"),
      ),
      TextField(
        controller: _passwordTextController,
        textAlign: TextAlign.center,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "password",
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        color: Colors.indigo,
        onpressed: _onSubmit,
      ),
      TextButton(
        child: Text(
          secondaryText,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        onPressed: _toggle,
      )
    ];
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
}
