import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class GetCurrentUIdGlobalUsecase {
  final FirebaseRepository _repository;

  GetCurrentUIdGlobalUsecase({required FirebaseRepository repository})
      : _repository = repository;

  Future<String> call() async {
    return _repository.getCurrentUId();
  }
}
