import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/domain/usecases/get_create_current_user_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_user_by_uid_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUsecase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final GetCurrentUserByUidUsecase getCurrentUserByUidUsecase;
  String errorMsg = "";
  String userType = "";
  UserEntity? userData;

  UserCubit(
      {required this.signInUsecase,
      required this.signUpUsecase,
      required this.getCreateCurrentUserUsecase,
      required this.getCurrentUIdUsecase,
      required this.getCurrentUserByUidUsecase})
      : super(UserInitial());

  Future<void> resetToInitialState() async {
    emit(UserInitial());
  }

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUsecase.call(user);
      userData = await getCurrentUserByUidUsecase();
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailrue());
    } catch (_) {
      emit(UserFailrue());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUsecase.call(user);
      await getCreateCurrentUserUsecase.call(user);
      userData = await getCurrentUserByUidUsecase();
      userType = user?.userType.toString() ?? "";
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailrue());
    } catch (e) {
      final error = e.toString();
      errorMsg = error.split(']').last;
      emit(UserFailrue());
    }
  }
}
