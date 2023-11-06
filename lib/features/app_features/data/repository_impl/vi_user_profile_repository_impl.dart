import 'dart:io';

import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/vi_user_profile_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/features/app_features/domain/repository/vi_user_profile_repository.dart';

class ViUserProfileRepositoryImpl extends ViUserProfileRepository {
  final ViProfileFirebaseRemoteDataSource remoteDataSource;

  ViUserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> deleteViUserData() async =>
      await remoteDataSource.deleteCurrentViUserTypeInfo();

  @override
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo() async =>
      await remoteDataSource.getCurrentViUserTypeInfo();

  @override
  Future<VisuallyImpairedUserEntity> updateViUserData(
          VisuallyImpairedUserEntity entity) async =>
      await remoteDataSource.updateCurrentViUserTypeInfo(entity);

  @override
  Future<void> liveLocationDataUpdate(
      LiveLocationEntity liveLocationEntity) async {
    await remoteDataSource.liveLocationDataUpdate(liveLocationEntity);
  }
}
