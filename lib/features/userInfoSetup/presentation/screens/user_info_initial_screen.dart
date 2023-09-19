import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

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
                        navigationHandler(
                            context, RouteConst.setEmergencyContactScreen);
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
                        navigationHandlerWithRemovePrevRoute(
                            context, RouteConst.homeScreen);
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
