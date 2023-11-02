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
    // if (widget.cameras == null || widget.cameras.length < 1) {
    //   print('No camera is found');
    // } else {
    //   controller = new CameraController(
    //     widget.cameras[0],
    //     ResolutionPreset.high,
    //   );
    //   controller.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});

    //     controller.startImageStream((CameraImage img) {
    //       if (!isDetecting) {
    //         isDetecting = true;

    //         int startTime = new DateTime.now().millisecondsSinceEpoch;

    //         if (widget.model == mobilenet) {
    //           Tflite.runModelOnFrame(
    //             bytesList: img.planes.map((plane) {
    //               return plane.bytes;
    //             }).toList(),
    //             imageHeight: img.height,
    //             imageWidth: img.width,
    //             numResults: 2,
    //           ).then((recognitions) {
    //             int endTime = new DateTime.now().millisecondsSinceEpoch;
    //             print("Detection took ${endTime - startTime}");

    //             widget.setRecognitions(recognitions!, img.height, img.width);

    //             isDetecting = false;
    //           });
    //         } else if (widget.model == posenet) {
    //           Tflite.runPoseNetOnFrame(
    //             bytesList: img.planes.map((plane) {
    //               return plane.bytes;
    //             }).toList(),
    //             imageHeight: img.height,
    //             imageWidth: img.width,
    //             numResults: 2,
    //           ).then((recognitions) {
    //             int endTime = new DateTime.now().millisecondsSinceEpoch;
    //             print("Detection took ${endTime - startTime}");

    //             widget.setRecognitions(recognitions!, img.height, img.width);

    //             isDetecting = false;
    //           });
    //         } else {
    //           Tflite.detectObjectOnFrame(
    //             bytesList: img.planes.map((plane) {
    //               return plane.bytes;
    //             }).toList(),
    //             model: widget.model == yolo ? "YOLO" : "SSDMobileNet",
    //             imageHeight: img.height,
    //             imageWidth: img.width,
    //             imageMean: widget.model == yolo ? 0 : 127.5,
    //             imageStd: widget.model == yolo ? 255.0 : 127.5,
    //             numResultsPerClass: 1,
    //             threshold: widget.model == yolo ? 0.2 : 0.4,
    //           ).then((recognitions) {
    //             int endTime = new DateTime.now().millisecondsSinceEpoch;
    //             print("Detection took ${endTime - startTime}");

    //             widget.setRecognitions(recognitions!, img.height, img.width);

    //             isDetecting = false;
    //           });
    //         }
    //       }
    //     });
    //   });
    // }
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
