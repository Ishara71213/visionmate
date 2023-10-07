import 'package:visionmate/core/entities/guardian_user_entity.dart';
import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class CreateCurrentguardianUserTypeInfo {
  final UserInfoRepository _repository;

  CreateCurrentguardianUserTypeInfo({required UserInfoRepository repository})
      : _repository = repository;

  Future<void> call(GuardianUserEntity user) async {
    return _repository.createCurrentGuardianUserTypeInfo(user);
  }
}
