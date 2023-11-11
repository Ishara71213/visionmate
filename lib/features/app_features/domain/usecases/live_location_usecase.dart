import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/features/app_features/domain/repository/vi_user_profile_repository.dart';

class LiveLocationDataUsecase {
  final ViUserProfileRepository _repository;

  LiveLocationDataUsecase({required ViUserProfileRepository repository})
      : _repository = repository;

  Future<void> call(LiveLocationEntity entity) async {
    return await _repository.liveLocationDataUpdate(entity);
  }
}
