import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firechat/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot ss) {
        if (ss.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        final chatDocs = ss.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) => MessageBubble(
            chatDocs[i]['text'],
            chatDocs[i]['userId'] == FirebaseAuth.instance.currentUser?.uid,
            ValueKey(chatDocs[i].id),
          ),
        );
      },
    );
  }
}
