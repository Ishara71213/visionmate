import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class GetEmailByUidUsecase {
  final AppFeaturesRepository _repository;

  GetEmailByUidUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<String> call(String uid) async {
    return await _repository.getUserEmailByUid(uid);
  }
}
