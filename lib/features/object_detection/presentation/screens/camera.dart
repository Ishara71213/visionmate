import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:visionmate/features/object_detection/presentation/bloc/ObjectDetection/object_detection_cubit.dart';

import 'dart:math' as math;

import 'models.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controllerr;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ObjectDetectionCubit>(context).objectDetection();
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (BlocProvider.of<ObjectDetectionCubit>(context).controller == null ||
            !BlocProvider.of<ObjectDetectionCubit>(context)
                .controller
                .value
                .isInitialized) {
          return Container();
        }

        var tmp = MediaQuery.of(context).size;
        var screenH = math.max(tmp.height, tmp.width);
        var screenW = math.min(tmp.height, tmp.width);
        tmp = BlocProvider.of<ObjectDetectionCubit>(context)
            .controller
            .value
            .previewSize!;
        var previewH = math.max(tmp.height, tmp.width);
        var previewW = math.min(tmp.height, tmp.width);
        var screenRatio = screenH / screenW;
        var previewRatio = previewH / previewW;

        return OverflowBox(
          maxHeight: screenRatio > previewRatio
              ? screenH
              : screenW / previewW * previewH,
          maxWidth: screenRatio > previewRatio
              ? screenH / previewH * previewW
              : screenW,
          child: CameraPreview(
              BlocProvider.of<ObjectDetectionCubit>(context).controller),
        );
      },
    );
  }
}
