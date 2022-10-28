import 'package:flutter/material.dart';
import 'models/story_model.dart';
import 'models/user.dart';

final List<UserModel> UserModels = [
  UserModel(
      id: '1',
      username: 'Davis',
      photoUrl:
      'https://i.ibb.co/Sy7QVJT/Screen-Shot-2021-03-02-at-16-23-50.png'),
  UserModel(
      id: '2',
      username: 'Sophie',
      photoUrl:
      'https://i.ibb.co/wgNCCFV/Screen-Shot-2021-03-02-at-16-25-00.png'),
  UserModel(
      id: '3',
      username: 'Hannah',
      photoUrl:
      'https://i.ibb.co/LCMFqv9/Screen-Shot-2021-03-02-at-16-24-40.png'),
  UserModel(
      id: '4',
      username: 'Hook',
      photoUrl:
      'https://i.ibb.co/pR3NpJq/Screen-Shot-2021-03-02-at-16-23-59.png'),
  UserModel(
      id: '5',
      username: 'Lucy',
      photoUrl:
      'https://i.ibb.co/frBq8nn/Screen-Shot-2021-03-02-at-16-24-25.png'),
  UserModel(
      id: '6',
      username: 'Cristina',
      photoUrl:
      'https://i.ibb.co/pxfYF76/Screen-Shot-2021-03-02-at-16-24-31.png'),
  UserModel(
      id: '7',
      username: 'Sooobela',
      photoUrl:
      'https://i.ibb.co/pxfYF76/Screen-Shot-2021-03-02-at-16-24-31.png')
];


List<Story> stories = [
  Story(
    url: 'https://wallpapercave.com/wp/wp4558639.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 3),
    user: UserModels[0],
  ),
  Story(
    url: 'https://wallpapercave.com/wp/wp8279752.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: UserModels[1],
  ),
  Story(
    url: 'https://media.giphy.com/media/daU0tYcdd6m0ICvPYf/giphy.gif',
    media: MediaType.image,
    user: UserModels[2],
    duration: const Duration(seconds: 7),
  ),
  Story(
    url: 'https://ufile.io/f68lj8ou.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: UserModels[3],
  ),
  Story(
    url: 'https://wallpapercave.com/wp/wp5493715.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: UserModels[4],
  ),
  Story(
    url: 'https://wallpapercave.com/wp/wp8091469.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: UserModels[5],
  ),
  Story(
    url: 'https://media.giphy.com/media/uy4GDuYbzyv7i/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 4),
    user: UserModels[0],
  )
];