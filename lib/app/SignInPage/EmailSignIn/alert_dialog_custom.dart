import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showAlertDialog(
  BuildContext context, {
  required String? title,
  required String? content,
  required String? defaultText,
  String? cancelActionText,
}) {
  if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Text(
              content!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              if (cancelActionText != null)
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      cancelActionText,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold, color: Colors.indigo),
                    )),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    defaultText!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold, color: Colors.indigo),
                  ))
            ],
          );
        });
  }
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            content!,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            if (cancelActionText != null)
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelActionText,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold, color: Colors.indigo),
                  )),
            CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  defaultText!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.indigo),
                ))
          ],
        );
      });
}
