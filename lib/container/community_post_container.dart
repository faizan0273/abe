import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';

import '../components/custom_card.dart';
import '../components/custom_image.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../screens/comments/comment.dart';
import '../screens/view_image.dart';
import '../services/post_service.dart';
import '../utils/firebase.dart';

class CommunityPostContainer extends StatelessWidget {

  final PostModel? post;
  CommunityPostContainer({this.post});
  final DateTime timestamp = DateTime.now();
  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }
  final PostService services = PostService();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return ViewImage(post: post);
        },
        closedElevation: 0.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        onClosed: (v) {},
        closedColor: Theme
            .of(context)
            .cardColor,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // _PostHeader(),
                        //Padding(padding: const EdgeInsets.symmetric(vertical: 8),),
                        Container(
                          height: 180,
                          decoration:BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1,
                                offset: const Offset(0,0.2),
                              ),
                            ],
                          ),
                          child:Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: CustomImage(
                                  imageUrl: post?.mediaUrl ?? '',
                                  height: 150.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(width: 5,),
                                  buildLikeButton(),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: StreamBuilder(
                                        stream: likesRef
                                            .where('postId', isEqualTo: post!.postId)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.hasData) {
                                            QuerySnapshot snap = snapshot.data!;
                                            List<DocumentSnapshot> docs = snap.docs;
                                            return buildLikesCount(
                                                context, docs!.length ?? 0);
                                          } else {
                                            return buildLikesCount(context, 0);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (_) => Comments(post: post),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      CupertinoIcons.chat_bubble,
                                      size: 25.0,
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: commentRef
                                        .doc(post!.postId!)
                                        .collection("comments")
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        QuerySnapshot snap = snapshot.data!;
                                        List<DocumentSnapshot> docs = snap.docs;
                                        return buildCommentsCount(
                                            context, docs!.length ?? 0);
                                      } else {
                                        return buildCommentsCount(context, 0);
                                      }
                                    },
                                  ),
                                  SizedBox(width: 5,),
                                  SvgPicture.asset("assets/send.svg",),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
                      ],
                    ),
                  ),
                ],
              ),
              buildUser(context),
            ],
          );
        },
      ),
    );

  }

  buildLikeButton() {
    return StreamBuilder(
      stream: likesRef
          .where('postId', isEqualTo: post!.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];

          ///replaced this with an animated like button
          // return IconButton(
          //   onPressed: () {
          //     if (docs.isEmpty) {
          //       likesRef.add({
          //         'userId': currentUserId(),
          //         'postId': post!.postId,
          //         'dateCreated': Timestamp.now(),
          //       });
          //       addLikesToNotification();
          //     } else {
          //       likesRef.doc(docs[0].id).delete();
          //       services.removeLikeFromNotification(
          //           post!.ownerId!, post!.postId!, currentUserId());
          //     }
          //   },
          //   icon: docs.isEmpty
          //       ? Icon(
          //           CupertinoIcons.heart,
          //         )
          //       : Icon(
          //           CupertinoIcons.heart_fill,
          //           color: Colors.red,
          //         ),
          // );
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': post!.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification();
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              services.removeLikeFromNotification(
                  post!.ownerId!, post!.postId!, currentUserId());
              return isLiked;
            }
          }

          return LikeButton(
            onTap: onLikeButtonTapped,
            size: 25.0,
            circleColor:
            CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xffFFA500),
                dotSecondaryColor: Color(0xffd8392b),
                dotThirdColor: Color(0xffFF69B4),
                dotLastColor: Color(0xffff8c00)),
            likeBuilder: (bool isLiked) {
              return Icon(
                docs.isEmpty ? Ionicons.heart_outline : Ionicons.heart,
                color: docs.isEmpty ? Theme
                    .of(context)
                    .brightness == Brightness.dark ? Colors.white
                    : Colors.black
                    : Colors.red,
                size: 25,
              );
            },
          );
        }
        return Container();
      },
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addLikesToNotification(
        "like",
        user!.username!,
        currentUserId(),
        post!.postId!,
        post!.mediaUrl!,
        post!.ownerId!,
        user!.photoUrl!,
      );
    }
  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        '$count',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  buildCommentsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Text(
        '-   $count',
        style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildUser(BuildContext context) {
    bool isMe = currentUserId() == post!.ownerId;
    return StreamBuilder(
      stream: usersRef.doc(post!.ownerId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data!;
          UserModel user =
          UserModel.fromJson(snap.data() as Map<String, dynamic>);
          return Visibility(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => showProfile(context, profileId: user.id!),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        user.photoUrl!.isNotEmpty
                            ? CircleAvatar(
                          radius: 14.0,
                          backgroundColor: Color(0xff4D4D4D),
                          backgroundImage: CachedNetworkImageProvider(
                            user.photoUrl ?? "",
                          ),
                        )
                            : CircleAvatar(
                          radius: 14.0,
                          backgroundColor: Color(0xff4D4D4D),
                        ),
                        SizedBox(width: 5.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user?.username ?? ""}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4D4D4D),
                                fontFamily: 'Gilroy'
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  showProfile(BuildContext context, {String? profileId}) {
  }

}
