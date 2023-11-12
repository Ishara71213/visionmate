import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';
import 'package:visionmate/features/userInfoSetup/data/data_sources/remote/user_info_firebase_remote_data_source.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/repository/volunteer_support_request_repository.dart';

class VolunteerSupportRepositoryImpl extends VolunteerSupportRepository {
  final AppFeaturesFirebaseRemoteDataSource remoteDataSource;

  VolunteerSupportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VolunteerRequestEntity>> getAllRequest() {
    // TODO: implement getAllRequest
    throw UnimplementedError();
  }

  @override
  Future<VolunteerRequestEntity> getRequestById(String requestId) {
    // TODO: implement getRequestById
    throw UnimplementedError();
  }

  @override
  Future<bool> submitRequest(VolunteerRequestEntity entity) {
    // TODO: implement submitRequest
    throw UnimplementedError();
  }
}
