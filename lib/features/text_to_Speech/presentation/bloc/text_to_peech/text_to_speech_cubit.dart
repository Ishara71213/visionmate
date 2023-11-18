import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';

part 'text_to_speech_state.dart';

class TextToSpeechCubit extends Cubit<TextToSpeechState> {
  TextToSpeechCubit() : super(TextToSpeechInitial());

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
    emit(TextToSpeechInitial());
  }

  Future<void> getFromCamera(BuildContext context) async {
    try {
      clearData();
      textToSpeech("Open Camera");
      final PickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (PickedFile != null) {
        File hqFile = await File(PickedFile!.path);
        XFile? compressedFile = await compressFile(hqFile);
        imageFile = File(compressedFile!.path);
        textToSpeech("Analizing Text");
        getRecognisedText(compressedFile, context);
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

  void getRecognisedText(XFile image, BuildContext context) async {
    try {
      emit(TextToSpeechStartRecognition());
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognisedText =
          await textRecognizer.processImage(inputImage);
      // final textDetector = GoogleMlKit.vision.textRecognizer();
      // RecognizedText recognisedText =
      //     await textDetector.processImage(inputImage);
      await textRecognizer.close();
      scannedText = "";
      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          scannedText = scannedText + line.text + "\n";
          readText = readText + line.text + "  ";
        }
      }
      emit(TextToSpeechSuccess());
      textToSpeech(readText);
    } catch (e) {
      textToSpeech("Some Error occured");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Some Error occured')));
    }
  }
}
