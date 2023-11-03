import 'package:flutter_tts/flutter_tts.dart';

class TTSController {
  FlutterTts flutterTts = FlutterTts();

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(0.5);
  }

  void speakText(String text) async {
    configureTts();
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
}
