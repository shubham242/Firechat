import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _message = '';
  final _controller = new TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser?.uid;
    if (_message != '')
      FirebaseFirestore.instance.collection('chats').add({
        'text': _message,
        'time': Timestamp.now(),
        'userId': user,
      });
    _controller.clear();
    _message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              height: 50,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Text Message',
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  setState(() {
                    _message = val;
                  });
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: _message.trim().isEmpty ? null : _sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
