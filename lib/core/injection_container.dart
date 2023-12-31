import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/guardian_user_profile_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/guardian_user_profile_firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/vi_user_profile_firebase_remote_data_source.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/vi_user_profile_firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/app_features/data/repository_impl/app_features_repository_impl.dart';
import 'package:visionmate/features/app_features/data/repository_impl/guardian_user_profile_repository_impl.dart';
import 'package:visionmate/features/app_features/data/repository_impl/vi_user_profile_repository_impl.dart';
import 'package:visionmate/features/app_features/domain/repository/app_features_repository.dart';
import 'package:visionmate/features/app_features/domain/repository/guardian_user_profile_repository.dart';
import 'package:visionmate/features/app_features/domain/repository/vi_user_profile_repository.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_all_post_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_guardian_info_by_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_vi_user_info_by_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_email_by_uid.dart';
import 'package:visionmate/features/app_features/domain/usecases/live_location_data_monitor_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/live_location_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/submit_post_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/update_profile_data_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/update_profile_image_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/upload_image_usecase.dart';
import 'package:visionmate/features/app_features/presentation/bloc/community/community_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/location/cubit/location_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:visionmate/features/auth/data/data_sources/remote/firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/auth/data/repository_impl/firebase_repository_impl.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';
import 'package:visionmate/features/auth/domain/usecases/get_create_current_user_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_user_by_uid_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/is_sign_in_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/data/data_sources/remote/user_info_firebase_remote_data_source.dart';
import 'package:visionmate/features/userInfoSetup/data/data_sources/remote/user_info_firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/userInfoSetup/data/repository_impl/user_info_repository_impl.dart';
import 'package:visionmate/features/userInfoSetup/domain/repository/user_info_repository.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/create_current_guardian_user_type_info_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/create_current_vi_user_type_info_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/get_uid_by_email.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/guardian_info_updateby_fieldname_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/set_specific_field_by_fieldname_usecase.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Bloc/cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUIdUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      signOutUsecase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
      getCreateCurrentUserUsecase: sl.call(),
      getCurrentUIdUsecase: sl.call(),
      getCurrentUserByUidUsecase: sl.call()));

  sl.registerFactory<UserInfoCubit>(() => UserInfoCubit(
      createCurrentViUserTypeInfo: sl.call(),
      createCurrentguardianUserTypeInfo: sl.call(),
      getCurrentUIdUsecase: sl.call(),
      getUIdEmailUsecase: sl.call(),
      setSpecificFieldByUserNameUsecase: sl.call(),
      guardianInfoUpdateByFieldNameUsecase: sl.call()));

  sl.registerFactory<SpeechToTextCubit>(() => SpeechToTextCubit());
  sl.registerFactory<LocationCubit>(
      () => LocationCubit(liveLocationDataUsecase: sl.call()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(
      updateProfileDataUsecase: sl.call(),
      updateProfileImageUsecase: sl.call()));
  sl.registerFactory<ViuserCubit>(() => ViuserCubit(
      getCurrentViUserById: sl.call(), getEmailByUidUsecase: sl.call()));
  sl.registerFactory<GuardianCubit>(() => GuardianCubit(
      getCurrentGuardianUserById: sl.call(),
      getEmailByUidUsecase: sl.call(),
      liveLocationDataMonitotUsecase: sl.call()));

  sl.registerFactory<CommunityCubit>(() => CommunityCubit(
      getAllPostUsecase: sl.call(),
      submitPosteUsecase: sl.call(),
      uploadimageUsecase: sl.call()));

  //usecase

  //--auth usecases
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUsecase>(
      () => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIdUsecase>(
      () => GetCurrentUIdUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserByUidUsecase>(
      () => GetCurrentUserByUidUsecase(repository: sl.call()));

  //user info usecases
  sl.registerLazySingleton<CreateCurrentViUserTypeInfo>(
      () => CreateCurrentViUserTypeInfo(repository: sl.call()));
  sl.registerLazySingleton<CreateCurrentguardianUserTypeInfo>(
      () => CreateCurrentguardianUserTypeInfo(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIdGlobalUsecase>(
      () => GetCurrentUIdGlobalUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetUIdByEmailUsecase>(
      () => GetUIdByEmailUsecase(repository: sl.call()));
  sl.registerLazySingleton<SetSpecificFieldByUserNameUsecase>(
      () => SetSpecificFieldByUserNameUsecase(repository: sl.call()));

  //App features usecases
  sl.registerLazySingleton<UpdateProfileDataUsecase>(
      () => UpdateProfileDataUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateProfileImageUsecase>(
      () => UpdateProfileImageUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentViUserInfoByUidUsecase>(
      () => GetCurrentViUserInfoByUidUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentGuardianInfoByUidUsecase>(
      () => GetCurrentGuardianInfoByUidUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetEmailByUidUsecase>(
      () => GetEmailByUidUsecase(repository: sl.call()));

  sl.registerLazySingleton<GetAllPostUsecase>(
      () => GetAllPostUsecase(repository: sl.call()));
  sl.registerLazySingleton<SubmitPosteUsecase>(
      () => SubmitPosteUsecase(repository: sl.call()));
  sl.registerLazySingleton<UploadimageUsecase>(
      () => UploadimageUsecase(repository: sl.call()));

  sl.registerLazySingleton<GuardianInfoUpdateByFieldNameUsecase>(
      () => GuardianInfoUpdateByFieldNameUsecase(repository: sl.call()));
  sl.registerLazySingleton<LiveLocationDataUsecase>(
      () => LiveLocationDataUsecase(repository: sl.call()));
  sl.registerLazySingleton<LiveLocationDataMonitotUsecase>(
      () => LiveLocationDataMonitotUsecase(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<UserInfoRepository>(
      () => UserInfoRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<AppFeaturesRepository>(
      () => AppFeaturesRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<ViUserProfileRepository>(
      () => ViUserProfileRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<GuardianUserProfileRepository>(
      () => GuardianUserProfileRepositoryImpl(remoteDataSource: sl.call()));
  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<UserInfoFirebaseRemoteDataSource>(() =>
      UserInfoFirebaseRemoteDataSourceImpl(
          auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<AppFeaturesFirebaseRemoteDataSource>(() =>
      AppFeaturesFirebaseRemoteDataSourceImpl(
          auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<ViProfileFirebaseRemoteDataSource>(() =>
      ViProfileFirebaseRemoteDataSourceImpl(
          auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<GuardianProfileFirebaseRemoteDataSource>(() =>
      GuardianProfileFirebaseRemoteDataSourceImpl(
          auth: sl.call(), firestore: sl.call()));
  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
