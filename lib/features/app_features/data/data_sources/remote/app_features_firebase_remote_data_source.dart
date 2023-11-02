import 'dart:io';

import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';

abstract class AppFeaturesFirebaseRemoteDataSource {
  Future<String> getCurrentUId();
  Future<String> getUserIdByEmail(String email);
  Future<String> getUserEmailByUid(String uid);
  Future<UserEntity> uploadProfileImage(File image);
  Future<UserEntity> updateProfileData(UserEntity entity);
}
