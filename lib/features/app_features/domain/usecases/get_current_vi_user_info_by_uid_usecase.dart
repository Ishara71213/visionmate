import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';

class GetCurrentViUserInfoByUidUsecase {
  final AppFeaturesRepository _repository;

  GetCurrentViUserInfoByUidUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<VisuallyImpairedUserEntity> call() async {
    return _repository.getCurrentViUserTypeInfo();
  }
}
