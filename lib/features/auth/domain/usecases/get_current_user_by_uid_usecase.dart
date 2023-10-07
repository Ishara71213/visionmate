import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class GetCurrentUserByUidUsecase {
  final FirebaseRepository _repository;

  GetCurrentUserByUidUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<UserEntity> call() async {
    return _repository.getCurrentUserById();
  }
}
