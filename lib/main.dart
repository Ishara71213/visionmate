import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/location/cubit/location_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/core/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:visionmate/config/routes/on_generate_route.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

// distributionUrl=https\://services.gradle.org/distributions/gradle-7.5-all.zip
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const VisionMateApp());
}

class VisionMateApp extends StatelessWidget {
  const VisionMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<UserInfoCubit>(create: (_) => di.sl<UserInfoCubit>()),
        BlocProvider<SpeechToTextCubit>(
            create: (_) => di.sl<SpeechToTextCubit>()),
        BlocProvider<LocationCubit>(create: (_) => di.sl<LocationCubit>()),
        BlocProvider<ViuserCubit>(create: (_) => di.sl<ViuserCubit>()),
        BlocProvider<GuardianCubit>(create: (_) => di.sl<GuardianCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => di.sl<ProfileCubit>()),
      ],
      child: const MaterialApp(
        title: 'Vision mate',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConst.splashScreen,
        onGenerateRoute: OnGenerateRoute.route,
        home: null,
      ),
    );
  }
}
