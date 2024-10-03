import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindos_2/ChatPage.dart';
import 'package:mindos_2/helpers/dialogues.dart';
import 'package:mindos_2/models/ChatUser.dart';
import 'api/apis.dart';

class profileScreen extends StatefulWidget {

  final ChatUser user;

  const profileScreen({super.key,required this.user});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    var mq;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap : (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> ChatPage()));
        },child: const Icon(Icons.arrow_back)),
        title: Text("Profile Screen",style: TextStyle(
          color: Colors.black, // Text color
          fontSize: 21,
          fontWeight: FontWeight.w500,// Font size
        ),),

      ),

      // floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15,bottom: 15),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.red.shade700,
          onPressed: () async {
            Dialogues.showProgressBar(context);
            await APIs.auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
              });
            });

          },icon: const Icon(Icons.logout),label: Text("Logout"),),
      ),


    );
  }
}
