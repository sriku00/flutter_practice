import 'package:flutter_practice/Widgets/custom_raised_button_widget.dart';
import 'package:flutter/material.dart';

class SocialSignInButton extends CustomRaisedButtonWidget {
  SocialSignInButton({
    required String? assetName,
    required String text,
    required Color? color,
    required VoidCallback onPressed,
    double? height,
  })  : assert(assetName != null),

        super(
            height: height,
            borderRadius: 7,
            color: color,
            onpressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  assetName!,
                  fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Opacity(opacity: 0.0, child: Image.asset(assetName)),
              ],
            ));
}
