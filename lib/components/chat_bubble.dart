import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:abe/components/text_time.dart';
import 'package:abe/models/enum/message_type.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatefulWidget {
  final String? message;
  final MessageType? type;
  final Timestamp? time;
  final bool? isMe;

  ChatBubble({
    @required this.message,
    @required this.time,
    @required this.isMe,
    @required this.type,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Color? chatBubbleColor() {
    if (widget.isMe!) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.grey[800];
      } else {
        return Colors.grey[200];
      }
    }
  }

  Color? chatBubbleReplyColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Colors.grey[600];
    } else {
      return Colors.grey[50];
    }
  }

  @override
  Widget build(BuildContext context) {
    final align =
        widget.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = widget.isMe!
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: chatBubbleColor(),
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.all(widget.type == MessageType.TEXT ? 5 : 0),
                child: widget.type == MessageType.TEXT
                    ? Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      '${widget.message}',
                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: 'Gilroy'),
                    ),
                  ),
                )
                    : CachedNetworkImage(
                        imageUrl: "${widget.message}",
                        height: 200,
                        width: MediaQuery.of(context).size.width / 1.3,
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: widget.isMe!
              ? EdgeInsets.only(
                  right: 10.0,
                  bottom: 10.0,
                )
              : EdgeInsets.only(
                  left: 10.0,
                  bottom: 10.0,
                ),
          child: TextTime(
            child: Text(
              timeago.format(widget.time!.toDate()),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6!.color,
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
