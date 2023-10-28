import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
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
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        navigationHandlerWithRemovePrevRoute(
                            context, RouteConst.homeViUserScreen);
                      },
                      icon: Icon(
                        Icons.menu_rounded,
                        size: 40,
                        color: kPrimaryColor,
                      )),
                  GestureDetector(
                    onTap: () {
                      navigationHandlerWithRemovePrevRoute(
                          context, RouteConst.profileScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kLightGreyColor,
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.supervised_user_circle_outlined,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Settings",
                      style: kTitleOneText,
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<UserCubit>(context)
                              .resetToInitialState();
                          BlocProvider.of<AuthCubit>(context).signOut();
                        },
                        child: const Text("logout")),
                    Text(BlocProvider.of<UserCubit>(context).userType),
                    Text(BlocProvider.of<UserCubit>(context)
                            .userData
                            ?.email
                            .toString() ??
                        ""),
                    Text(BlocProvider.of<ViuserCubit>(context)
                            .userInfo
                            ?.disability
                            .toString() ??
                        ""),
                    Text(BlocProvider.of<ViuserCubit>(context)
                            .userInfo
                            ?.visitLocation
                            ?.first
                            .locationName
                            .toString() ??
                        ""),
                  ],
                ),
              ),
            ],
          ),
        )),
        floatingActionButton: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
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
