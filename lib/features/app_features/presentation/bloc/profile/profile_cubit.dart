import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  File? imageFile;
  XFile? imageFileCompressed;

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
        quality: 5,
      );
    } else if (fileExtension == 'png') {
      // Compress PNG images
      var result = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: 5, format: CompressFormat.png);
    } else if (fileExtension == 'heic') {
      var result = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: 5, format: CompressFormat.heic);
    } else if (fileExtension == 'webp') {
      var result = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: 5, format: CompressFormat.webp);
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
        uploadProfileImage();
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
          uploadProfileImage();
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

  void uploadProfileImage() async {
    try {
      emit(ProfileImageLoading());
      bool result = true;
      if (result = true) {
        emit(ProfileImageSuccess());
      }
    } catch (ex) {
      emit(ProfileImageFailure());
    }
  }
}
