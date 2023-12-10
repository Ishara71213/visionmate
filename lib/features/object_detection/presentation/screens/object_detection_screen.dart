import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/object_detection/domain/entities/object_recognition.dart';
import 'package:visionmate/features/object_detection/presentation/bloc/ObjectDetection/object_detection_cubit.dart';
import 'package:visionmate/features/object_detection/presentation/widgets/splash_screen_yolo_model_loader.dart';

import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';

class ObjectDetectionScreen extends StatefulWidget {
  ObjectDetectionScreen({super.key}) {}

  @override
  State<ObjectDetectionScreen> createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  late ObjectDetectionCubit cubitref;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubitref = BlocProvider.of<ObjectDetectionCubit>(context);
  }

  @override
  void dispose() {
    cubitref.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ObjectDetectionCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    ObjectDetectionCubit objectDetectionCubit =
        BlocProvider.of<ObjectDetectionCubit>(context);
    return BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<ObjectDetectionCubit, ObjectDetectionState>(
            builder: (context, state) {
          if (state is ObjectDetectionModelLoading) {
            return const SplashScreenYoloModelLoader();
          }
          return GestureDetector(
            onLongPress: () {
              BlocProvider.of<SpeechToTextCubit>(context).listning(context);
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Camera(
                    objectDetectionCubit.cameras,
                    objectDetectionCubit.model,
                    objectDetectionCubit.setRecognitions,
                  ),
                  !objectDetectionCubit.streamController.isClosed
                      ? StreamBuilder<ObjectRecognitionEntity>(
                          stream: objectDetectionCubit.detectionStream,
                          initialData: const ObjectRecognitionEntity(),
                          builder: (context, snapshot) {
                            return BndBox(
                                snapshot.data!.recognitions == null
                                    ? []
                                    : snapshot.data!.recognitions,
                                math.max(snapshot.data!.imageHeight,
                                    snapshot.data!.imageWidth),
                                math.min(snapshot.data!.imageHeight,
                                    snapshot.data!.imageHeight),
                                screen.height,
                                screen.width,
                                objectDetectionCubit.model);
                          })
                      : Container(),
                  BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
                    builder: (context, state) {
                      if (state is Listning) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                    'assets/animations/assistant_circle.json',
                                    width: 106,
                                    height: 106),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
