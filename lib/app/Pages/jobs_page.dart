import 'package:flutter/material.dart';
import 'package:flutter_practice/Services/auth.dart';
import 'package:flutter_practice/Services/data_base.dart';
import 'package:flutter_practice/app/Models/jobs_data_model.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/alert_dialog_custom.dart';
import 'package:flutter_practice/app/SignInPage/EmailSignIn/show_exception_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  Future<void> _signOut(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    try {
      await auth.signOUt();
    } on Exception catch (e) {
      showExceptionDialog(context, title: "SignOut Failed", exception: e);
    }
  }
// logOut AleartDialog

  Future<void> _conformSignOut(BuildContext context) async {
    final bool? didRequestedSignOut = await showAlertDialog(context,
        title: "LogOut",
        content: "Are you sure that you want to LogOut ?",
        defaultText: "LogOut",
        cancelActionText: "Cancel");

    if (didRequestedSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Jobs Page'),
        elevation: 3,
        actions: [
          TextButton(
              onPressed: () => _conformSignOut(context),
              child: Text(
                "Logout",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  _createJob(BuildContext context) {

    final dataBaseProvider = context.read(fireStoreDataBaseProvider);

    dataBaseProvider.createJobs(const Jobs("srikanth", 30), uid);
  }
}
