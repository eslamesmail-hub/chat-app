import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: !isMe
                      ? Colors.grey.shade300
                      : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(14),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: !isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: !isMe ? 5 : null,
          right: isMe ? 5 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      //ignore: deprecated_member_use
      overflow: Overflow.visible,
    );
  }
}
