import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';

abstract class UserInfoRepository {
  Future<String> getCurrentUId();
  Future<void> createCurrentViUserTypeInfo(VisuallyImpairedUserEntity user);
  Future<void> createCurrentGuardianUserTypeInfo(
      VisuallyImpairedUserEntity user);
}
