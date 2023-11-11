import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';

void directPhoneCall(BuildContext context) async {
  await textToSpeechFuture("Calling Emergency Contact");
  String mobileNo =
      BlocProvider.of<ViuserCubit>(context).userInfo?.emergencyContact ?? "";
  if (mobileNo != "") {
    await FlutterPhoneDirectCaller.callNumber(mobileNo);
  } else {
    Future.delayed(const Duration(seconds: 3), () async {
      await textToSpeechFuture("Invalid Number");
    });
  }
}
