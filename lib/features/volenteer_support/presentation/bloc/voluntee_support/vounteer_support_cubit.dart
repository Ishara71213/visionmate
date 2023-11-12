import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_email_by_uid.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_uid_by_email.dart';
import 'package:visionmate/features/app_features/domain/usecases/upload_image_usecase.dart';

part 'vounteer_support_state.dart';

class VounteerSupportCubit extends Cubit<VounteerSupportState> {
  final GetEmailByUidUsecase getEmailByUidUsecase;
  final GetUIdByEmailUsecase getUidByEmailUsecase;
  final GetCurrentUIdGlobalUsecase getCurrentUIdGlobalUsecase;
  final UploadimageUsecase uploadimageUsecase;

  VounteerSupportCubit(
      {required this.getEmailByUidUsecase,
      required this.getUidByEmailUsecase,
      required this.getCurrentUIdGlobalUsecase,
      required this.uploadimageUsecase})
      : super(VounteerSupportInitial());
}
