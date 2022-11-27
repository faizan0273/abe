import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? postId;
  String? ownerId;
  String? firstname;
  String? location;
  String? description;
  String? mediaUrl;
  Timestamp? timestamp;
  List<category> investor=[];
  List<category> partner=[];
  List<category> sponsor=[];





  PostModel({
    this.id,
    this.postId,
    this.ownerId,
    this.location,
    this.description,
    this.mediaUrl,
    this.firstname,
    this.timestamp,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    firstname= json['firstname'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
    investor=[category(amount: json['investor']['bronze']['amount'],benefits:json['investor']['bronze']['benefits']),
      category(amount: json['investor']['gold']['amount'],benefits:json['investor']['gold']['benefits']),
      category(amount: json['investor']['kind']['amount'],benefits:json['investor']['kind']['benefits']),
      category(amount: json['investor']['platinum']['amount'],benefits:json['investor']['platinum']['benefits']),
      category(amount: json['investor']['silver']['amount'],benefits:json['investor']['silver']['benefits']),];
    partner=[category(amount: json['partner']['bronze']['amount'],benefits:json['partner']['bronze']['benefits']),
      category(amount: json['partner']['gold']['amount'],benefits:json['partner']['gold']['benefits']),
      category(amount: json['partner']['kind']['amount'],benefits:json['partner']['kind']['benefits']),
      category(amount: json['partner']['platinum']['amount'],benefits:json['partner']['platinum']['benefits']),
      category(amount: json['partner']['silver']['amount'],benefits:json['partner']['silver']['benefits']),];
    sponsor=[category(amount: json['sponsor']['bronze']['amount'],benefits:json['sponsor']['bronze']['benefits']),
      category(amount: json['sponsor']['gold']['amount'],benefits:json['sponsor']['gold']['benefits']),
      category(amount: json['sponsor']['kind']['amount'],benefits:json['sponsor']['kind']['benefits']),
      category(amount: json['sponsor']['platinum']['amount'],benefits:json['sponsor']['platinum']['benefits']),
      category(amount: json['sponsor']['silver']['amount'],benefits:json['sponsor']['silver']['benefits']),];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['timestamp'] = this.timestamp;
    data['firstname'] = this.firstname;
    return data;
  }
}

class bronze{
  category? Category;
}
class platinum{
  category? Category;
}
class silver{
  category? Category;
}
class gold{
  category? Category;
}
class kind{
  category? Category;
}
class category{
  String? amount;
  String? benefits;

  category({
   this.amount,
   this.benefits
});
}