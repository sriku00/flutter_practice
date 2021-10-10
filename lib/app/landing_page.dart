import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/app/home_page.dart';
import 'package:flutter_practice/app/sign_in_page.dart';
import 'package:flutter_practice/Services/auth_services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  User? _user;

  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    } else {
      return HomePage(
        auth: widget.auth,
        onSignOut: () => _updateUser(null),
      );
    }
  }
}
