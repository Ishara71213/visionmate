import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class ObjectDetectionGuide extends StatelessWidget {
  const ObjectDetectionGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Object Detection Guide",
          style: kOnboardScreenTitle,
        ),
        const SizedBox(height: 18),
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
                "Step 1: Go to object detection.",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Command ‘Go to Object Detection’ or tap on ‘Object Detection ‘on the home menu.",
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
        const CommandBubble(
          command: "Go to",
          subCommand: "Object Detection",
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 2: Aim your camera.",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Aim your camera to the area where you want to detect the objects and wait. App will take few seconds to process and identify the objects. Please give permission to use the camera for vision mate first.",
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
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 3: Get Detection info",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "After detecting the object, vision mate will highlight the detected object within its name. Also, personal assistance will read the detected object for you.",
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
