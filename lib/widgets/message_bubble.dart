import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String userImage;
  final String username;
  final Key key;
  final DateTime time;

  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isUser,
    this.key,
    this.time,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isUser
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isUser ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      !isUser ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              // margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              margin: EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: isUser ? 20 : 8,
                right: isUser ? 8 : 20,
              ),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isUser ? Colors.black : Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    message,
                    style: TextStyle(
                      color: isUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: !isUser ? 120 : null,
          right: isUser ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        Positioned(
          bottom: 6,
          left: !isUser ? 120 : null,
          right: isUser ? 120 : null,
          child: Text(
            (DateFormat('hh:mm').format(
              time,
            )),
            style: TextStyle(fontSize: 8),
          ),
        ),
      ],
    );
  }
}
