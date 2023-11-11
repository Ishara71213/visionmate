import 'dart:io';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';

class UploadimageUsecase {
  final AppFeaturesRepository _repository;

  UploadimageUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<String> call(File image, String fileType) async {
    return await _repository.uploadImage(image, fileType);
  }
}
