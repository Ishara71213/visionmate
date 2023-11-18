import 'package:visionmate/features/volenteer_support/data/data_sources/remote/volunteer_support_remote_data_source.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/repository/volunteer_support_request_repository.dart';

class VolunteerSupportRepositoryImpl extends VolunteerSupportRepository {
  final VolunteerSupportRemoteDataSource remoteDataSource;

  VolunteerSupportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VolunteerRequestEntity>> getAllRequest() async {
    return await remoteDataSource.getAllRequest();
  }

  @override
  Future<VolunteerRequestEntity> getRequestById(String requestId) async {
    return await remoteDataSource.getRequestById(requestId);
  }

  @override
  Future<bool> submitRequest(VolunteerRequestEntity entity) async {
    return await remoteDataSource.submitRequest(entity);
  }

  @override
  Future<bool> deleteRequestById(String requestId) async {
    return await remoteDataSource.deleteRequestById(requestId);
  }

  @override
  Future<bool> acceptRequestById(VolunteerRequestEntity request) async {
    return await remoteDataSource.acceptRequestById(request);
  }

  @override
  Future<bool> rejectRequestById(String requestId) async {
    return await remoteDataSource.rejectRequestById(requestId);
  }
}
