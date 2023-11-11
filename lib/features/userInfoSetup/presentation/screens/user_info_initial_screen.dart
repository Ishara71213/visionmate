import 'package:flutter/material.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';

class UserInfoInitialScreen extends StatefulWidget {
  const UserInfoInitialScreen({super.key});

  @override
  State<UserInfoInitialScreen> createState() => _UserInfoInitialScreenState();
}

class _UserInfoInitialScreenState extends State<UserInfoInitialScreen> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/loginPageImage.png",
                    alignment: Alignment.center,
                    scale: 1,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        'We would interested to know about you',
                        style: kOnboardScreenTitle,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        'you can always setup these later press skip to skip the process press next to proceed',
                        style: kOnboardScreenText,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      onPressed: () {
                        navigationHandlerByUserType(
                            context,
                            RouteConst.setEmergencyContactScreen,
                            RouteConst.setViUserScreen,
                            "");
                        // navigationHandler(
                        //     context, RouteConst.setEmergencyContactScreen);
                      },
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          backgroundColor: kButtonPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                      child: Text("Next", style: kFilledButtonTextstyle)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigationHandlerByUserType(
                            context,
                            RouteConst.homeViUserScreen,
                            RouteConst.homeGuardianUserScreen,
                            RouteConst.homeVolunteerUserScreen);
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          side:
                              BorderSide(color: kButtonPrimaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                      child: Text("Skip", style: kOutlineButtonTextstyle)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
