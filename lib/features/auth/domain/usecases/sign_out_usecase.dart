import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository _repository;

  SignOutUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<void> call() async {
    return _repository.signOut();
  }
}
