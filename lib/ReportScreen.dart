import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/ChatUser.dart';

class UserReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Report")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs.map((doc) => ChatUser.fromJson(doc.data() as Map<String, dynamic>)).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                ),
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${user.email}"),
                    Text("About: ${user.about}"),
                    Text("Created At: ${DateTime.fromMillisecondsSinceEpoch(int.parse(user.createdAt))}"),
                    Text("Last Active: ${DateTime.fromMillisecondsSinceEpoch(int.parse(user.lastActive))}"),
                    Text("Online: ${user.isOnline ? 'Yes' : 'No'}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

