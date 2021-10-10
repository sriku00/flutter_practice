import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth_services.dart';
import 'package:flutter_practice/app/sign_in_button.dart';
import 'package:flutter_practice/app/social_signin_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth, required this.onSignIn}) : super(key: key);

  final void Function(User) onSignIn;
  final AuthBase auth;

  // ignore: unused_element
  Future<void> _signInAnonymously() async {
    try {
      final user = await auth.signInAnonymously();
      onSignIn(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignIn'),
        elevation: 3,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
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
              onPressed: () {},
              color: Colors.green,
              height: 50,
              assetName: "assets/images/2.0x/google-logo.png",
            ),
            const SizedBox(
              height: 10,
            ),
            SocialSignInButton(
              text: "SignIn With facebook",
              onPressed: () {},
              color: Colors.blue[800],
              height: 50,
              assetName: "assets/images/2.0x/facebook-logo.png",
            ),
            const SizedBox(
              height: 10,
            ),
            SignInButton(
              color: Colors.redAccent,
              text: "Sign with email",
              onPressed: () {},
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
      ),
    );
  }
}
