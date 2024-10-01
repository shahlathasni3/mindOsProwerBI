import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/ChatUser.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firesteore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing firebase storage
  // static FirebaseStorage storage = FirebaseStorage.instance;
  // for storing self information
  static late ChatUser me;
  // to return current user
  static User get user => auth.currentUser!;


  // for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('user').doc(user.uid).get().then((user) async {
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
        // log('My data: ${user.data()}');
      }
      else{
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for checking if user exist or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get())
        .exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();


    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email:user.email.toString(),
        about:"hey,iam using chatnest",
        image:user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken:''
    );
    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }



  // Create the "People Chatting Report"
  Future<void> saveChatData(String message) async {

    DateTime now =  DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();
    // Assume using Firebase Firestore
    await FirebaseFirestore.instance.collection('chat_reports').doc(id)
        .set({
      'message': message,
      'timestamp': now,
      'sender': user.displayName,
    },SetOptions(merge: true));
  }

// for updating user information
  static Future<void> updateUserInfo() async {
    await firestore.collection('user').doc(user.uid).update({
      'name' : me.name,
      'about' : me.about,
    });
  }


}


