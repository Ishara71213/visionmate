import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_all_post_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/submit_post_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/upload_image_usecase.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final GetAllPostUsecase getAllPostUsecase;
  final SubmitPosteUsecase submitPosteUsecase;
  final UploadimageUsecase uploadimageUsecase;

  CommunityCubit(
      {required this.getAllPostUsecase,
      required this.submitPosteUsecase,
      required this.uploadimageUsecase})
      : super(CommunityInitial());

  File? imageFile;
  XFile? imageFileCompressed;
  String postTitle = "";
  String postContent = "";
  List<PostEntity> postList = [];
  List<String> postIdList = [];

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
      emit(CommunityPhotoUploading());
      final PickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (PickedFile != null) {
        File hqFile = await File(PickedFile!.path);
        XFile? compressedFile = await compressFile(hqFile);

        imageFile = File(compressedFile!.path);
        emit(CommunityPhotoUploadingomplete());
        //imageFileCompressed = compressedFile;
        //uploadProfileImage(context);
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
    emit(CommunityPhotoUploading());
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
          emit(CommunityPhotoUploadingomplete());
          // uploadProfileImage(context);
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

  void submitPost(BuildContext context) async {
    try {
      emit(CommunityPostUploadLoading());
      if (imageFile != null) {
        String imageUrl =
            await uploadimageUsecase.call(imageFile!, "communitypost");
        if (imageUrl != null || imageUrl != "") {
          PostEntity entity = PostEntity(
              title: postTitle,
              content: postContent,
              imageUrl: imageUrl,
              createdUser:
                  BlocProvider.of<UserCubit>(context).userData?.firstName,
              createdDate: DateTime.now());
          bool result = await submitPosteUsecase.call(entity);
          result
              ? emit(CommunityPostUploadSuccess())
              : emit(CommunityPostUploadFailed());
          Future.delayed(const Duration(seconds: 2), () {
            imageFile = null;
            imageFileCompressed = null;
            Navigator.pop(context);
            emit(CommunityInitial());
          });
        }
      } else {
        emit(CommunityInitial());
        return;
      }
    } catch (ex) {
      emit(CommunityPostUploadFailed());
    }
  }

  Future<List<PostEntity>> loadPosts() async {
    List<PostEntity> postListemp = await getAllPostUsecase.call();

    return postListemp;
  }
}
