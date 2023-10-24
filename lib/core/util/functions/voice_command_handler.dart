import 'package:flutter/material.dart';
import 'package:visionmate/core/util/functions/location_name_comparison.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/util/functions/string_helper.dart';

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
    }
  }
}
