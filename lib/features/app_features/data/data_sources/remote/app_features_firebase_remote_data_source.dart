import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class AppFeaturesFirebaseRemoteDataSource {
  Future<String> getCurrentUId();
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo();
  Future<void> createCurrentGuardianUserTypeInfo(GuardianUserEntity user);
  Future<String> getUserIdByEmail(String email);
}
