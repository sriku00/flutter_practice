import 'package:flutter/material.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/sigin_form_page.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('SignIn'),
          elevation: 3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: EmailFormPage()),
          ),
        ));
  }
}
