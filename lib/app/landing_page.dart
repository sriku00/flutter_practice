import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/app/SignInPage/sign_in_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_practice/app/home_page.dart';
import 'package:flutter_practice/Services/auth.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context , ScopedReader watch) {
    final auth =  watch(authServiceProvider);

    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const SignInPage();
             }
             return const HomePage();
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
