import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/P0afF9dZopbgYQnbPz36/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot ss) {
          if (ss.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final documents = ss.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, int i) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/P0afF9dZopbgYQnbPz36/messages')
              .add({'text': 'Added'});
        },
      ),
    );
  }
}
