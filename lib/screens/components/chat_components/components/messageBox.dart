import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/text_time.dart';
import '../../../../models/enum/message_type.dart';
import '../../../../models/user.dart';
import '../../../../utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../constants.dart';

class MessageBox extends StatelessWidget {
  final bool isMe;
  final String message;
  final String? sender;
  final String? reciepent;
  final MessageType? type;
  final Timestamp? time;
  MessageBox({
    Key? key,
    required this.isMe,
    required this.message,
    required this.sender,
    required this.reciepent,
    required this.type,
    required this.time,
  }) : super(key: key);
  @override
  void initState(){
    initialize();
  }
  UserModel? send=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  UserModel? receive=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(sender.toString()).get();
    DocumentSnapshot doc1 = await usersRef!.doc(reciepent.toString()).get();
    send = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    receive = UserModel.fromJson((doc1?.data()??{}) as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${send!.username}",style: TextStyle(fontFamily: 'Gilroy'),),
                SizedBox(width: 5,),
                send?.photoUrl==''?
                CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                  radius: 10.0,
                ):
                CircleAvatar(
                  backgroundImage: NetworkImage(send!.photoUrl.toString()),
                  radius: 10.0,
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 5,),
            type==MessageType.TEXT? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
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
                        message,
                        style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                )
              ],
            ): CachedNetworkImage(
              imageUrl: "${message}",
              height: 200,
              width: MediaQuery.of(context).size.width / 1.3,
              fit: BoxFit.cover,
            ),
            TextTime(
              child: Text(
                timeago.format(time!.toDate()),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6!.color,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                receive?.photoUrl==''?
                CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                  radius: 10.0,
                ):
                CircleAvatar(
                  backgroundImage: NetworkImage(receive!.photoUrl.toString()),
                  radius: 10.0,
                ),
                SizedBox(width: 5,),
                Text("${receive!.username}",style: TextStyle(fontFamily: 'Gilroy'),),
                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: 5,),
            type==MessageType.TEXT?Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                )
              ],
            ):CachedNetworkImage(
              imageUrl: "${message}",
              height: 200,
              width: MediaQuery.of(context).size.width / 1.3,
              fit: BoxFit.cover,
            ),
            TextTime(
              child: Text(
                timeago.format(time!.toDate()),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6!.color,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
