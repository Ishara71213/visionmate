import 'dart:io';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';

abstract class AppFeaturesRepository {
  Future<String> getCurrentUId();
  Future<String> getUserIdByEmail(String email);
  Future<String> getUserEmailByUid(String uid);
  Future<UserEntity> uploadProfileImage(File image);
  Future<UserEntity> updateProfileData(UserEntity entity);
  Future<String> uploadImage(File image, String fileType);
  Future<bool> submitPost(PostEntity entity);
  Future<List<PostEntity>> getAllPost();
}
