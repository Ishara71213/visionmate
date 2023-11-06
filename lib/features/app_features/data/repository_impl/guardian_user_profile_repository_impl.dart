import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/guardian_user_profile_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/domain/repository/guardian_user_profile_repository.dart';

class GuardianUserProfileRepositoryImpl extends GuardianUserProfileRepository {
  final GuardianProfileFirebaseRemoteDataSource remoteDataSource;

  GuardianUserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> deleteGuardianUserData() {
    // TODO: implement deleteViUserData
    throw UnimplementedError();
  }

  @override
  Future<GuardianUserEntity> getCurrentGuardianUserTypeInfo() async =>
      await remoteDataSource.getCurrentGuardianUserTypeInfo();

  @override
  Future<GuardianUserEntity> updateGuardianUserData() async =>
      await remoteDataSource.updateCurrentGuardianUserTypeInfo();

  @override
  Future<LiveLocationEntity> liveLocationDataMonitor(String uid) async {
    return await remoteDataSource.liveLocationDataMonitor(uid);
  }
}
