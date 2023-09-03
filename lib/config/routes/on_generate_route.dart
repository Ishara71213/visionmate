import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/screens/auth_options_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/home_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:visionmate/features/auth/presentation/screens/sign_up_screen.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return materialBuilderAuthScreens(widget: const AuthOptionsScreen());
      case '/signInScreen':
        return materialBuilderAuthScreens(widget: const SignInScreen());
      case '/signUpScreen':
        return materialBuilderAuthScreens(widget: const SignUpScreen());
      case '/homeScreen':
        return materialBuilder(widget: const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

//use this function to generate routes only for auth screens
//since its return the argument(widget) if user not authenticated
MaterialPageRoute materialBuilderAuthScreens({required Widget widget}) {
  return MaterialPageRoute(
      builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const HomeScreen();
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
MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(
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
