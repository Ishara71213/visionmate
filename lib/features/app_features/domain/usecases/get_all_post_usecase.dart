import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class GetAllPostUsecase {
  final AppFeaturesRepository _repository;

  GetAllPostUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<List<PostEntity>> call() async {
    return await _repository.getAllPost();
  }
}
