import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/userInfoSetup/data/data_sources/remote/user_info_firebase_remote_data_source.dart';
import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';

class UserInfoRepositoryImpl extends UserInfoRepository {
  final UserInfoFirebaseRemoteDataSource remoteDataSource;

  UserInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createCurrentViUserTypeInfo(
          VisuallyImpairedUserEntity user) async =>
      remoteDataSource.createCurrentViUserTypeInfo(user);

  @override
  Future<void> createCurrentGuardianUserTypeInfo(
          GuardianUserEntity user) async =>
      remoteDataSource.createCurrentGuardianUserTypeInfo(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Future<void> setSpecificFieldByUserNameUsecase(
          String fieldName, dynamic value) async =>
      remoteDataSource.setSpecificFieldByUserNameUsecase(fieldName, value);

  @override
  Future<String> getUserIdByEmail(String email) async {
    return await remoteDataSource.getUserIdByEmail(email);
  }

  @override
  Future<void> guardianInfoUpdateByFieldName(String fieldName, dynamic value) {
    return remoteDataSource.guardianInfoUpdateByFieldName(fieldName, value);
  }
}
