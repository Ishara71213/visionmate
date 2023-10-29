import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/domain/usecases/update_profile_data_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/update_profile_image_usecase.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UpdateProfileImageUsecase updateProfileImageUsecase;
  UpdateProfileDataUsecase updateProfileDataUsecase;

  ProfileCubit(
      {required this.updateProfileImageUsecase,
      required this.updateProfileDataUsecase})
      : super(ProfileInitial());

  File? imageFile;
  XFile? imageFileCompressed;
  String profileImageUrl = "";

  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;
    final fileExtension = filePath.split('.').last.toLowerCase();
    final lastIndex = filePath.lastIndexOf('.');
    final splitted = filePath.substring(0, lastIndex);
    final outPath = "$splitted\_out.$fileExtension";
    var result;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
      // final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
      // final splitted = filePath.substring(0, (lastIndex));
      // final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 20,
      );
    } else if (fileExtension == 'png') {
      // Compress PNG images
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.png);
    } else if (fileExtension == 'heic') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.heic);
    } else if (fileExtension == 'webp') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.webp);
    } else {
      return XFile(file.path);
    }
    return result;
  }

  void getFromCamera(BuildContext context) async {
    try {
      final PickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (PickedFile != null) {
        File hqFile = await File(PickedFile!.path);
        XFile? compressedFile = await compressFile(hqFile);

        imageFile = File(compressedFile!.path);
        //imageFileCompressed = compressedFile;
        uploadProfileImage(context);
      } else {
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image capture error')));
    }
  }

  void getFromGallery(BuildContext context) async {
    var status = await Permission.storage.request();

    try {
      if (status.isGranted) {
        final PickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (PickedFile != null) {
          File hqFile = await File(PickedFile!.path);
          XFile? compressedFile = await compressFile(hqFile);
          imageFile = File(compressedFile!.path);
          final originalLength = await hqFile.length();
          final compressedSize = await imageFile!.length();
          uploadProfileImage(context);
          //if (compressedSize > 700000) {}
        } else {
          return;
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission denied')));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Selecting error')));
    }
  }

  void uploadProfileImage(BuildContext context) async {
    try {
      emit(ProfileImageLoading());
      if (imageFile != null) {
        UserEntity updatedUser = await updateProfileImageUsecase(imageFile!);
        if (updatedUser != null) {
          BlocProvider.of<UserCubit>(context).userData = updatedUser;
        }
      } else {
        emit(ProfileInitial());
        return;
      }
      if (profileImageUrl != null || profileImageUrl != "") {
        emit(ProfileImageSuccess());
      } else {
        emit(ProfileInitial());
      }
    } catch (ex) {
      emit(ProfileImageFailure());
    }
  }
}
