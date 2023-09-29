import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/screens/auth_options_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/home_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:visionmate/core/screens/splash_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_set_frequently_visiting_locations_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_disability_info_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_emergency_info_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_frequently_visiting_locations_info_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_guardian_info_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_info_initial_screen.dart';
import 'package:visionmate/features/userInfoSetup/presentation/screens/user_set_residence_location_screen.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    String routeName = settings.name.toString();
    switch (settings.name) {
      case '/':
        return materialBuilderAuthScreens(
            widget: const UserInfoInitialScreen()
            //const AuthOptionsScreen()
            ,
            route: routeName);
      case '/splashScreen':
        return materialBuilderAuthScreens(
            widget: const SplashScreen(), route: routeName);
      case '/signInScreen':
        return materialBuilderAuthScreens(
            widget: const SignInScreen(), route: routeName);
      case '/signUpScreen':
        return materialBuilderAuthScreens(
            widget: const SignUpScreen(), route: routeName);
      case '/userInfoScreen':
        return materialBuilder(
            widget: const UserInfoInitialScreen(), route: routeName);
      case RouteConst.setEmergencyContactScreen:
        return materialBuilder(
            widget: const UserEmergencyInfoScreen(), route: routeName);
      case RouteConst.setfreqVisitingLocScreen:
        return materialBuilder(
            widget: const UserSetFrequentlyVisitingLocationsScreen(),
            route: routeName);
      case RouteConst.addfreqVisitingLocScreen:
        return materialBuilder(
            widget: const UserFrequentlyVisitingLocationsInfoScreen(),
            route: routeName);
      case RouteConst.setResidenceLocScreen:
        return materialBuilder(
            widget: const UserSetResidenceLocationScreen(), route: routeName);
      case RouteConst.setVisualDisabilityScreen:
        return materialBuilder(
            widget: const UserDisabilityInfoScreen(), route: routeName);
      case RouteConst.setGuardianScreen:
        return materialBuilder(
            widget: const UserGuardianInfoScreen(), route: routeName);
      case '/homeScreen':
        return materialBuilder(
            widget: const UserInfoInitialScreen(), route: routeName);
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

//use this function to generate routes only for auth screens
//since its return the argument(widget) if user not authenticated
MaterialPageRoute materialBuilderAuthScreens(
    {required Widget widget, required String route}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: route),
      builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const UserInfoInitialScreen();
              } else if (state is UnAuthenticated) {
                return widget;
              } else {
                return const AuthOptionsScreen();
              }
            },
          ));
}

//use this function to generate routes only for auth screens
//return the argument(widget) if user is authenticated
MaterialPageRoute materialBuilder(
    {required Widget widget, required String route}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: route),
      builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return widget;
              } else {
                return const AuthOptionsScreen();
              }
            },
          ));
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
    );
  }
}
