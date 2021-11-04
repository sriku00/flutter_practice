import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/Services/api_path.dart';
import 'package:flutter_practice/Services/general_firebase_service.dart';
import 'package:flutter_practice/app/Models/jobs_data_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class DataBase {
  Future<void> createJobs(Jobs jobs, String uid);
}

final fireStoreDataBaseProvider = Provider<FireStoreDataBase>((ref) {
  return FireStoreDataBase(ref.read);
});

class FireStoreDataBase implements DataBase {
  FireStoreDataBase(this._reader);

  final Reader _reader;

  @override
  Future<void> createJobs(Jobs jobs, String uid) async {
    final path = ApiPath.job(uid, "job_abc");
    final DocumentReference documentReference =
        _reader(firebaseFirestoreProvider).doc(path);
    await documentReference.set(jobs.toMap());
  }
}
