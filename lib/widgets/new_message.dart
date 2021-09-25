import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntp/ntp.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _message = '';
  final _controller = new TextEditingController();
  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser?.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    DateTime _myTime;
    DateTime _ntpTime;

    _myTime = DateTime.now();

    final int offset = await NTP.getNtpOffset(localTime: _myTime);

    _ntpTime = _myTime.add(Duration(milliseconds: offset));
    if (_message != '')
      FirebaseFirestore.instance.collection('chats').add({
        'text': _message,
        'time': _ntpTime,
        'userId': user,
        'username': userData['username'],
        'userimage': userData['url'],
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              height: 60,
              child: SingleChildScrollView(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  enableSuggestions: true,
                  autocorrect: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
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
