import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class VoiceAssistanceGuide extends StatelessWidget {
  const VoiceAssistanceGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Voice Assistance Guide",
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
                "Press and hold to activate the voice assistance",
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
        const SizedBox(height: 8),
        const CommandBubble(command: "Go To"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Go to command can be used to navigate through application features.",
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
                      "Ex => Go to Settings",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Available Go To commands",
                      style: kGuideDetailsSubTitle,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Home",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Home page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Object Detection",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Object Detection page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Color Detection",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Color detection page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Text to Speech",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Text to Speech page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Connect Cane",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Connect Cane page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Navigation Assistance",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Navigation Assistance page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Guide",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Guide page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Community",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Community page. Check Community guide to additional information.",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Requests",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Requests page. Check Suport Request guide to additional information.",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Profile",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Profile page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CommandBubble(
                    command: "Go To",
                    subCommand: "Settings",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to Settings page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "You can also use bellow commands with Go To initial command to setup user informations.",
                      style: kGuideDetailsSubTitle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              const CommandBubble(
                command: "Go To",
                subCommand: "",
              ),
              Column(
                children: [
                  const CommandBubble(
                    command: "",
                    subCommand: "Set Home location",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to set Home location page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const CommandBubble(
                    command: "",
                    subCommand: "Set Visit locations",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to set Visit locations page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const CommandBubble(
                    command: "",
                    subCommand: "Set Guardian",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to set Guardian page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
              Column(
                children: [
                  const CommandBubble(
                    command: "",
                    subCommand: "Set Emergency Contact",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Navigate to set Emergency Contact page",
                            style: kGuideDetailsBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const CommandBubble(command: "Directions To"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Directions to command can be used to get navigation directions to user setup locations Location key words can be change from Settings.",
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
                      "Ex => Directions To Hospital",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              child: Text(
                "Action voice commands",
                style: kGuideDetailsSubTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              child: Text(
                "These commands must use wthout any Initial comand text Like Go To, Directions to etc",
                style: kGuideDetailsBody,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const CommandBubble(
          command: "emergency",
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
                      "Emergency can be used to Notify gurdian when Emergency occured. By Initiating this voice command you can make an phone call to the guardian",
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
                      "Ex => Emergency",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const CommandBubble(
          command: "Read Again",
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
                      "You can use this command to read the Detected Text and Object names. This command available for Color detection and Text to speech features",
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
                      "Ex => Read Again",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const CommandBubble(
          command: "Clear Screen",
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
                      "You can use this command to Clear the Detected Text and Object names. This command available for Color detection and Text to speech features",
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
                      "Ex => Clear Screen",
                      style: kGuideDetailsBody,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
