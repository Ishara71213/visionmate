import 'dart:io';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';

abstract class AppFeaturesRepository {
  Future<String> getCurrentUId();
  Future<String> getUserIdByEmail(String email);
  Future<UserEntity> uploadProfileImage(File image);
  Future<UserEntity> updateProfileData(UserEntity entity);
}
