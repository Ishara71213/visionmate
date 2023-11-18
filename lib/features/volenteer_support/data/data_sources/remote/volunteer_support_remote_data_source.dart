import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';

abstract class VolunteerSupportRemoteDataSource {
  Future<bool> submitRequest(VolunteerRequestEntity entity);
  Future<List<VolunteerRequestEntity>> getAllRequest();
  Future<VolunteerRequestEntity> getRequestById(String requestId);
  Future<bool> deleteRequestById(String requestId);
  Future<bool> rejectRequestById(String requestId);
  Future<bool> acceptRequestById(VolunteerRequestEntity entity);
}
