import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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


  // integrate gemini
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



// add company specific data
class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addKnowledgeBaseEntry(String question, String answer) {
    return db.collection('knowledge_base').add({
      'question': question,
      'answer': answer,
    });
  }

  Future<List<Map<String, dynamic>>> getKnowledgeBase() async {
    final snapshot = await db.collection('knowledge_base').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

