import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'mainProvider.dart';

class VoiceProvider with ChangeNotifier {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";


  VoiceProvider() {
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  bool get isListening => _isListening;
  String get text => _text;

  Future<void> _initSpeech() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (!available) {
        print('Speech recognition is not available on this device.');
      }
    } catch (e) {
      print('Error initializing speech recognition: $e');
    }
  }

  void listen(BuildContext context1) async {

    MainProvider mainProvider =
    Provider.of<MainProvider>(context1, listen: false);
    print("Function called");
    if (!_isListening) {
      try {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          _isListening = true;
          _speech.listen(
            onResult: (val) {
              _text = val.recognizedWords;
              mainProvider.geminiStream(_text);

              print(_text);
              notifyListeners();
            },
          );
        } else {
          print('Speech recognition is not available on this device.');
        }
      } catch (e) {
        print('Error starting speech recognition: $e');
      }
    } else {
      _isListening = false;
      _speech.stop();
      notifyListeners();
    }
    print("Function ended");
  }

  void clearText() {
    _text = '';
    notifyListeners();
  }
}
