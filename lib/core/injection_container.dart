import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
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
      getUIdEmailUsecase: sl.call()));

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

  //repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<UserInfoRepository>(
      () => UserInfoRepositoryImpl(remoteDataSource: sl.call()));
  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<UserInfoFirebaseRemoteDataSource>(() =>
      UserInfoFirebaseRemoteDataSourceImpl(
          auth: sl.call(), firestore: sl.call()));
  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
