import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class MainProvider extends ChangeNotifier{
  String streamAnswer = '';
  final Gemini gemini = Gemini.instance;
  final TextEditingController controller = TextEditingController();
  // integrate gemin
  void geminiStream(String text) async {
    controller.clear();
    try {
      await gemini.streamGenerateContent(text).forEach((event) {
        streamAnswer = event.output.toString();
        notifyListeners();
      });
    } catch (error) {
      print("Error occurred while streaming content: $error");
    }
    notifyListeners();
  }

  // Future<DocumentSnapshot> fetchUserDetails(String uid) async {
  //   return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  // }
  //
  // void getUserInfo() async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     DocumentSnapshot userSnapshot = await fetchUserDetails(currentUser.uid);
  //     Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  //     print("User details: ${userData}");
  //   }
  // }


}

