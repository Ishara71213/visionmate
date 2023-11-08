import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/guide_screen_types.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/community_guide_description.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/emergency_call_guide_description.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/feature_navigation_guide_description.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/object_detection_guide_description.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/use_location_guide_description.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/voice_assistance_guide_description.dart';

class GuideDescriptionCommon extends StatelessWidget {
  final GuideScreens widgetName;
  final Size size;
  const GuideDescriptionCommon(
      {super.key, required this.widgetName, required this.size});

  @override
  Widget build(BuildContext context) {
    switch (widgetName) {
      case GuideScreens.voiceAssistance:
        return VoiceAssistanceGuide(size: size);
      case GuideScreens.emergencyCall:
        return EmergencyCallGuide(size: size);
      case GuideScreens.howToUseLocation:
        return UseLocationGuide(size: size);
      case GuideScreens.objectDetection:
        return ObjectDetectionGuide(size: size);
      case GuideScreens.featureNavigation:
        return FeatureNavigationGuide(size: size);
      case GuideScreens.communityGuide:
        return CommunityGuide(size: size);
      default:
        return VoiceAssistanceGuide(size: size);
    }
  }
}
