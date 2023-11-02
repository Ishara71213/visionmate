import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class UserInfoRepository {
  Future<String> getCurrentUId();
  Future<void> createCurrentViUserTypeInfo(VisuallyImpairedUserEntity user);
  Future<void> createCurrentGuardianUserTypeInfo(GuardianUserEntity user);
  Future<void> setSpecificFieldByUserNameUsecase(
      String fieldName, String value);
  Future<String> getUserIdByEmail(String email);
}
