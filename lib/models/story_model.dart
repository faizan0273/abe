import 'package:abe/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum MediaType { image, video }

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final UserModel user;

  const Story(
      {required this.url,
        required this.media,
        required this.duration,
        required this.user});

  factory Story.fromDocumentSnapshot(DocumentSnapshot doc) => Story(
    url:doc.data().toString().contains('url')? doc.get('url') : '',
    media: doc.data().toString().contains('media')? doc.get('media') : '',
    duration: doc.data().toString().contains('duration')? doc.get('duration') : '',
    user: doc.data().toString().contains('user')? doc.get('user') : '',
  );
}