import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String username;
  final Key key;

  MessageBubble(this.message, this.username, this.isUser, this.key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isUser ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isUser ? Radius.circular(12) : Radius.circular(0),
              bottomRight: !isUser ? Radius.circular(12) : Radius.circular(0),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isUser
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.title?.color,
                ),
              ),
              SizedBox(height: 5),
              Text(
                message,
                style: TextStyle(
                    color: isUser
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.title?.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
