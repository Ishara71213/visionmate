import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class SubmitPosteUsecase {
  final AppFeaturesRepository _repository;

  SubmitPosteUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<bool> call(PostEntity entity) async {
    return await _repository.submitPost(entity);
  }
}
