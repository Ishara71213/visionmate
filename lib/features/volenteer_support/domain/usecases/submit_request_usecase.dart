import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/repository/volunteer_support_request_repository.dart';

class SubmitRequesteUsecase {
  final VolunteerSupportRepository _repository;

  SubmitRequesteUsecase({required VolunteerSupportRepository repository})
      : _repository = repository;

  Future<bool> call(VolunteerRequestEntity entity) async {
    return await _repository.submitRequest(entity);
  }
}
