import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_menu_and_profile.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const AppBarMenuAndProfile(
                  appBarTitle: "Settings",
                ),
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      BlocProvider.of<UserCubit>(context).userType ==
                              UserTypes.visuallyImpairedUser
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                          onPressed: () {
                                            navigationHandlerWithArgumnets(
                                                context,
                                                RouteConst.setGuardianScreen, {
                                              'isAccessingFromSettings': true,
                                              'guardianId':
                                                  BlocProvider.of<ViuserCubit>(
                                                              context)
                                                          .guardianEmail ??
                                                      ""
                                            });
                                          },
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      kSplashGreyColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.group,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "Guardian",
                                                style:
                                                    kMediumSubTitleMediumBoldText,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                          onPressed: () {
                                            navigationHandlerWithArgumnets(
                                                context,
                                                RouteConst
                                                    .setResidenceLocScreen,
                                                {
                                                  'isAccessingFromSettings':
                                                      true,
                                                  'recidenceAddress': BlocProvider
                                                              .of<ViuserCubit>(
                                                                  context)
                                                          .userInfo
                                                          ?.recidenceAddress ??
                                                      "",
                                                  'latitude': BlocProvider.of<
                                                                  ViuserCubit>(
                                                              context)
                                                          .userInfo
                                                          ?.recidenceCordinate
                                                          ?.latitude ??
                                                      "",
                                                  'longitude': BlocProvider.of<
                                                                  ViuserCubit>(
                                                              context)
                                                          .userInfo
                                                          ?.recidenceCordinate
                                                          ?.longitude ??
                                                      ""
                                                });
                                          },
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      kSplashGreyColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "Home Location",
                                                style:
                                                    kMediumSubTitleMediumBoldText,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                          onPressed: () {
                                            navigationHandlerWithArgumnets(
                                                context,
                                                RouteConst
                                                    .addfreqVisitingLocScreen,
                                                {
                                                  'isAccessingFromSettings':
                                                      true,
                                                  'locationCordinates':
                                                      BlocProvider.of<ViuserCubit>(
                                                                  context)
                                                              .userInfo
                                                              ?.visitLocation ??
                                                          []
                                                });
                                          },
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      kSplashGreyColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "Visit Locations",
                                                style:
                                                    kMediumSubTitleMediumBoldText,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                          onPressed: () {
                                            navigationHandlerWithArgumnets(
                                                context,
                                                RouteConst
                                                    .setEmergencyContactScreen,
                                                {
                                                  'isAccessingFromSettings':
                                                      true,
                                                  'emergencyContactName': BlocProvider
                                                              .of<ViuserCubit>(
                                                                  context)
                                                          .userInfo
                                                          ?.emergencyContactName ??
                                                      "",
                                                  'emergencyContact': BlocProvider
                                                              .of<ViuserCubit>(
                                                                  context)
                                                          .userInfo
                                                          ?.emergencyContact ??
                                                      ""
                                                });
                                          },
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      kSplashGreyColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.emergency,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "Emergency Contact",
                                                style:
                                                    kMediumSubTitleMediumBoldText,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextButton(
                                          onPressed: () {
                                            navigationHandlerWithArgumnets(
                                                context,
                                                RouteConst
                                                    .setVisualDisabilityScreen,
                                                {
                                                  'isAccessingFromSettings':
                                                      true,
                                                  'disability': BlocProvider.of<
                                                                  ViuserCubit>(
                                                              context)
                                                          .userInfo
                                                          ?.disability ??
                                                      ""
                                                });
                                          },
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      kSplashGreyColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.info,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "Disability Info",
                                                style:
                                                    kMediumSubTitleMediumBoldText,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      Row(
                        children: [
                          Flexible(
                            child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<UserCubit>(context)
                                      .resetToInitialState();
                                  BlocProvider.of<AuthCubit>(context).signOut();
                                },
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => kSplashGreyColor)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: kDarkGreyColor,
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      "Log out",
                                      style: kMediumSubTitleMediumBoldText,
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is Listning) {
              return Lottie.asset('assets/animations/assistant_circle.json',
                  width: 106, height: 106);
            } else {
              return const BottomNavBar(
                selectedIndex: 3,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
