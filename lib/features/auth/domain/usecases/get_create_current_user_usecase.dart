import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class GetCreateCurrentUserUsecase {
  final FirebaseRepository _repository;

  GetCreateCurrentUserUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<void> call(UserEntity user) async {
    return _repository.getCreateCurrentUser(user);
  }
}
