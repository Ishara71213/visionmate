import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/route_name_comparison.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
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

void navigationHandlerWithArgumnets(
    BuildContext context, String path, Map<String, dynamic> args) {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  if (previousRouteName != path) {
    Navigator.pushNamed(context, path, arguments: args);
  }
}

void navigationHandlerByUserType(BuildContext context, String viUserpath,
    String guardianPathpath, String volunteerPath) async {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  String user = BlocProvider.of<UserCubit>(context).userType;

  if (user == UserTypes.visuallyImpairedUser) {
    if (previousRouteName != viUserpath) {
      //Navigator.pushNamed(context, viUserpath);
      Navigator.pushNamedAndRemoveUntil(context, viUserpath, (route) => false);
    }
  } else if (user == UserTypes.guardian) {
    if (previousRouteName != guardianPathpath) {
      Navigator.pushNamedAndRemoveUntil(
          context, guardianPathpath, (route) => false);
    }
  } else if (user == UserTypes.volunteer) {
    if (previousRouteName != volunteerPath) {
      Navigator.pushNamedAndRemoveUntil(
          context, volunteerPath, (route) => false);
    }
  }
}

void navigateUsingVoiceCommand(BuildContext context, String routeCommand) {
  String routeName = compareRouteName(routeCommand);
  if (routeName.contains("home")) {
    textToSpeech("Go to home");
    navigationHandlerByUserType(context, RouteConst.homeViUserScreen,
        RouteConst.homeGuardianUserScreen, RouteConst.homeVolunteerUserScreen);
  } else if (routeName == RouteConst.textToSpeechScreen) {
    textToSpeech("Go to $routeCommand \n Tap Screen to Scan Text");
    navigationHandler(context, routeName);
  }
  //settings page navigation
  else if (routeName == RouteConst.setGuardianScreen) {
    navigationHandlerWithArgumnets(context, RouteConst.setGuardianScreen, {
      'isAccessingFromSettings': true,
      'guardianId': BlocProvider.of<ViuserCubit>(context).guardianEmail ?? ""
    });
  } else if (routeName == RouteConst.setEmergencyContactScreen) {
    navigationHandlerWithArgumnets(
        context, RouteConst.setEmergencyContactScreen, {
      'isAccessingFromSettings': true,
      'emergencyContactName': BlocProvider.of<ViuserCubit>(context)
              .userInfo
              ?.emergencyContactName ??
          "",
      'emergencyContact':
          BlocProvider.of<ViuserCubit>(context).userInfo?.emergencyContact ?? ""
    });
  } else if (routeName == RouteConst.setResidenceLocScreen) {
    navigationHandlerWithArgumnets(context, RouteConst.setResidenceLocScreen, {
      'isAccessingFromSettings': true,
      'recidenceAddress':
          BlocProvider.of<ViuserCubit>(context).userInfo?.recidenceAddress ??
              "",
      'latitude': BlocProvider.of<ViuserCubit>(context)
              .userInfo
              ?.recidenceCordinate
              ?.latitude ??
          "",
      'longitude': BlocProvider.of<ViuserCubit>(context)
              .userInfo
              ?.recidenceCordinate
              ?.longitude ??
          ""
    });
  } else if (routeName == RouteConst.setfreqVisitingLocScreen) {
    navigationHandlerWithArgumnets(
        context, RouteConst.addfreqVisitingLocScreen, {
      'isAccessingFromSettings': true,
      'locationCordinates':
          BlocProvider.of<ViuserCubit>(context).userInfo?.visitLocation ?? []
    });
  }
  //common navigations
  else if (routeName != "not found") {
    textToSpeech("Go to $routeCommand");
    navigationHandler(context, routeName);
  } else {
    textToSpeech("Invalid command go to $routeCommand");
  }
}
