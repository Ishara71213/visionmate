import 'dart:io';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';

abstract class VolunteerSupportRepository {
  Future<bool> submitRequest(VolunteerRequestEntity entity);
  Future<List<VolunteerRequestEntity>> getAllRequest();
  Future<VolunteerRequestEntity> getRequestById(String requestId);
}
