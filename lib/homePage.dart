import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindos_2/api/apis.dart';
import 'package:mindos_2/models/ChatUser.dart';

import 'chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ChatUser> list =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: Text("mindOs",style: TextStyle(
                  color: Colors.blueAccent, // Text color
                  fontSize: 21,
                  fontWeight: FontWeight.bold,// Font size
                ),),
        actions: [
          // PowerBI Button
        Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    // Action for the button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                  ),
                  child: Text('PowerBI'),
                ),
        ),
        ],
      ),
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot){
          // final list =[];
          switch(snapshot.connectionState){
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator(),);

              // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  // for(var i in data!){
                  //   print('Dta : ${jsonEncode(i.data())}');
                  //   list.add(i.data()['name']);
                  // }
                  list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                  return ListView.builder(
                    itemCount: list.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return chat_user_card(user: list[index],);
                      // return Text('name : ${list[index]}');
                    });
          }

        },
      ),
    );
  }
}