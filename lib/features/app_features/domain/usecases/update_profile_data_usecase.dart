import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class UpdateProfileDataUsecase {
  final AppFeaturesRepository _repository;

  UpdateProfileDataUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<UserEntity> call(UserEntity entity) async {
    return await _repository.updateProfileData(entity);
  }
}
