import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_box.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isGuideBtnClick = false;
    String guideName = "";

    void selectGuide() {
      setState(() {
        isGuideBtnClick = true;
      });
    }

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
                  const CommonAppBar(
                    appBarTitle: "Guide",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isGuideBtnClick
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    child: GuideBox(
                                        title: "Voice Assistance",
                                        icon: Icons.assessment_rounded,
                                        size: size),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
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
                                    child: GuideBox(
                                        title: "How to use Location",
                                        icon: Icons.directions,
                                        size: size),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GuideBox(
                                      title: "Object Detection",
                                      icon: Icons.camera_alt_rounded,
                                      size: size)
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  GuideBox(
                                      title: "Feature Navigation",
                                      icon: Icons.record_voice_over_rounded,
                                      size: size),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GuideBox(
                                      title: "Community guide",
                                      icon: Icons.post_add_rounded,
                                      size: size)
                                ],
                              )
                            ],
                          )
                        : SizedBox.shrink(),
                  )
                ],
              ),
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
