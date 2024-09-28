import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ChatPage.dart';
import 'api/apis.dart';
import 'contWithGoogle.dart';
import 'homePage.dart';

class splashPage extends StatefulWidget {
  const splashPage({super.key});

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {

  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      // exit fullscreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if(APIs.auth.currentUser != null){
        log('\nUser: ${APIs.auth.currentUser}');
        // navigate home screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }else{
        // navigate login screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => contWithGoogle()));
      }

    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('mindOs',style: TextStyle(color: Color(0xFF1578CA),fontSize: 36, fontWeight: FontWeight.bold,fontFamily: 'inter'),),
            Text('Your all-in-one AI companion',style: TextStyle(color: Color(0xFF1578CA),fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'inter'),),
          ],
        ),
      ),
    );
  }
}
