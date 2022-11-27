import 'package:cloud_firestore/cloud_firestore.dart';

class offerModel {
  String? benefits;
  String? category;
  String? page;
  String? amount;
  String? accept;
  offerModel(
      {this.benefits, this.category, this.page, this.amount, this.accept});

  factory offerModel.fromDocumentSnapshot(DocumentSnapshot doc) => offerModel(
    benefits: doc.data().toString().contains('benefits')? doc.get('benefits') : '',
    category: doc.data().toString().contains('category')? doc.get('category') : '',
    page: doc.data().toString().contains('page')? doc.get('page') : '',
    amount: doc.data().toString().contains('amount')? doc.get('amount') : '',
    accept: doc.data().toString().contains('accept')? doc.get('accept') : '',

  );
  offerModel.fromJson(Map<String, dynamic> json) {
    benefits = json['benefits'];
    category = json['category'];
    page = json['page'];
    amount = json['amount'];
    accept = json['accept'];
  }
}
