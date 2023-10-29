import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:visionmate/core/util/functions/voice_command_handler.dart';
part 'speech_to_text_state.dart';

class SpeechToTextCubit extends Cubit<SpeechToTextState> {
  var _speechToText = stts.SpeechToText();
  String listenResult = "";
  double confidenceLevel = 0.0;
  bool isListning = false;

  SpeechToTextCubit() : super(SpeechToTextInitial()) {
    _speechToText = stts.SpeechToText();
  }

  Future<void> initial() async {
    try {
      _speechToText.stop();
    } on SocketException catch (_) {
      emit(SpeechToTextError());
    } catch (e) {
      print(e.toString());
      emit(SpeechToTextError());
    }
  }

  Future<void> listning(BuildContext context) async {
    try {
      if (!isListning) {
        bool available = await _speechToText.initialize(
          onStatus: (status) {
            print("$status");
          },
          onError: (errorNotification) {
            print("$errorNotification");
            emit(SpeechToTextError());
          },
        );
        if (available) {
          isListning == true;
          emit(Listning());
          await _speechToText.listen(
            onResult: (result) {
              listenResult =
                  result.alternates.last.recognizedWords?.toString() ?? "";
              confidenceLevel = result.confidence;
              if (result.finalResult) {
                emit(ListningComplete());
                executeVoiceCommand(context);
                print(result);
              }
            },
          );
        }
      } else {
        isListning = false;
        emit(SpeechToTextInitial());
        _speechToText.stop();
      }
    } on SocketException catch (_) {
      emit(SpeechToTextError());
    } catch (e) {
      print(e.toString());
      emit(SpeechToTextError());
    }
  }

  void executeVoiceCommand(BuildContext context) {
    try {
      voiceCommandHandler(context, listenResult, confidenceLevel);
      emit(SpeechToTextInitial());
    } catch (_) {
      emit(SpeechToTextError());
    }
  }
}
