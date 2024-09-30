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




}


