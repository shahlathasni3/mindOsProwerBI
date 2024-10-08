import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MainProvider extends ChangeNotifier {

  MainProvider() {
    flutterTts = ttsService.flutterTts;
  }
  final TTSService ttsService = TTSService();
  late final FlutterTts flutterTts;
  int amount = 0;
  Timer? _timer;
  String streamAnswer = '';
  final Gemini gemini = Gemini.instance;
  final TextEditingController controller = TextEditingController();


  // text-to-voice
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      try {
        await flutterTts.speak(text);
      } catch (e) {
        print("Error occurred while trying to speak: $e");
      }
    }
  }


  // integrate gemin
  void geminiStream(String text) async {
    controller.clear();
    try {
      await gemini.streamGenerateContent(text).forEach((event) {
        streamAnswer = event.output.toString();
        speak(streamAnswer);
        notifyListeners();
      });
    } catch (error) {
      print("Error occurred while streaming content: $error");
    }
    notifyListeners();
  }

}

// Audio text-to-speech service
class TTSService {
  final FlutterTts flutterTts;

  TTSService() : flutterTts = FlutterTts() {
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }
}