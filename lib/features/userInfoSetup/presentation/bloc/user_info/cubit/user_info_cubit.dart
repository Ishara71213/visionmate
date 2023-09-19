import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/create_current_vi_user_type_info_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/get_current_uid_usecase.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final CreateCurrentViUserTypeInfo createCurrentViUserTypeInfo;
  final GetCurrentUIdGlobalUsecase getCurrentUIdUsecase;
  String errorMsg = "";
  String emergencyContactName = "";
  String emergencyContact = "";
  String disabilityInfo = "";

  UserInfoCubit(
      {required this.createCurrentViUserTypeInfo,
      required this.getCurrentUIdUsecase})
      : super(UserInfoInitial());

  Future<void> resetToInitialState() async {
    emit(UserInfoInitial());
  }

  Future<void> submitUserInfo(
      {required VisuallyImpairedUserEntity user}) async {
    emit(UserInfoLoading());
    try {
      await createCurrentViUserTypeInfo.call(user);
      emit(UserInfoSuccess());
    } on SocketException catch (_) {
      emit(UserInfoFailrue());
    } catch (e) {
      final error = e.toString();
      errorMsg = error.split(']').last;
      emit(UserInfoFailrue());
    }
  }
}
