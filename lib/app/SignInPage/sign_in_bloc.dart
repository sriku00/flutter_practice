import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInBlox = Provider<SignInBloc>((ref) {
  return SignInBloc();
});

class SignInBloc {
  final StreamController<bool?> _isLoadingController = StreamController<bool?>();

  Stream<bool?> get isLoadingStream => _isLoadingController.stream;
  void dispose() {
    _isLoadingController.close();
  }

  void setIsLoading(bool? isLoading) => _isLoadingController.add(isLoading);
}
