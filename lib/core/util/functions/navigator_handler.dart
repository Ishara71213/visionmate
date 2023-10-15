import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/route_name_comparison.dart';
import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

void navigationHandlerWithRemovePrevRoute(BuildContext context, String path) {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  if (previousRouteName != path) {
    Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
  }
}

void navigationHandler(BuildContext context, String path) {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  if (previousRouteName != path) {
    Navigator.pushNamed(context, path);
  }
}

void navigationHandlerByUserType(BuildContext context, String viUserpath,
    String guardianPathpath, String volunteerPath) async {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  String user = BlocProvider.of<UserCubit>(context).userType;

  if (user == UserTypes.visuallyImpairedUser) {
    if (previousRouteName != viUserpath) {
      Navigator.pushNamed(context, viUserpath);
    }
  } else if (user == UserTypes.guardian) {
    if (previousRouteName != guardianPathpath) {
      Navigator.pushNamed(context, guardianPathpath);
    }
  } else if (user == UserTypes.volunteer) {
    if (previousRouteName != volunteerPath) {
      Navigator.pushNamed(context, volunteerPath);
    } else {
      Navigator.pushNamed(context, RouteConst.splashScreen);
    }
  }
}

void navigateUsingVoiceCommand(BuildContext context, String routeCommand) {
  String routeName = compareRouteName(routeCommand);
  if (routeName != "not found") {
    navigationHandler(context, routeName);
  }
}
