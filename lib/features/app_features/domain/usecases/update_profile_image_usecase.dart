import 'dart:io';

import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';

class UpdateProfileImageUsecase {
  final AppFeaturesRepository _repository;

  UpdateProfileImageUsecase({required AppFeaturesRepository repository})
      : _repository = repository;

  Future<UserEntity> call(File image) async {
    return await _repository.uploadProfileImage(image);
  }
}
