import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class EmergencyCallGuide extends StatelessWidget {
  const EmergencyCallGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Emergency call Guide",
          style: kOnboardScreenTitle,
        ),
        const SizedBox(height: 18),
        Container(
          width: (size.width - 32),
          height: (size.width - 32) / 1.7,
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14)),
          child: Lottie.asset('assets/animations/doubleTap.json',
              width: 106, height: 106),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Double Tap to Activate",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const CommandBubble(
          command: "Double Tap",
          subCommand: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Double tap to activate the screan Vision mate will navigate to dial screen you just have to press call button to make the Emergency call.",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Ex => Double Tap",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: (size.width - 32),
          height: (size.width - 32) / 1.7,
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14)),
          child: Lottie.asset('assets/animations/press_and_hold.json',
              width: 106, height: 106),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Press and hold and activate through Assistant",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              child: Text(
                "Assistance voice commands",
                style: kGuideDetailsSubTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const CommandBubble(
          leadingCommand: "Press and Hold",
          command: "Emergency",
          subCommand: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Press and hold to activate the personal assistance and say ‘Emergency.’ Vision mate will dial your emergency contact immediately.",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Ex => Press And Hold + Emergency",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Please ensure you have added your emergency contact details beforehand to enable this feature.",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "How to add home emergency contact",
                style: kGuideDetailsSubTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Tap on the side menu icon (top of the left side) and next tap on Emergency contact. Then give a name and contact number. You can always change it.",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
