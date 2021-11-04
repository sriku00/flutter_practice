import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/email_sign_in_bloc.dart';
import 'package:flutter_practice/app/Models/email_sign_in_model.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/form_submitbutton.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/show_exception_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailSignInBlocForm extends StatefulHookWidget {
  const EmailSignInBlocForm({Key? key}) : super(key: key);

  @override
  State<EmailSignInBlocForm> createState() => _EmailSignInBlocFormState();
}

class _EmailSignInBlocFormState extends State<EmailSignInBlocForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  // getter for the email and password

  Future<void> _onSubmit(BuildContext context) async {
    final auth = context.read(emailSignInBlocProvider);

    try {
      await auth.onSubmit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionDialog(context, title: "SignIn Failded", exception: e);
    }
  }

  void _onEditingEmailComplete(EmailSignInModel? model) {
    final onFocus = model!.emailValidator.isValid(model.email)
        ? _focusNodePassword
        : _focusNodeEmail;
    FocusScope.of(context).requestFocus(onFocus);
  }

//
  void _toggle() {
    final bloc = context.read(emailSignInBlocProvider);
    bloc.toggle();
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  List<Widget> _buildChildren(BuildContext context, EmailSignInModel? model) {
    return [
      _buildEmailField(model),
      _buildPasswordField(model),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: model!.primaryButtonText,
        color: model.canSubmit! ? Colors.indigo : Colors.grey,
        onpressed: model.canSubmit! ? () => _onSubmit(context) : null,
      ),
      TextButton(
        child: Text(
          model.secondaryButtonText!,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        onPressed: !model.isLoading! ? _toggle : null,
      )
    ];
  }

  TextField _buildPasswordField(EmailSignInModel? model) {
    final bloc = context.read(emailSignInBlocProvider);

    return TextField(
      onChanged: bloc.updatePassword,
      focusNode: _focusNodePassword,
      controller: _passwordTextController,
      textAlign: TextAlign.center,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "password",
        errorText: model!.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _onSubmit(context),
    );
  }

  TextField _buildEmailField(EmailSignInModel? model) {
    final bloc = context.read(emailSignInBlocProvider);
    
    return TextField(
      onChanged: bloc.updateEmail,
      focusNode: _focusNodeEmail,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      controller: _emailTextController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "abcdd@gmai.com",
        errorText: model!.emailErrorText,
        enabled: model.isLoading == false,
      ),
      onEditingComplete: () => _onEditingEmailComplete(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useProvider(emailSignInBlocProvider);

    return StreamBuilder<EmailSignInModel?>(
        initialData: EmailSignInModel(),
        stream: bloc.modelStream,
        builder: (context, snapshot) {
          final EmailSignInModel? _model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(context, _model),
            ),
          );
        });
  }
}
