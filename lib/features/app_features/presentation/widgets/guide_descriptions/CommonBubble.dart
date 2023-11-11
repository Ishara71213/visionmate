import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';

class CommandBubble extends StatelessWidget {
  final String command;
  final String subCommand;
  const CommandBubble(
      {super.key, required this.command, this.subCommand = "Command"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Text(
                    command,
                    style: kGuideDetailsBubbleCommand,
                  ),
                  Text(
                    " + $subCommand",
                    style: kGuideDetailsBubbleSubCommand,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
