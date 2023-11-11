import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';

void phoneCallEmergency(BuildContext context) async {
  await textToSpeechFuture("Calling Emergency Contact");
  String mobileNo =
      BlocProvider.of<ViuserCubit>(context).userInfo?.emergencyContact ?? "";
  final Uri telLaunchUri = Uri(
    scheme: 'tel',
    path: mobileNo,
    // queryParameters: <String, String>{
    //   'body': Uri.encodeComponent(''),
    // },
  );
  launchUrl(telLaunchUri);
}
