import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mindos_2/homePage.dart';
import 'package:mindos_2/provider/mainProvider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'api/apis.dart';
import 'models/ChatUser.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatUser> list = [];
  final Gemini gemini = Gemini.instance;

  @override
  Widget build(BuildContext context) {
    // Define mq as MediaQuery
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1578CA), // Set the background color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),

        title: Center(
              child: Text(
                'mindOs',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 21,
                  fontWeight: FontWeight.bold,// Font size
                ),
              ),
            ),
        actions: [
          // PowerBI Button
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => profileScreen(user: APIs.me,)));
                  },
                  icon: const Icon(Icons.more_vert,color: Colors.white,)),
            ],
          ),
        ],
      ),
      body:Consumer<MainProvider>(
        builder: (context, value100, child) {
          return StreamBuilder(
            stream: APIs.firestore.collection('users').snapshots(),
            builder:(context,snapshot) {

              switch(snapshot.connectionState){
                // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator(),);
                // if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:

                  final data = snapshot.data?.docs;
                  for(var i in data!){
                     print('Data: ${jsonEncode(i.data())}');
                      // list.add(i.data()['name']);
                  }

                  return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Container(
                          height: mq.height * 1.5,
                          width: mq.width,
                          decoration: BoxDecoration(
                          color: Color(0xFFFCF7F7),
                      ),
                      child: Column(
                          children: [
                              // Padding(
                              //     padding: EdgeInsets.only(top: 154, left: 150),
                              //     child: Container(
                              //         height: mq.height * 0.074,
                              //         width: mq.width * 0.539,
                              //         decoration: BoxDecoration(
                              //         color: Color(0xffEAECEE),
                              //         borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(25),
                              //         topRight: Radius.circular(25),
                              //         bottomLeft: Radius.circular(25),
                              //         bottomRight: Radius.circular(0))),
                              //         child: Padding(
                              //             padding: const EdgeInsets.only(top: 13, left: 13),
                              //             child: Text(
                              //                 'What is Flutter. when flutter was developed?',
                              //                 style: TextStyle(
                              //                     fontSize: 14,
                              //                     color: Color(0xFF1578CA),
                              //                 ),
                              //             ),
                              //
                              //         ),
                              //     ),
                              // ),
                              Padding(
                                  padding: EdgeInsets.only(top: 24, right: 15),
                                      child: Container(
                                          // height: height * 0.474,
                                          width: mq.width * 0.879,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF1578CA),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                  bottomLeft: Radius.circular(0),
                                                  bottomRight: Radius.circular(25))),
                                              child: Padding(
                                                  padding: const EdgeInsets.only(top: 13, left: 13),
                                                  child: Column(
                                                      children: [
                                                          ReadMoreText(
                                                            value100.streamAnswer,
                                                              style: TextStyle(
                                                                  color: Color(0xffffffff), fontSize: 15),
                                                                  trimLines: 3,
                                                                  colorClickableText: Color(0xFF8AC6F7),
                                                                  trimMode: TrimMode.Line,
                                                                  trimCollapsedText: 'Read more',
                                                                  trimExpandedText: 'Read less',
                                                                  moreStyle: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Color(0xFFFCF7F7),
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
          );
        }
      ), // Add body content here
      bottomNavigationBar: Consumer<MainProvider>(
        builder: (context,value120,child) {
          return Container(
            height: mq.height*.13,
            decoration: BoxDecoration(
              color: Color(0xFFA7CDE9),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 20,
                  ),
                  child: Container(
                    height: mq.height * 0.06,
                    width: mq.width * 0.71,
                    decoration: BoxDecoration(
                        color: Color(0xFF1578CA),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 7, top: 5),
                      child: TextField(
                        controller: value120.controller,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'Enter a prompt here...',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 11),
                  child: Consumer<MainProvider>(
                    builder: (context,value10,child) {
                      return InkWell(

                        onTap: () async {
                          value10.geminiStream(value120.controller.text);

                          // Get the message from the TextField
                          final message = value120.controller.text.trim();

                          if (message.isNotEmpty) {
                            // Save the chat data to Firestore
                            await APIs().saveChatData(message);

                            // Clear the TextField after sending
                            value120.controller.clear();

                            // Call the Gemini stream function to get a response
                            value10.geminiStream(message);
                          }
                        },

                        child: Container(
                          height: mq.height * 0.06,
                          width: mq.width * 0.145,
                          decoration: BoxDecoration(
                              color: Color(0xFF1578CA),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.send,
                              color: Color(0xffffffff),
                              // size: height * 0.035,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
