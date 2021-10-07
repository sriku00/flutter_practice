import 'package:flutter_practice/Widgets/custom_raised_button_widget.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomRaisedButtonWidget {
  SignInButton({
    required String text,
    Color? color,
    required VoidCallback onPressed,
    double? height,
  }) : super(
            height: height,
            borderRadius: 7,
            color: color,
            onpressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ));
}
