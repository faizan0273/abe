import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? photoUrl;
  String? education;
  String? from;
  String? id;
  String? type;
  String? website;
  String? work;
  String? number;
  String? owner;
  String? about;

  UserModel(
      {this.username,
      this.email,
      this.id,
      this.photoUrl,
      this.type,
      this.about,
      this.from,
      this.education,
        this.number,
        this.owner,
        this.website,
        this.work,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['firstname']!=null?json['firstname']:""+" "+json['lastname']!=null?json['lastname']:"";
    email = json['email']!=null?json['email']:"";
    education = json['education']!=null?json['education']:"";
    photoUrl = json['photoUrl']!=null?json['photoUrl']:"";
    // signedUpAt = (json['signedUpAt']!=null?(json['signedUpAt'].toDate()) as Timestamp:"") as Timestamp?;
    // isOnline = (json['isOnline']!=null?json['isOnline']:"") as bool?;
    // lastSeen = (json['lastSeen']!=null?(json['lastSeen'].toDate())as Timestamp:"") as Timestamp?;
    from = json['from']!=null?json['from']:"";
    id = json['id']!=null?json['id']:"";
    type = json['type']!=null?json['type']:"";
    about = json['about']!=null?json['about']:"";
    owner = json['owner']!=null?json['owner']:"";
    website = json['website']!=null?json['website']:"";
    work = json['work']!=null?json['work']:"";
    number = json['number']!=null?json['number']:"";
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) => UserModel(
    username:doc.data().toString().contains('firstname')? doc.get('firstname') : '',
    email: doc.data().toString().contains('email')? doc.get('email') : '',
    photoUrl: doc.data().toString().contains('photoUrl')? doc.get('photoUrl') : '',
    // lastSeen: doc.data().toString().contains('time')? doc.get('time') : '',
    from: doc.data().toString().contains('number')? doc.get('number') : '',
    id: doc.data().toString().contains('id')? doc.get('id') : '',
    education: doc.data().toString().contains('education')? doc.get('education') : '',
    type: doc.data().toString().contains('type')? doc.get('type') : '',
    about: doc.data().toString().contains('about')? doc.get('about') : '',
    owner: doc.data().toString().contains('owner')? doc.get('owner') : '',
    work: doc.data().toString().contains('work')? doc.get('work') : '',
    website: doc.data().toString().contains('website')? doc.get('website') : '',
    // isOnline: doc.data().toString().contains('isOnline')? doc.get('isOnline') : '',
    // number: doc.data().toString().contains('number')? doc.get('number') : '',
    // signedUpAt: doc.data().toString().contains('signedUpAt')? doc.get('signedUpAt') : '',
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['education'] = this.education;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['from'] = this.from;
    // data['signedUpAt'] = this.signedUpAt;
    // data['isOnline'] = this.isOnline;
    // data['lastSeen'] = this.lastSeen;
    data['number'] = this.number;
    data['website'] = this.website;
    data['work'] = this.work;
    data['owner'] = this.owner;
    data['type'] = this.type;
    data['about'] = this.about;
    return data;
  }


}
