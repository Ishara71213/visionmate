import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/guardian_user_profile_repository.dart';
import 'package:visionmate/features/app_features/domain/repository/vi_user_profile_repository.dart';

class GetCurrentGuardianInfoByUidUsecase {
  final GuardianUserProfileRepository _repository;

  GetCurrentGuardianInfoByUidUsecase(
      {required GuardianUserProfileRepository repository})
      : _repository = repository;

  Future<GuardianUserEntity> call() async {
    return _repository.getCurrentGuardianUserTypeInfo();
  }
}
