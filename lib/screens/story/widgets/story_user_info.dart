import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:abe/models/user.dart';

class StoryUserInfo extends StatelessWidget {
  final UserModel user;

  const StoryUserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 15.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.photoUrl!,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.username!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            size: 20.0,
            color: Colors.white,
          ),
          onPressed: () async => {},
        ),
      ],
    );
  }
}