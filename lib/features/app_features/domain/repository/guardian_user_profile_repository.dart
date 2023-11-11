import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class GuardianUserProfileRepository {
  Future<GuardianUserEntity> getCurrentGuardianUserTypeInfo();
  Future<GuardianUserEntity> updateGuardianUserData();
  Future<void> deleteGuardianUserData();
  Future<LiveLocationEntity> liveLocationDataMonitor(String uid);
}
