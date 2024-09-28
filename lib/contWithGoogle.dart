import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindos_2/homePage.dart';
import 'ChatPage.dart';
import 'api/apis.dart';
import 'helpers/dialogues.dart';

class contWithGoogle extends StatefulWidget {
  const contWithGoogle({super.key});

  @override
  State<contWithGoogle> createState() => _contWithGoogleState();
}

class _contWithGoogleState extends State<contWithGoogle> {

  // handles google login btn click
  handleGooglebtnClick(){
    // for showing circular progressbar
    Dialogues.showProgressBar(context);
    signInWithGoogle().then((user) async {
      // for hiding progress bar
      Navigator.pop(context);

      if(user != null){
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }

    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    }
    catch(e){
      log('\nsignInWithGoogle: $e');
      Dialogues.showSnackbar(context,'Something went wrong (Check internet!)');
      return null;
    }
  }

  // signOut
  signOut() async {
    // Then, sign out from Firebase authentication
    await FirebaseAuth.instance.signOut();
    // First, sign out from Google
    await GoogleSignIn().signOut();
  }


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        decoration: BoxDecoration(
          color: Color(0xFFE7E7E7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('mindOs',style: TextStyle(color: Color(0xFF1578CA),fontSize: 36, fontWeight: FontWeight.bold,fontFamily: 'inter'),),
                Text('Your all-in-one AI companion',style: TextStyle(color: Color(0xFF1578CA),fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'inter'),),
              ],
            ),


            // login button
            Padding(
              padding: EdgeInsets.only(top: height / 2.7),
              child: InkWell(
                onTap: () {
                  handleGooglebtnClick();
                },
                child: Container(
                  height: height / 5/3,
                  width: width / 5*3.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xFFEAECEE)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/conWithGoogle/google-icon.png',scale: 20,),
                      SizedBox(width: 25,),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'inter',
                          color: Color(0xFF1578CA),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
