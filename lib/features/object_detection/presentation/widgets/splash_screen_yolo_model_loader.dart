import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreenYoloModelLoader extends StatefulWidget {
  const SplashScreenYoloModelLoader({super.key});

  @override
  State<SplashScreenYoloModelLoader> createState() =>
      _SplashScreenYoloModelLoader();
}

class _SplashScreenYoloModelLoader extends State<SplashScreenYoloModelLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Opacity(
            opacity: 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/visionmate-logo.svg',
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Vision Mate",
                  style: kLogoTextstyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
