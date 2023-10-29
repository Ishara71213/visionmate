import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_menu_and_profile.dart';
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
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

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
                const AppBarMenuAndProfile(),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              if (state is ProfileInitial &&
                                  userCubit.userData != null &&
                                  userCubit.userData!.imageUrl != null) {
                                return CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 55,
                                  backgroundColor: kLightGreyColor,
                                  foregroundImage: NetworkImage(
                                      userCubit.userData!.imageUrl.toString(),
                                      scale: 1.0),
                                  child: Icon(
                                    Icons.person,
                                    color: kGrey,
                                    size: 70,
                                  ),
                                );
                              } else if (state is ProfileImageLoading) {
                                return CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 55,
                                  backgroundColor: kLightGreyColor,
                                  child: Icon(
                                    Icons.person,
                                    color: kGrey,
                                    size: 70,
                                  ),
                                );
                              } else if (state is ProfileImageSuccess &&
                                  profileCubit.imageFile != null &&
                                  userCubit.userData != null &&
                                  userCubit.userData!.imageUrl != null) {
                                return CircleAvatar(
                                    minRadius: 25,
                                    maxRadius: 55,
                                    backgroundColor: kLightGreyColor,
                                    foregroundImage: NetworkImage(userCubit
                                        .userData!.imageUrl
                                        .toString()));
                                // return CircleAvatar(
                                //     minRadius: 25,
                                //     maxRadius: 55,
                                //     backgroundColor: kLightGreyColor,
                                //     foregroundImage:
                                //         FileImage(profileCubit.imageFile!));
                              } else {
                                return CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 55,
                                  backgroundColor: kLightGreyColor,
                                  child: Icon(
                                    Icons.person,
                                    color: kGrey,
                                    size: 70,
                                  ),
                                );
                              }
                            },
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              width: 32,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kPrimaryColor),
                              child: PopupMenuButton(
                                  offset: const Offset(70, 0),
                                  shadowColor: kLightGreyColor,
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: kButtonTextWhiteColor,
                                    size: 15,
                                  ),
                                  onSelected: (newValue) {
                                    if (newValue == '1') {
                                      profileCubit.getFromCamera(context);
                                    } else if (newValue == '2') {
                                      profileCubit.getFromGallery(context);
                                    } else {
                                      print('You need to do');
                                    }
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem<String>(
                                          value: '1',
                                          child: Row(children: [
                                            Icon(
                                              Icons.camera_alt_rounded,
                                              size: 20,
                                              color: kDarkGreyColor,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Take from Camera",
                                              style: kBlackSmalltextStyle,
                                            ),
                                          ]),
                                        ),
                                        PopupMenuItem<String>(
                                            value: '2',
                                            child: Row(children: [
                                              Icon(
                                                Icons.image_rounded,
                                                size: 20,
                                                color: kDarkGreyColor,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Upload From Gallery",
                                                style: kBlackSmalltextStyle,
                                              )
                                            ])),
                                      ]),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "First Name",
                            style: kSmallTitleText,
                          ),
                          Text(
                            userCubit.userData?.firstName?.toString() ?? "",
                            style: kSmallSubTitleMediumBoldText,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Name",
                            style: kSmallTitleText,
                          ),
                          Text(
                            userCubit.userData?.lastName?.toString() ?? "",
                            style: kSmallSubTitleMediumBoldText,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: kSmallTitleText,
                          ),
                          Text(
                            userCubit.userData?.email?.toString() ?? "",
                            style: kSmallSubTitleMediumBoldText,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
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
                                      "Guardian",
                                      style: kSmallTitleText,
                                    ),
                                    Text(
                                      userCubit.userData?.userType
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).signOut();
                        BlocProvider.of<UserCubit>(context)
                            .resetToInitialState();
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          side: BorderSide(color: kGrey, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                      child:
                          Text("Log Out", style: kOutlineButtonGreyTextstyle)),
                ),
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
