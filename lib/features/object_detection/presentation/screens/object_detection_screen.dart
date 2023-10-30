import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    ObjectDetectionCubit objectDetectionCubit =
        BlocProvider.of<ObjectDetectionCubit>(context);
    return BlocBuilder<ObjectDetectionCubit, ObjectDetectionState>(
      builder: (context, state) {
        if (state is ObjectDetectionModelLoading) {
          return const SplashScreenYoloModelLoader();
        } else {
          return Stack(
            children: [
              Camera(
                objectDetectionCubit.cameras,
                objectDetectionCubit.model,
                objectDetectionCubit.setRecognitions,
              ),
              BndBox(
                  objectDetectionCubit.recognitions == null
                      ? []
                      : objectDetectionCubit.recognitions,
                  math.max(objectDetectionCubit.imageHeight,
                      objectDetectionCubit.imageWidth),
                  math.min(objectDetectionCubit.imageHeight,
                      objectDetectionCubit.imageWidth),
                  screen.height,
                  screen.width,
                  objectDetectionCubit.model),
            ],
          );
        }
      },
    );
  }
}
