import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_vi_user_info_by_uid_usecase.dart';

part 'viuser_state.dart';

class ViuserCubit extends Cubit<ViuserState> {
  final GetCurrentViUserInfoByUidUsecase getCurrentViUserById;
  VisuallyImpairedUserEntity? userInfo;

  ViuserCubit({required this.getCurrentViUserById}) : super(ViuserInitial());

  Future<void> resetToInitialState() async {
    emit(ViuserInitial());
  }

  Future<void> getCurrrentUserdata() async {
    try {
      emit(const ViuserDataLoading());
      userInfo = await getCurrentViUserById();
      emit(const ViuserDataLoadingComplete());
    } on SocketException catch (_) {
      emit(const ViuserDataLoadingError());
    } catch (_) {
      emit(const ViuserDataLoadingError());
    }
  }
}
