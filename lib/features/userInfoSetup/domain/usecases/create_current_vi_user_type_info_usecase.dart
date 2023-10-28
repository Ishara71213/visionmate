import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class CreateCurrentViUserTypeInfo {
  final UserInfoRepository _repository;

  CreateCurrentViUserTypeInfo({required UserInfoRepository repository})
      : _repository = repository;

  Future<void> call(VisuallyImpairedUserEntity user) async {
    return _repository.createCurrentViUserTypeInfo(user);
  }
}
