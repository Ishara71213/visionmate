import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/features/object_detection/presentation/screens/models.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  late List<CameraDescription> cameras;
  List<dynamic> recognitions = [];
  int imageHeight = 0;
  int imageWidth = 0;
  final String model = yolo;

  ObjectDetectionCubit() : super(ObjectDetectionInitial()) {
    initCamera();
  }

  void initCamera() async {
    emit(ObjectDetectionModelLoading());
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      loadModel();
      emit(ObjectDetectionModelLoadingComplete());
    } else {
      print("Permission denied");
      emit(ObjectDetectionModelLoadingFailed());
    }
  }

  void loadModel() async {
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
    emit(ObjectDetected());
  }
}
