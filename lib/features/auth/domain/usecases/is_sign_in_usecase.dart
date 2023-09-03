import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class IsSignInUsecase {
  final FirebaseRepository _repository;

  IsSignInUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<bool> call() async {
    return _repository.isSignIn();
  }
}
