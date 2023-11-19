import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/repository/volunteer_support_request_repository.dart';

class RejectRequestByIdUsecase {
  final VolunteerSupportRepository _repository;

  RejectRequestByIdUsecase({required VolunteerSupportRepository repository})
      : _repository = repository;

  Future<bool> call(String requestId) async {
    return await _repository.rejectRequestById(requestId);
  }
}