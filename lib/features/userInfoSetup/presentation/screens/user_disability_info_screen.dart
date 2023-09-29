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

class UserDisabilityInfoScreen extends StatefulWidget {
  const UserDisabilityInfoScreen({super.key});

  @override
  State<UserDisabilityInfoScreen> createState() =>
      _UserDisabilityInfoScreenState();
}

class _UserDisabilityInfoScreenState extends State<UserDisabilityInfoScreen> {
  final GlobalKey<FormState> formKeyDisabilityInfo = GlobalKey<FormState>();
  String? userDisabilityVal;
  final List<Map<String, String>> userDisabilityList = [
    {"text": "Blind", "value": "blind"},
    {"text": "Low Vision", "value": "lowVision"},
    {"text": "Color Blind", "value": "colorBlind"}
  ];

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return BlocListener<UserCubit, UserState>(
        listener: (context, state) async {
          if (state is UserSuccess) {
            await Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConst.homeScreen, (route) => false);
              BlocProvider.of<AuthCubit>(context).appStarted();
            });
          }
        },
        child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //     ),
          //     iconSize: 30,
          //     splashRadius: 1,
          //     padding: const EdgeInsets.only(top: 20),
          //   ),
          //   leadingWidth: 80,
          //   elevation: 0,
          //   toolbarHeight: 50,
          //   backgroundColor: kAppBgColor,
          //   foregroundColor: kPrimaryColor,
          // ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/mobile-login.svg",
                                alignment: Alignment.center,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Visual disability',
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
                                    'you can always skip if you not interested to provide answers',
                                    style: kOnboardScreenText,
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                  key: formKeyDisabilityInfo,
                                  child: Column(
                                    children: [
                                      Padding(
                                        //Purpose of user
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: DropdownFromListInput(
                                          fieldName: "User Disability",
                                          list: userDisabilityList,
                                          selectedValue: userDisabilityVal,
                                          onChange: (value) => setState(() {
                                            userDisabilityVal =
                                                value!.toString();
                                          }),
                                          hintText: "Select",
                                          prefixIcon: const Icon(
                                              Icons.health_and_safety),
                                          isMandotary: true,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: kPrimaryColor,
                      ),
                      iconSize: 30,
                      splashRadius: 1,
                      padding:
                          const EdgeInsets.only(left: 22, right: 6, bottom: 10),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: kBluetextStyle,
                    )),
                OutlinedButton(
                  onPressed: () {
                    saveDataState(context);
                    navigationHandler(context, RouteConst.setGuardianScreen);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kPrimaryColor),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    primary: kPrimaryColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.navigate_next,
                      size: 40,
                      color: kLightGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void saveDataState(BuildContext context) async {
    BlocProvider.of<UserInfoCubit>(context).disabilityInfo =
        userDisabilityVal.toString();
  }
}
