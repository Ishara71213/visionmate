import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_with_back_button.dart';
import 'package:visionmate/features/app_features/presentation/widgets/profile_image.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    GuardianCubit GuardianuserCubit = BlocProvider.of<GuardianCubit>(context);

    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppBarWithBackButton(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const ProfileImage(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userCubit.userData?.firstName?.toString() ?? "",
                                style: kMediumSubTitleMediumBoldText,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                userCubit.userData?.lastName?.toString() ?? "",
                                style: kMediumSubTitleMediumBoldText,
                              ),
                            ],
                          );
                        },
                      ),
                      Center(
                        child: Text(
                          userCubit.userData?.email?.toString() ?? "",
                          style: kDarkGreySmalltextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      FilledButton(
                          onPressed: () => navigationHandler(
                              context, RouteConst.editProfileScreen),
                          style: FilledButton.styleFrom(
                              fixedSize: const Size(120, 40),
                              backgroundColor: kButtonPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          child: Text("Edit Profile",
                              style: kFilledButtonSmallTextstyle)),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date Of Birth",
                                style: kSmallTitleText,
                              ),
                              Text(
                                userCubit.userData?.dob?.toString() ?? "",
                                style: kSmallSubTitleMediumBoldText,
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      userCubit.userData?.userType?.toString() ==
                              UserTypes.visuallyImpairedUser
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Emergency Contact",
                                      style: kSmallTitleText,
                                    ),
                                    Text(
                                      BlocProvider.of<ViuserCubit>(context)
                                              .userInfo
                                              ?.emergencyContactName
                                              ?.toString() ??
                                          "",
                                      style: kSmallSubTitleMediumBoldText,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Contact Number",
                                      style: kSmallTitleText,
                                    ),
                                    Text(
                                      BlocProvider.of<ViuserCubit>(context)
                                              .userInfo
                                              ?.emergencyContact
                                              ?.toString() ??
                                          "",
                                      style: kSmallSubTitleMediumBoldText,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            )
                          : userCubit.userData?.userType?.toString() ==
                                  UserTypes.guardian
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ward",
                                      style: kSmallTitleText,
                                    ),
                                    Text(
                                      GuardianuserCubit?.wardEmail
                                              ?.toString() ??
                                          "",
                                      style: kSmallSubTitleMediumBoldText,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink()
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                //   child: OutlinedButton(
                //       onPressed: () {
                //         BlocProvider.of<AuthCubit>(context).signOut();
                //         BlocProvider.of<UserCubit>(context)
                //             .resetToInitialState();
                //       },
                //       style: OutlinedButton.styleFrom(
                //           minimumSize: const Size.fromHeight(60),
                //           side: BorderSide(color: kGrey, width: 2),
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(6.0))),
                //       child:
                //           Text("Log Out", style: kOutlineButtonGreyTextstyle)),
                // ),
              ],
            ),
          ),
        )),
        floatingActionButton: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is Listning) {
              return Lottie.asset('assets/animations/assistant_circle.json',
                  width: 106, height: 106);
            } else {
              return const BottomNavBar(
                selectedIndex: 5,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
