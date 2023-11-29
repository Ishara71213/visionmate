import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class UseLocationGuide extends StatelessWidget {
  const UseLocationGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "How to Use Location",
          style: kOnboardScreenTitle,
        ),
        const SizedBox(height: 18),
        Container(
          width: (size.width - 32),
          height: (size.width - 32) / 1.7,
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14)),
          child: Lottie.asset('assets/animations/locationMap.json',
              width: 106, height: 106),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 1: Add your home residence and frequently visit locations.",
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
                "How to add home location",
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
                      "Tap on the side menu icon (top of the left side) and next tap on Home Location. Then search for your home location and save. If you are currently living in your home, you just can save the location without searching as vision find your location automatically.",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "or you can use Voice Assistant",
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
          subCommand: "Set Home Location",
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              child: Text(
                "How to add visiting locations",
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
                      "Tap on the side menu icon (top of the left side) and next tap on visit Location. Then search for your location and give a proper name you can easily remember. You can add a purpose too. Then tap on add location. You’ll see added location on the next screen. You can remove or add more location repeating the process.",
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
                      "or you can use Voice Assistant",
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
          subCommand: "Set Visit Locations",
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 2 : Get Direction Info",
                style: kGuideDetailsTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Command ‘Go to Navigation Assistance’ or tap on ‘navigation assistance ‘on the home menu.",
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
          subCommand: "Navigation Assistance",
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
                      "Use Vision Voice assistant to get the direction informations",
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
          command: "Directions to",
          subCommand: "Location name",
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
