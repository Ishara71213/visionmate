import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    Form(
                        key: formKeySignIn,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: TextFormInput(
                                  fieldName: "Email",
                                  controller: _emailController,
                                  hintText: "Email",
                                  prefixIcon: const Icon(Icons.email),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: TextFormInput(
                                  fieldName: "Password",
                                  hintText: "Password",
                                  controller: _passwordController,
                                  prefixIcon: const Icon(Icons.lock),
                                )),
                            ElevatedButton(
                              onPressed: () {
                                // submitUserInfo(context);
                                // if (formKeySignIn.currentState!
                                //     .validate()) {
                                //   submitSignIn(context);
                                // }
                              },
                              child: const Text("press"),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          return (state is UserFailrue)
                              ? Column(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        BlocProvider.of<UserCubit>(context)
                                            .errorMsg,
                                        style: kwarningText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80.0,
                          height: 1.0,
                          child: Container(
                            color: kLightGreyColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(" Or continue with",
                              style: kDarkGreySmalltextStyle),
                        ),
                        SizedBox(
                          width: 80.0,
                          height: 1.0,
                          child: Container(
                            color: kLightGreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/Google__G__Logo 2.svg'),
                          const SizedBox(
                            width: 26.0,
                          ),
                          Image.asset(
                            "assets/icons/facebookIcon.png",
                            alignment: Alignment.center,
                            scale: 1,
                          ),
                          const SizedBox(
                            width: 26.0,
                          ),
                          Image.asset(
                            'assets/icons/appleIcon.png',
                            alignment: Alignment.center,
                            scale: 1,
                          )
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: kBlackSmalltextStyle),
                          const SizedBox(width: 4.0),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/signUpScreen", (route) => false);
                              },
                              child: Text(
                                "Sign Up",
                                style: kBlueSmalltextStyle,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void submitUserInfo(context) async {
  //   List<VisitLocation> visitLocations = [
  //     const VisitLocation(
  //         locationName: "home",
  //         locationPurpose: "visit home",
  //         locationCordinates: LatLng(4522, 5666))
  //   ];

  //   await BlocProvider.of<UserInfoCubit>(context).submitUserInfo(
  //       user: VisuallyImpairedUserEntity(
  //     disability: "blind",
  //     emergencyContact: "54654544644",
  //     emergencyContactName: "father",
  //     recidenceAddress: "test adress",
  //     recidenceCordinate: const LatLng(4522, 5666),
  //     guardianId: "78523335",
  //     visitLocation: visitLocations,
  //   ));
  // }
}
