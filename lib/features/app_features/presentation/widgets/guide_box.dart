import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';

class GuideBox extends StatelessWidget {
  final IconData icon;
  final String title;
  const GuideBox({
    super.key,
    required this.title,
    required this.icon,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width - 48) / 2,
      height: (size.width - 48) / 2,
      decoration: BoxDecoration(
          color: kGuideBoxBgColor, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 80,
                  color: kGuideBoxIconColor,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: kGuideBoxTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
