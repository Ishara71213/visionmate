import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/guide_screen_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_box.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/guide_description_common%20copy.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class CommunityPostsScreen extends StatefulWidget {
  const CommunityPostsScreen({super.key});

  @override
  State<CommunityPostsScreen> createState() => _CommunityPostsScreen();
}

class _CommunityPostsScreen extends State<CommunityPostsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);

    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 80, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "Voice Assistance",
                                  icon: Icons.assessment_rounded,
                                  size: size),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "Emergency call guide",
                                  icon: Icons.emergency_rounded,
                                  size: size),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "How to use Location",
                                  icon: Icons.directions,
                                  size: size),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "Object Detection",
                                  icon: Icons.camera_alt_rounded,
                                  size: size),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "Feature Navigation",
                                  icon: Icons.record_voice_over_rounded,
                                  size: size),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: GuideBox(
                                  title: "Community guide",
                                  icon: Icons.post_add_rounded,
                                  size: size),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: kAppBgColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            navigationHandler(
                                context, RouteConst.settingsScreen);
                          },
                          icon: Icon(
                            Icons.menu_rounded,
                            size: 40,
                            color: kPrimaryColor,
                          )),
                      GestureDetector(onTap: () {
                        navigationHandler(context, RouteConst.profileScreen);
                      }, child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            child: userCubit.userData != null &&
                                    userCubit.userData!.imageUrl != null &&
                                    userCubit.userData!.imageUrl != "null"
                                ? CircleAvatar(
                                    minRadius: 25,
                                    maxRadius: 25,
                                    backgroundColor: kLightGreyColor,
                                    foregroundImage: NetworkImage(userCubit
                                        .userData!.imageUrl
                                        .toString()),
                                    child: Icon(
                                      Icons.person,
                                      color: kGrey,
                                      size: 35,
                                    ),
                                  )
                                : CircleAvatar(
                                    minRadius: 25,
                                    maxRadius: 25,
                                    backgroundColor: kLightGreyColor,
                                    child: Icon(
                                      Icons.person,
                                      color: kGrey,
                                      size: 35,
                                    ),
                                  ),
                          );
                        },
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is Listning) {
              return Lottie.asset('assets/animations/assistant_circle.json',
                  width: 106, height: 106);
            } else {
              return const BottomNavBar(
                selectedIndex: 1,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
