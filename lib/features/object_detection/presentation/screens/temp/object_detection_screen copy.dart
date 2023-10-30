import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  State<ObjectDetectionScreen> createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  bool isCameraInitialized = false;
  // late CameraImage cameraImage;
  int cameraCount = 0;

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );
      cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 30 == 0) {
            //setState(() {
            objectDetector(image);
            cameraCount = 0;
            setState(() {});
          }
        });
        // }
        //});
      });
      setState(() {
        isCameraInitialized = true;
      });
    } else {
      print("Permission denied");
    }
  }

  initTfLite() async {
    await Tflite.loadModel(
        model: "assets/objectRecognitionModel/yolov2_tiny.tflite",
        labels: "assets/objectRecognitionModel/yolov2_tiny.tflite",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false);
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e) => e.bytes).toList(),
        asynch: false,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0,
        imageStd: 255.0,
        numResults: 1,
        rotation: 90,
        threshold: 0.2);

    if (detector != null) {
      print("result is : $detector");
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    initTfLite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        body: isCameraInitialized
            ? CameraPreview(
                cameraController,
                child: SizedBox(
                  height: 400,
                ),
              )
            : const Center(child: Text("Loading")));
  }
}
