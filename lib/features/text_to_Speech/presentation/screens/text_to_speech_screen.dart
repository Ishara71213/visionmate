import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/text_to_Speech/presentation/bloc/text_to_peech/text_to_speech_cubit.dart';

class TextToSpeechScreen extends StatefulWidget {
  const TextToSpeechScreen({super.key});

  @override
  State<TextToSpeechScreen> createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  @override
  void dispose() {
    textToSpeechStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextToSpeechCubit textToSpeechCubit =
        BlocProvider.of<TextToSpeechCubit>(context);
    return GestureDetector(
      onLongPress: () {
        textToSpeechStop();
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 75, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 18),
                          GestureDetector(onTap: () {
                            textToSpeechCubit.getFromCamera(context);
                          }, child:
                              BlocBuilder<TextToSpeechCubit, TextToSpeechState>(
                            builder: (context, state) {
                              if (state is TextToSpeechSuccess) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF4F4F4),
                                      borderRadius: BorderRadius.circular(14)),
                                  width: (size.width - 32),
                                  height: (size.height / 1.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          BlocProvider.of<TextToSpeechCubit>(
                                                  context)
                                              .scannedText,
                                          style: kTextRecognitionText,
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                    width: (size.width - 32),
                                    height: (size.height / 1.5),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                            'assets/animations/text_scanner.json',
                                            width: size.width,
                                            height: size.width),
                                        state is TextToSpeechStartRecognition
                                            ? Text(
                                                "Analizing",
                                                style: kOnboardScreenTitle,
                                              )
                                            : Text(
                                                "Click To Scan",
                                                style: kOnboardScreenTitle,
                                              ),
                                      ],
                                    ));
                              }
                            },
                          )),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(color: kAppBgColor),
                    child: const CommonAppBar(
                      appBarTitle: "Text To Speech",
                    )),
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
