import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class SignUpUsecase {
  final FirebaseRepository _repository;

  SignUpUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<void> call(UserEntity user) async {
    return _repository.signUp(user);
  }
}
