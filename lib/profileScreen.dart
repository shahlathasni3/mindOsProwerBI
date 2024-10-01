import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'api/apis.dart';
import 'contWithGoogle.dart';
import 'helpers/dialogues.dart';
import 'main.dart';

class profileScreen extends StatefulWidget {
  // final ChatUser user;
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

//   final formKey = GlobalKey<FormState>();

  String? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: const Text("Profile Screen"),
        ),
      // floating button to add new user
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 15,bottom: 15),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red.shade400,
            onPressed: () async {

              Dialogues.showProgressBar(context);
              // for signout from app
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value){
                  // for hiding progress dialogue
                  Navigator.pop(context);
                  // for moving to home screeen
                  Navigator.pop(context);
                  // replace homescreen with login screen
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> contWithGoogle()));
                });
              });

            },icon: const Icon(Icons.logout),label: Text('Logout'),),
        ),


    );
  }
  // bottom sheet for picking a profile picture for user
  void showBottomsheet(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        builder: (_){
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: mq.height*.03,bottom: mq.height*.05),
            children: [
              Text('Pick Profile Picture.', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              // buttons
              SizedBox(height: mq.height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // pick from gallery button
                  ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

                        if(image != null){
                          log('Image path : ${image.path} -- MimeType: ${image.mimeType}');

                          setState(() {
                            images = image.path;
                          });
                          // APIs.updateProfilePicture(File(images!));
                          // diding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(), fixedSize: Size(mq.width*.3, mq.height*.15)),
                      child: Image.asset('images/addImage.png')
                  ),
                  // take picture from camera button
                  ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);

                        if(image != null){
                          log('Image path : ${image.path}');

                          setState(() {
                            images = image.path;
                          });
                          // APIs.updateProfilePicture(File(images!));
                          // hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(), fixedSize: Size(mq.width*.3, mq.height*.15)),
                      child: Image.asset('images/addCamera.jpg')
                  ),
                ],
              )
            ],
          );
        });

  }
}









