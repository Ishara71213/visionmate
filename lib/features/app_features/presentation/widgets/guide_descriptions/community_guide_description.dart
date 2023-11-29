import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/CommonBubble.dart';

class CommunityGuide extends StatelessWidget {
  const CommunityGuide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Community Guide",
          style: kOnboardScreenTitle,
        ),
        const SizedBox(height: 18),
        Container(
          width: (size.width - 32),
          height: (size.width - 32) / 1.7,
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14)),
          child: Lottie.asset('assets/animations/community.json',
              width: 106, height: 106),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 1: Go to community page.",
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
                      "Command 'Go to community' or tap on community on the bottom navigation bar. You'll see added posts on this community screen.",
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
          subCommand: "Community",
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: Text(
                "Step 2: write your post.",
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
          subCommand: "Community post",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Now you can add a photo from your gallery or take a picture with your camera for the post. Then add the title and a description for the post.",
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
                      "Once you have written your post, you can just tap on the submit button and you’ll be able to see your post on the community screen.",
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
