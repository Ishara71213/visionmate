import 'package:equatable/equatable.dart';

class TextToSpeechEntity extends Equatable {
  final String recognitionText;

  const TextToSpeechEntity({this.recognitionText = ""});

  @override
  List<Object?> get props => [recognitionText];
}
