import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/util/functions/direct_phone_call.dart';
import 'package:visionmate/core/util/functions/location_name_comparison.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/util/functions/string_helper.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/features/text_to_Speech/presentation/bloc/text_to_peech/text_to_speech_cubit.dart';

void voiceCommandHandler(BuildContext context, command, double confidence) {
  if (command.isNotEmpty && confidence > 0.5) {
    if (command.contains("go to")) {
      String routeCommand = removeGoto(command);
      navigateUsingVoiceCommand(context, routeCommand);
    } else if (command.contains("directions to")) {
      String routeCommand = removeWord(command, "directions to");
      compareLocationName(context, routeCommand);
    } else if (command.contains("direction to")) {
      String routeCommand = removeWord(command, "direction to");
      compareLocationName(context, routeCommand);
    } else if (command.contains("emergency")) {
      //String routeCommand = command;
      directPhoneCall(context);
    } else if (command.contains("read again")) {
      textToSpeech(BlocProvider.of<TextToSpeechCubit>(context)?.readText ?? "");
    } else if (command.contains("clear screen")) {
      BlocProvider.of<TextToSpeechCubit>(context)?.clearData();
    } else {
      textToSpeech("Invalid command $command");
    }
  }
}

// bool voiceCommandYesNoHandler(
//     BuildContext context, command, double confidence) {
//   if (command.isNotEmpty && confidence > 0.5) {
//     if (command.contains("yes")) {
//       return true;
//     } else {
//       return false;
//     }
//   } else {
//     return false;
//   }
// }
