import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class SetSpecificFieldByUserNameUsecase {
  final UserInfoRepository _repository;

  SetSpecificFieldByUserNameUsecase({required UserInfoRepository repository})
      : _repository = repository;

  Future<void> call(String fieldName, dynamic value) async {
    return await _repository.setSpecificFieldByUserNameUsecase(
        fieldName, value);
  }
}
