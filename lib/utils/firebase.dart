import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
final Uuid uuid = Uuid();

// Collection refs
CollectionReference usersRef = firestore.collection('users');
CollectionReference chatRef = firestore.collection("chats");
CollectionReference postRef = firestore.collection('posts');
CollectionReference postRefC = firestore.collection('postsC');
CollectionReference storyRef = firestore.collection('posts');
CollectionReference commentRef = firestore.collection('comments');
CollectionReference notificationRef = firestore.collection('notifications');
CollectionReference followersRef = firestore.collection('followers');
CollectionReference followingRef = firestore.collection('following');
CollectionReference likesRef = firestore.collection('likes');
CollectionReference friendsRef = firestore.collection('friends');
CollectionReference requestsRef = firestore.collection('requests');
CollectionReference sentRef = firestore.collection('sent');
CollectionReference suggestionRef = firestore.collection('suggestions');
CollectionReference offerRef = firestore.collection('offers');
CollectionReference storiesRef = firestore.collection('story');

// Storage refs
Reference profilePic =storage.ref().child('profiles');
Reference posts =storage.ref().child('posts');