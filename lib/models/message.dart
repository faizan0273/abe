import 'package:abe/models/enum/message_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Message {
  String? content;
  String? senderUid;
  MessageType? type;
  Timestamp? time;

  Message({this.content, this.senderUid, this.type, this.time});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content']!=null?json['content']:"";
    senderUid = json['senderUid']!=null?json['senderUid']:"";
    if (json['type'] == 'text') {
      type = MessageType.TEXT;
    } else {
      type = MessageType.IMAGE;
    }
    time = json['time']!=null?json['time']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderUid'] = this.senderUid;
    if (this.type == MessageType.TEXT) {
      data['type'] = 'text';
    } else {
      data['type'] = 'image';
    }
    data['time'] = this.time;
    return data;
  }
}
