import 'package:flutter/material.dart';
import 'package:flutter_practice/app/sign_in_button.dart';
import 'package:flutter_practice/app/social_signin_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
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
              onPressed: () {},
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
