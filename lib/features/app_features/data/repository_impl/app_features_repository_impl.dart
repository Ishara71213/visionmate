import 'package:visionmate/core/entities/guardian_user_entity.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class AppFeaturesRepositoryImpl extends AppFeaturesRepository {
  final AppFeaturesFirebaseRemoteDataSource remoteDataSource;

  AppFeaturesRepositoryImpl({required this.remoteDataSource});

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
  Future<String> getUserIdByEmail(String email) async {
    return await remoteDataSource.getUserIdByEmail(email);
  }
}
