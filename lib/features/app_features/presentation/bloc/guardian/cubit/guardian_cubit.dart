import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_guardian_info_by_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_email_by_uid.dart';

part 'guardian_state.dart';

class GuardianCubit extends Cubit<GuardianState> {
  final GetCurrentGuardianInfoByUidUsecase getCurrentGuardianUserById;
  final GetEmailByUidUsecase getEmailByUidUsecase;
  GuardianUserEntity? userInfo;
  String wardEmail = "";

  GuardianCubit(
      {required this.getCurrentGuardianUserById,
      required this.getEmailByUidUsecase})
      : super(GuardianInitial());

  Future<void> resetToInitialState() async {
    emit(GuardianInitial());
  }

  Future<void> getCurrrentUserdata() async {
    try {
      emit(const GuardianDataLoading());
      userInfo = await getCurrentGuardianUserById();
      if (userInfo?.vissuallyImpairedUserId != null) {
        wardEmail = await getEmailByUidUsecase(
            userInfo!.vissuallyImpairedUserId.toString());
      }

      emit(const GuardianDataLoadingComplete());
    } on SocketException catch (_) {
      emit(const GuardianDataLoadingError());
    } catch (_) {
      emit(const GuardianDataLoadingError());
    }
  }
}
