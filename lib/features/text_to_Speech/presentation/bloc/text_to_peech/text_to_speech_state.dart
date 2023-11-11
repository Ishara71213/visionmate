part of 'text_to_speech_cubit.dart';

sealed class TextToSpeechState extends Equatable {
  const TextToSpeechState();

  @override
  List<Object> get props => [];
}

final class TextToSpeechInitial extends TextToSpeechState {}

final class TextToSpeechOpenCamera extends TextToSpeechState {}

final class TextToSpeechStartRecognition extends TextToSpeechState {}

final class TextToSpeechSuccess extends TextToSpeechState {}

final class TextToSpeechFailed extends TextToSpeechState {}
