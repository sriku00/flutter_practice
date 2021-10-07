import 'package:flutter/material.dart';

class CustomRaisedButtonWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomRaisedButtonWidget(
      {this.borderRadius = 10, this.height = 30, this.child, required this.color, this.onpressed});

  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final VoidCallback? onpressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(6),
          backgroundColor: MaterialStateProperty.all<Color>(
            color!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.orangeAccent,
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.blue,
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        child: child,
        onPressed: onpressed,
      ),
    );
  }
}
