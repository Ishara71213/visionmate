import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';

class AppBarWithBackButton extends StatelessWidget {
  final String appBarTitle;

  const AppBarWithBackButton({super.key, this.appBarTitle = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        appBarTitle != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 13),
                    child: Text(
                      appBarTitle,
                      style: kTitleOneText,
                    ),
                  )
                ],
              )
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              ),
              iconSize: 30,
              splashRadius: 1,
              padding: const EdgeInsets.only(
                  left: 10, right: 6, bottom: 10, top: 14),
            ),
          ],
        ),
      ],
    );
  }
}
