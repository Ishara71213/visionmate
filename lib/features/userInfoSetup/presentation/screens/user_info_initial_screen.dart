import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
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
    String user = BlocProvider.of<UserCubit>(context).userType;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: user == UserTypes.volunteer
                  ? Column(
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
                              'Thank you for joining with Vision Mate',
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
                              "Your commitment to making the world a better place inspires us every day. \nReady to make a difference? Let's get started!",
                              style: kOnboardScreenText,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FilledButton(
                            onPressed: () {
                              BlocProvider.of<UserInfoCubit>(context)
                                  .submitViUserInfo();
                              navigationHandlerWithRemovePrevRoute(
                                  context, RouteConst.splashDataLoadScreen);
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
                      ],
                    )
                  : Column(
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
                              BlocProvider.of<UserInfoCubit>(context)
                                  .submitViUserInfo();
                              navigationHandlerWithRemovePrevRoute(
                                  context, RouteConst.splashDataLoadScreen);
                              // navigationHandlerByUserType(
                              //     context,
                              //     RouteConst.homeViUserScreen,
                              //     RouteConst.homeGuardianUserScreen,
                              //     RouteConst.homeVolunteerUserScreen);
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(60),
                                side: BorderSide(
                                    color: kButtonPrimaryColor, width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0))),
                            child:
                                Text("Skip", style: kOutlineButtonTextstyle)),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
