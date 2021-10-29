import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/alert_dialog_custom.dart';

Future<void> showExceptionDialog(BuildContext context,
        {required String title, required Exception exception}) =>
    showAlertDialog(context, title: title, content: _message(exception), defaultText: "Ok");

String? _message(Exception? exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
