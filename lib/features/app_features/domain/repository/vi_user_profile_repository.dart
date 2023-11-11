import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class ViUserProfileRepository {
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo();
  Future<VisuallyImpairedUserEntity> updateViUserData(
      VisuallyImpairedUserEntity entity);
  Future<void> deleteViUserData();
  Future<void> liveLocationDataUpdate(LiveLocationEntity liveLocationEntity);
}
