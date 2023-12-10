import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/features/object_detection/domain/entities/object_recognition.dart';
import 'package:visionmate/features/object_detection/presentation/screens/models.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  late List<CameraDescription> cameras;
  int imageHeight = 0;
  int imageWidth = 0;
  final String model = yolo;

  List<dynamic> recognitions = [];

  StreamController<ObjectRecognitionEntity> streamController =
      StreamController();
  StreamSink<ObjectRecognitionEntity> get _detectionSink =>
      streamController.sink;
  Stream<ObjectRecognitionEntity> get detectionStream =>
      streamController.stream;

  late CameraController controller;
  bool isDetecting = false;
  bool isImageStreamStart = false;
  bool isCameraInitialized = false;
  bool isSearching = false;
  String objectName = "";

  ObjectDetectionCubit() : super(ObjectDetectionInitial());

  void init() {
    initCamera();
  }

  void dispose() {
    isSearching = false;
    emit(ObjectDetectInitial());
    streamController.close();
    controller.stopImageStream();
    controller.dispose();
  }

  void initCamera() async {
    emit(ObjectDetectionModelLoading());
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      await loadModel();
      emit(ObjectDetectionModelLoadingComplete());
    } else {
      print("Permission denied");
      emit(ObjectDetectionModelLoadingFailed());
    }
  }

  void searchObject(String objectName) {
    textToSpeech("Finding $objectName");
    isSearching = true;
    objectName = objectName;
  }

  Future<void> loadModel() async {
    String res;

    res = await Tflite.loadModel(
      model: "assets/yolov2_tiny.tflite",
      labels: "assets/yolov2_tiny.txt",
    ).toString();

    print(res);
  }

  void setRecognitions(recognitions, imageHeight, imageWidth) {
    recognitions = recognitions;
    imageHeight = imageHeight;
    imageWidth = imageWidth;
  }

  void objectDetection() {
    if (cameras == null || cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        isCameraInitialized = true;
        emit(ObjectDetectInitial());

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = DateTime.now().millisecondsSinceEpoch;

            if (model == mobilenet) {
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 2,
              ).then((recognitions) {
                int endTime = DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");

                setRecognitions(recognitions!, img.height, img.width);

                isDetecting = false;
              });
            } else if (model == posenet) {
              Tflite.runPoseNetOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 2,
              ).then((recognitions) {
                int endTime = DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");

                setRecognitions(recognitions!, img.height, img.width);

                isDetecting = false;
              });
            } else {
              Tflite.detectObjectOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                model: model == yolo ? "YOLO" : "SSDMobileNet",
                imageHeight: img.height,
                imageWidth: img.width,
                imageMean: model == yolo ? 0 : 127.5,
                imageStd: model == yolo ? 255.0 : 127.5,
                numResultsPerClass: 1,
                threshold: model == yolo ? 0.2 : 0.4,
              ).then((recognitions) {
                int endTime = DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");

                setRecognitions(recognitions!, img.height, img.width);
                ObjectRecognitionEntity objRecognition =
                    ObjectRecognitionEntity(
                        recognitions: recognitions,
                        imageHeight: img.height,
                        imageWidth: img.width);
                if (!streamController.isClosed && !isSearching) {
                  _detectionSink.add(objRecognition);
                } else if (!streamController.isClosed && isSearching) {
                  for (var items in recognitions) {
                    if (items['detectedClass'] == objectName) {
                      textToSpeech("$objectName found");
                      _detectionSink.add(objRecognition);
                    } else {
                      textToSpeech("Object Did n't found");
                    }
                  }
                } else {
                  streamController = StreamController();
                }
                isDetecting = false;
              });
            }
          }
        });
      });
    }
  }
}
