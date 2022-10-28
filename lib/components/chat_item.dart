import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abe/chats/conversation.dart';
import 'package:abe/components/text_time.dart';
import 'package:abe/models/enum/message_type.dart';
import 'package:abe/models/user.dart';
import 'package:abe/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../screens/components/chat_components/conversation_screen_ui.dart';

class ChatItem extends StatelessWidget {
  final String? userId;
  final Timestamp? time;
  final String? msg;
  final int? messageCount;
  final String? chatId;
  final MessageType? type;
  final String? currentUserId;

  ChatItem({
    Key? key,
    @required this.userId,
    @required this.time,
    @required this.msg,
    @required this.messageCount,
    @required this.chatId,
    @required this.type,
    @required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersRef.doc('$userId').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot documentSnapshot =
              snapshot.data as DocumentSnapshot<Object?>;
          UserModel user = UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>,
          );

          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Conversation(userId: user.id.toString(),chatId: this.chatId.toString(),)),
              );
            },
            leading: user?.photoUrl==''?
            CircleAvatar(
              backgroundImage: AssetImage("assets/avatar.jpg"),
              radius: 40.0,
            ):
            CircleAvatar(
              backgroundImage: NetworkImage(user!.photoUrl.toString()),
              radius: 40.0,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                user!.username!=null?
                Text(
                  user!.username.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy'
                  ),
                ):Text("No name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy'
                  ),),
              ],
            ),
            subtitle: Row(
              children: [Expanded(child: Text(
                msg.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Gilroy'
                ),
              ),),],),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  buildCounter(BuildContext context) {
    return StreamBuilder(
      stream: messageBodyStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data;
          Map usersReads = snap.get('reads') ?? {};
          int readCount = usersReads[currentUserId] ?? 0;
          int counter = messageCount! - readCount;
          if (counter == 0) {
            return SizedBox();
          } else {
            return Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 11,
                minHeight: 11,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child: Text(
                  "$counter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }

  Stream<DocumentSnapshot> messageBodyStream() {
    return chatRef.doc(chatId).snapshots();
  }
}
