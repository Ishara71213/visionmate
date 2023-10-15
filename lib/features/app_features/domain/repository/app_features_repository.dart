import 'package:visionmate/core/entities/guardian_user_entity.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';

abstract class AppFeaturesRepository {
  Future<String> getCurrentUId();
  Future<void> createCurrentViUserTypeInfo(VisuallyImpairedUserEntity user);
  Future<void> createCurrentGuardianUserTypeInfo(GuardianUserEntity user);
  Future<String> getUserIdByEmail(String email);
}