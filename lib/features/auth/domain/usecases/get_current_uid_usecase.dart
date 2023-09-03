import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class GetCurrentUIdUsecase {
  final FirebaseRepository _repository;

  GetCurrentUIdUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<String> call() async {
    return _repository.getCurrentUId();
  }
}
