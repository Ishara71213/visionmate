import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class ViProfileFirebaseRemoteDataSource {
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo();
  Future<VisuallyImpairedUserEntity> updateCurrentViUserTypeInfo(
      VisuallyImpairedUserEntity entity);
  Future<void> deleteCurrentViUserTypeInfo();
}
