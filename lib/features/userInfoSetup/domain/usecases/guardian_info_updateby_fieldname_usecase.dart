import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class GuardianInfoUpdateByFieldNameUsecase {
  final UserInfoRepository _repository;

  GuardianInfoUpdateByFieldNameUsecase({required UserInfoRepository repository})
      : _repository = repository;

  Future<void> call(String fieldName, dynamic value) async {
    return await _repository.guardianInfoUpdateByFieldName(fieldName, value);
  }
}
