import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/voice_assistance_guide_description.dart';

class GuideDescriptionCommon extends StatelessWidget {
  final String widgetName;
  final Size size;
  const GuideDescriptionCommon(
      {super.key, required this.widgetName, required this.size});

  @override
  Widget build(BuildContext context) {
    switch (widgetName) {
      case "ObjectDetection":
        return VoiceAssistanceGuide(size: size);
      default:
        return Center(child: Container(child: Text("Default")));
    }
  }
}
