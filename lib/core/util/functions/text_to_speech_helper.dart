import 'package:flutter_tts/flutter_tts.dart';

void textToSpeech(String text) async {
  final FlutterTts tts = FlutterTts();
  await tts.setLanguage('en-US');
  await tts.setPitch(1);
  await tts.speak(text);
}
