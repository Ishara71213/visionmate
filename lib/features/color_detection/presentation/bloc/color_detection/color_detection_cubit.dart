import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';

part 'color_detection_state.dart';

class ColorDetectionCubit extends Cubit<ColorDetectiontate> {
  ColorDetectionCubit() : super(ColorDetectionInitial());

  File? imageFile;
  XFile? imageFileCompressed;
  String scannedText = "";
  String readText = "";

  void clearData() {
    imageFile = null;
    imageFileCompressed = null;
    scannedText = "";
    readText = "";
    textToSpeechStop();
    emit(ColorDetectionInitial());
  }

  Future<void> init() async {
    await loadModel();
  }

  Future<void> dispose() async {
    Tflite.close();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/color_detection_model/colordetection_model.tflite',
        labels: 'assets/color_detection_model/colordetection_labels.txt');
  }

  Future<void> getFromCamera(BuildContext context) async {
    try {
      clearData();
      textToSpeech("Open Camera");
      final PickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (PickedFile != null) {
        File hqFile = await File(PickedFile!.path);
        //XFile? compressedFile = await compressFile(hqFile);
        //imageFile = File(compressedFile!.path);
        textToSpeech("Analizing Text");
        print("Before runclor detection");
        getRecognisedColorText(hqFile, context);
      } else {
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image capture error')));
    }
  }

  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;
    final fileExtension = filePath.split('.').last.toLowerCase();
    final lastIndex = filePath.lastIndexOf('.');
    final splitted = filePath.substring(0, lastIndex);
    final outPath = "$splitted\_out.$fileExtension";
    var result;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
      // final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
      // final splitted = filePath.substring(0, (lastIndex));
      // final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 20,
      );
    } else if (fileExtension == 'png') {
      // Compress PNG images
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.png);
    } else if (fileExtension == 'heic') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.heic);
    } else if (fileExtension == 'webp') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.webp);
    } else {
      return XFile(file.path);
    }
    return result;
  }

  void getRecognisedColorText(File image, BuildContext context) async {
    print("execute fn");
    try {
      emit(ColorDetectionStartRecognition());
      print('Inside try');
      var results = await Tflite.runModelOnImage(
          path: image.path,
          numResults: 5,
          threshold: 0.6,
          imageMean: 127.5,
          imageStd: 127.5);
      print(results.toString());
      scannedText = "";
      readText = "";
      if (results != null && results.length > 0) {
        var confidence = ((results.first?['confidence'] ?? 0) * 100).round();
        var name = results.first['label'] ?? "";
        scannedText = '$name color and confidence is $confidence%';
        readText = '$name color and confidence is $confidence precent';
      } else {
        readText = "Can't Iidentify color";
      }
      print(scannedText);
      print("function running");
      emit(ColorDetectionSuccess());
      textToSpeech(readText);
    } catch (e) {
      textToSpeech("Some Error occured");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Some Error occured')));
    }
  }
}
