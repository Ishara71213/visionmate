import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/direct_phone_call.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/util/functions/url_luncher.dart';
import 'package:visionmate/core/util/functions/voice_command_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/features/text_to_Speech/presentation/bloc/text_to_peech/text_to_speech_cubit.dart';

class HomeViUserScreen extends StatefulWidget {
  const HomeViUserScreen({super.key});

  @override
  State<HomeViUserScreen> createState() => _HomeViUserScreenState();
}

class _HomeViUserScreenState extends State<HomeViUserScreen> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      onDoubleTap: () {
        phoneCallEmergency(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return CommonAppBar();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FilledButtonCustom(
                        onPressed: () {
                          navigationHandler(
                              context, RouteConst.objectDetectionScreen);
                        },
                        initText: "Object Detection",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButtonCustom(
                        onPressed: () {
                          navigationHandler(
                              context, RouteConst.colorDetectionScreen);
                        },
                        initText: "Color Detection",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButtonCustom(
                        onPressed: () {
                          navigationHandler(
                              context, RouteConst.textToSpeechScreen);
                        },
                        initText: "Text to Speech",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButtonCustom(
                        onPressed: () {
                          // BlocProvider.of<ViuserCubit>(context)
                          //     .getCurrrentUserdata();
                          navigationHandler(
                              context, RouteConst.connectCaneScreen);
                        },
                        initText: "Connect Cane",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButtonCustom(
                        onPressed: () {
                          navigationHandler(context, RouteConst.locationScreen);
                        },
                        initText: "Navigation Assistance",
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
                selectedIndex: 0,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
