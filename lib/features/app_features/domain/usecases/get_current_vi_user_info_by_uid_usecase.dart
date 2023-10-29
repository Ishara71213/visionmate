import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/vi_user_profile_repository.dart';

class GetCurrentViUserInfoByUidUsecase {
  final ViUserProfileRepository _repository;

  GetCurrentViUserInfoByUidUsecase(
      {required ViUserProfileRepository repository})
      : _repository = repository;

  Future<VisuallyImpairedUserEntity> call() async {
    return _repository.getCurrentViUserTypeInfo();
  }
}
