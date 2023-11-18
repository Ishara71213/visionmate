import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/features/app_features/domain/usecases/upload_image_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/accept_request_by_id_usecase.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/delete_request_usecase.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/get_all_request_usecase.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/get_request_by_id_usecase.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/reject_request_by_id_usecase.dart';
import 'package:visionmate/features/volenteer_support/domain/usecases/submit_request_usecase.dart';

part 'volunteer_support_state.dart';

class VolunteerSupportCubit extends Cubit<VolunteerSupportState> {
  final UploadimageUsecase uploadimageUsecase;
  final GetAllRequestUsecase getAllRequestUsecase;
  final GetRequestByIdUsecase getRequestByIdUsecase;
  final SubmitRequesteUsecase submitRequestUsecase;
  final DeleteRequestUsecase deleteRequestUsecase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final AcceptRequestByIdUsecase acceptRequestByIdUsecase;
  final RejectRequestByIdUsecase rejectRequestByIdUsecase;

  VolunteerSupportCubit(
      {required this.getAllRequestUsecase,
      required this.getRequestByIdUsecase,
      required this.submitRequestUsecase,
      required this.deleteRequestUsecase,
      required this.getCurrentUIdUsecase,
      required this.rejectRequestByIdUsecase,
      required this.acceptRequestByIdUsecase,
      required this.uploadimageUsecase})
      : super(VolunteerSupportInitial());

  File? imageFile;
  XFile? imageFileCompressed;
  String requestTitle = "";
  String requestContent = "";
  List<VolunteerRequestEntity> postList = [];
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
      emit(VlounteerSupportPhotoUploading());
      final PickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (PickedFile != null) {
        File hqFile = await File(PickedFile!.path);
        XFile? compressedFile = await compressFile(hqFile);

        imageFile = File(compressedFile!.path);
        emit(VlounteerSupportPhotoUploadingomplete());
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
    emit(VlounteerSupportPhotoUploading());
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
          emit(VlounteerSupportPhotoUploadingomplete());
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
      emit(VlounteerSupportRequestUploadLoading());
      if (imageFile != null) {
        String imageUrl = await uploadimageUsecase.call(
            imageFile!, "VlounteerSupportRequest");
        if (imageUrl != null || imageUrl != "") {
          VolunteerRequestEntity entity = VolunteerRequestEntity(
              title: requestTitle,
              content: requestContent,
              imageUrl: imageUrl,
              createdUser:
                  BlocProvider.of<UserCubit>(context).userData?.firstName,
              createdUserImageUrl:
                  BlocProvider.of<UserCubit>(context).userData?.imageUrl,
              createdDate: DateTime.now());
          bool result = await submitRequestUsecase.call(entity);
          result
              ? emit(VlounteerSupportRequestUploadSuccess())
              : emit(VlounteerSupportRequestUploadFailed());
          Future.delayed(const Duration(seconds: 2), () {
            imageFile = null;
            imageFileCompressed = null;
            Navigator.pop(context);
            emit(VolunteerSupportInitial());
          });
        }
      } else {
        emit(VolunteerSupportInitial());
        return;
      }
    } catch (ex) {
      emit(VlounteerSupportRequestUploadFailed());
    }
  }

  Future<List<VolunteerRequestEntity>> loadRequests() async {
    List<VolunteerRequestEntity> requestListemp =
        await getAllRequestUsecase.call();
    return requestListemp;
  }

  Future<List<VolunteerRequestEntity>> loadRequestByUserId() async {
    String uid = await getCurrentUIdUsecase.call();
    List<VolunteerRequestEntity> requestListemp =
        await getAllRequestUsecase.call();
    List<VolunteerRequestEntity> filteredRequests = requestListemp
        .where((element) => element.createdUserId == uid)
        .toList();
    return filteredRequests;
  }

  Future<void> deleteRequest(String requestId) async {
    bool result = await deleteRequestUsecase.call(requestId);
    emit(VlounteerSupportRequestDeleteSuccess());
    if (result) {
      emit(VlounteerSupportRequestDeleteSuccess());
      emit(VolunteerSupportInitial());
    } else {
      emit(VlounteerSupportRequestDeleteFailed());
    }
  }

  Future<void> rejectRequest(String requestId) async {
    bool result = await rejectRequestByIdUsecase.call(requestId);
    emit(VlounteerSupportRequestDeleteSuccess());
    if (result) {
      emit(VlounteerSupportRequestDeleteSuccess());
      emit(VolunteerSupportInitial());
    } else {
      emit(VlounteerSupportRequestDeleteFailed());
    }
  }

  Future<void> acceptRequest(
      VolunteerRequestEntity request, BuildContext context) async {
    VolunteerRequestEntity data = VolunteerRequestEntity(
      requestId: request.requestId,
      acceptedUserImageUrl:
          BlocProvider.of<UserCubit>(context).userData?.imageUrl,
      acceptedUserName: BlocProvider.of<UserCubit>(context).userData?.firstName,
      acceptedUserUserId: BlocProvider.of<UserCubit>(context).userData?.uid,
    );
    bool result = await acceptRequestByIdUsecase.call(data);
    emit(VlounteerSupportRequestDeleteSuccess());
    if (result) {
      emit(VlounteerSupportRequestDeleteSuccess());
      emit(VolunteerSupportInitial());
    } else {
      emit(VlounteerSupportRequestDeleteFailed());
    }
  }
}
