import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guardian_default_screen.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:lottie/lottie.dart' as li;

class HomeGuardianUserScreen extends StatefulWidget {
  const HomeGuardianUserScreen({super.key});

  @override
  State<HomeGuardianUserScreen> createState() => _HomeGuardianUserScreenState();
}

class _HomeGuardianUserScreenState extends State<HomeGuardianUserScreen> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          navigationHandler(context, RouteConst.settingsScreen);
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
                                  foregroundImage: NetworkImage(
                                      userCubit.userData!.imageUrl.toString()),
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      BlocProvider.of<GuardianCubit>(context).wardEmail == ""
                          ? GuardianDefaultView()
                          : SizedBox.shrink()
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
              return li.Lottie.asset('assets/animations/assistant_circle.json',
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