import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/email_sigin_page.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/show_exception_dialog.dart';
import 'package:flutter_practice/app/SignInPage/sign_in_button.dart';
import 'package:flutter_practice/app/SignInPage/social_signin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool? isLoading = false;

  void _showException(BuildContext context, Exception exception) {
    showExceptionDialog(
      context,
      title: "SignIN Failed",
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    try {
      setState(() => isLoading = true);
      await auth.signInAnonymously(context);
    } on Exception catch (e) {
      _showException(context, e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signINwithGoogle(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    try {
      setState(() => isLoading = true);
      await auth.signInwithGoogle();
    } on Exception catch (e) {
      _showException(context, e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => const EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignIn'),
        elevation: 3,
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50, child: _buildIndicator()),
          const SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            text: "SignIn With google",
            onPressed: () => isLoading! ? null : _signINwithGoogle(context),
            color: isLoading! ? Colors.grey : Colors.green,
            height: 50,
            assetName: "assets/images/2.0x/google-logo.png",
          ),
          const SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            text: "SigIN with Mobile",
            onPressed: () {},
            color: isLoading! ? Colors.grey : Colors.orange.shade500,
            height: 50,
            assetName: "assets/images/mobile.png",
          ),
          const SizedBox(
            height: 10,
          ),
          SignInButton(
            color: isLoading! ? Colors.grey : Colors.redAccent,
            text: "Sign with email",
            onPressed: () => isLoading! ? null : _signInWithEmail(context),
            height: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "or ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign with anonymous",
            color: isLoading! ? Colors.grey : Colors.lime[500],
            onPressed: () => isLoading! ? null : _signInAnonymously(context),
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    if (isLoading!) {
      return const Center(child: CircularProgressIndicator());
    }
    return Text(
      "SignIn ",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
