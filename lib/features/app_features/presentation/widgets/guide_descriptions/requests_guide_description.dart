import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class RequestsGuide extends StatelessWidget {
  const RequestsGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "support Request Guide",
          style: kOnboardScreenTitle,
        ),
        const SizedBox(height: 18),
        Container(
          width: (size.width - 32),
          height: (size.width - 32) / 1.7,
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14)),
          child: Lottie.asset('assets/animations/support.json',
              width: 106, height: 106),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 1: Go to Request page.",
                style: kGuideDetailsTitle,
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
                      "Command 'Go to requests' or tap on requests on the bottom navigation bar. You’ll see added requests on this Support requests screen.",
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
          command: "Go To",
          subCommand: "Requests",
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 2: write your Support Requests.",
                style: kGuideDetailsTitle,
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
                      "Tap on ‘+’ button on top of the right corner of the screen or use voice assistant",
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
          command: "Go To",
          subCommand: "Request post",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Now you can add a photo from your gallery or take a picture with your camera for the Request. Then add the title and a description for the Support Request.",
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
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 3: Post it",
                style: kGuideDetailsTitle,
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
                      "Once you have written your request, you can just tap on the submit button and you’ll be able to see your request on the request screen. When Volunteer accept your request you will get notified.",
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
