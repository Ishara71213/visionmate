import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/repository/volunteer_support_request_repository.dart';

class GetAllRequestUsecase {
  final VolunteerSupportRepository _repository;

  GetAllRequestUsecase({required VolunteerSupportRepository repository})
      : _repository = repository;

  Future<List<VolunteerRequestEntity>> call() async {
    return await _repository.getAllRequest();
  }
}
