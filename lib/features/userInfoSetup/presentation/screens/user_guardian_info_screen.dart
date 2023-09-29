import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

class UserGuardianInfoScreen extends StatefulWidget {
  const UserGuardianInfoScreen({super.key});

  @override
  State<UserGuardianInfoScreen> createState() => _UserGuardianInfoScreenState();
}

class _UserGuardianInfoScreenState extends State<UserGuardianInfoScreen> {
  final GlobalKey<FormState> formKeyEmergencyContact = GlobalKey<FormState>();
  final TextEditingController _guardianEmailController =
      TextEditingController();
  bool agree = false;

  @override
  void dispose() {
    _guardianEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 8),
                            child: SvgPicture.asset(
                              "assets/images/add-user.svg",
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                        child: Text(
                                      'Setup your guardian',
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
                                      "your Guardian must be a registered user of vison mate application",
                                      style: kOnboardScreenText,
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                    key: formKeyEmergencyContact,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0.0),
                                            child: TextFormInput(
                                              fieldName: "Email",
                                              controller:
                                                  _guardianEmailController,
                                              hintText:
                                                  "Visually impaired user email ",
                                              prefixIcon:
                                                  const Icon(Icons.email),
                                            )),
                                      ],
                                    )),
                                Row(children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    child: Checkbox(
                                      activeColor: kPrimaryColor,
                                      value: agree,
                                      onChanged: (value) {
                                        setState(() {
                                          agree = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() => agree = !agree),
                                    child: Text('Always share your location',
                                        overflow: TextOverflow.ellipsis,
                                        style: kOnboardScreenText),
                                  )
                                ]),
                                FilledButton(
                                    onPressed: () {
                                      userInfoCubit.submitUserInfo();
                                      navigationHandlerWithRemovePrevRoute(
                                          context, RouteConst.signInScreen);
                                    },
                                    style: FilledButton.styleFrom(
                                        minimumSize: const Size.fromHeight(60),
                                        backgroundColor: kButtonPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    child: Text("Save",
                                        style: kFilledButtonTextstyle)),
                              ],
                            ),
                          ),
                        ],
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
                ),
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
                onPressed: () {},
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
