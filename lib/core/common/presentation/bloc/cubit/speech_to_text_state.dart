part of 'speech_to_text_cubit.dart';

sealed class SpeechToTextState extends Equatable {
  const SpeechToTextState();

  @override
  List<Object> get props => [];
}

final class SpeechToTextInitial extends SpeechToTextState {
  @override
  List<Object> get props => [];
}

final class Listning extends SpeechToTextState {
  @override
  List<Object> get props => [];
}

final class ListningComplete extends SpeechToTextState {
  @override
  List<Object> get props => [];
}

final class SpeechToTextError extends SpeechToTextState {
  @override
  List<Object> get props => [];
}
