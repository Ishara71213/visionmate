import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class GetUIdByEmailUsecase {
  final UserInfoRepository _repository;

  GetUIdByEmailUsecase({required UserInfoRepository repository})
      : _repository = repository;

  Future<String> call(String email) async {
    return await _repository.getUserIdByEmail(email);
  }
}
