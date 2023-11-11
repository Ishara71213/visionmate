import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/guardian_user_profile_repository.dart';

class LiveLocationDataMonitotUsecase {
  final GuardianUserProfileRepository _repository;

  LiveLocationDataMonitotUsecase(
      {required GuardianUserProfileRepository repository})
      : _repository = repository;

  Future<LiveLocationEntity> call(String uid) async {
    return await _repository.liveLocationDataMonitor(uid);
  }
}
