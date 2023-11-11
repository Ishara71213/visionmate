import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_vi_user_info_by_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_email_by_uid.dart';

part 'viuser_state.dart';

class ViuserCubit extends Cubit<ViuserState> {
  final GetCurrentViUserInfoByUidUsecase getCurrentViUserById;
  final GetEmailByUidUsecase getEmailByUidUsecase;
  VisuallyImpairedUserEntity? userInfo;
  String guardianEmail = "";

  ViuserCubit(
      {required this.getCurrentViUserById, required this.getEmailByUidUsecase})
      : super(ViuserInitial());

  Future<void> resetToInitialState() async {
    emit(ViuserInitial());
  }

  Future<void> getCurrrentUserdata() async {
    try {
      emit(const ViuserDataLoading());
      userInfo = await getCurrentViUserById();
      if (userInfo?.guardianId != null) {
        guardianEmail =
            await getEmailByUidUsecase(userInfo!.guardianId.toString());
      }

      emit(const ViuserDataLoadingComplete());
    } on SocketException catch (_) {
      emit(const ViuserDataLoadingError());
    } catch (_) {
      emit(const ViuserDataLoadingError());
    }
  }
}
