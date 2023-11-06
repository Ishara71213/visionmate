import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class GuardianProfileFirebaseRemoteDataSource {
  Future<GuardianUserEntity> getCurrentGuardianUserTypeInfo();
  Future<GuardianUserEntity> updateCurrentGuardianUserTypeInfo();
  Future<void> deleteCurrentGuardianUserTypeInfo();
  Future<LiveLocationEntity> liveLocationDataMonitor(String uid);
}
