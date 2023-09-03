import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:visionmate/features/auth/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:visionmate/features/auth/data/data_sources/remote/firebase_remote_data_source_impl.dart';
import 'package:visionmate/features/auth/data/repository_impl/firebase_repository_impl.dart';
import 'package:visionmate/features/auth/domain/repository/firebase_repository.dart';
import 'package:visionmate/features/auth/domain/usecases/get_create_current_user_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/is_sign_in_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:visionmate/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

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
      getCurrentUIdUsecase: sl.call()));

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

  //repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));
  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
