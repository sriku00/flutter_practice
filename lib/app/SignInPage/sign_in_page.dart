import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth.dart';
import 'package:flutter_practice/app/SignInPage/email_sigin_page.dart';
import 'package:flutter_practice/app/SignInPage/sign_in_button.dart';
import 'package:flutter_practice/app/SignInPage/social_signin_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signINwithGoogle() async {
    try {
      await auth.signInwithGoogle();
    } catch (e) {
      print(e.toString());
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
          Text(
            "SignIn ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            text: "SignIn With google",
            onPressed: _signINwithGoogle,
            color: Colors.green,
            height: 50,
            assetName: "assets/images/2.0x/google-logo.png",
          ),
          const SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            text: "SigIN with Mobile",
            onPressed: () {},
            color: Colors.orange.shade500,
            height: 50,
            assetName: "assets/images/mobile.png",
          ),
          const SizedBox(
            height: 10,
          ),
          SignInButton(
            color: Colors.redAccent,
            text: "Sign with email",
            onPressed: () => _signInWithEmail(context),
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
            color: Colors.lime[500],
            onPressed: _signInAnonymously,
            height: 60,
          ),
        ],
      ),
    );
  }
}
