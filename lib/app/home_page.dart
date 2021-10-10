import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth, required this.onSignOut}) : super(key: key);
  final AuthBase auth;
  final VoidCallback onSignOut;

  // ignore: unused_element
  Future<void> _signOutAnonymously() async {
    try {
      await auth.signOutAnonymously();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('HomePage'),
        elevation: 3,
        actions: [
          TextButton(
              onPressed: _signOutAnonymously,
              child: Text(
                "Logout",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
              ))
        ],
      ),
    );
  }
}