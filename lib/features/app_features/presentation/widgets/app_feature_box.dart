import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';

class AppFeatureBox extends StatelessWidget {
  final IconData icon;
  final String title;
  const AppFeatureBox({
    super.key,
    required this.title,
    required this.icon,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width - 56) / 2,
      height: (size.width - 56) / 2,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(14)),
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
                  color: kAppBgColor,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: kappFeatureTitle,
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
