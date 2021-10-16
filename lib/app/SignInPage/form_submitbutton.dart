import 'package:flutter/material.dart';
import 'package:flutter_practice/Widgets/widgets.dart';

class FormSubmitButton extends CustomRaisedButtonWidget {
  FormSubmitButton({
    required String? text,
    required Color? color,
    VoidCallback? onpressed,
  }) : super(
            height: 44,
            color: color,
            borderRadius: 6,
            onpressed: onpressed,
            child: Text(
              text!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ));
}
