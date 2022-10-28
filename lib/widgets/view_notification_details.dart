import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:abe/models/notification.dart';
import 'package:abe/widgets/indicators.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/user.dart';
import '../screens/page/pageScreen.dart';
import '../screens/profile/profileScreen.dart';
import '../utils/firebase.dart';

class ViewActivityDetails extends StatefulWidget {
  final ActivityModel? activity;

  ViewActivityDetails({this.activity});

  @override
  _ViewActivityDetailsState createState() => _ViewActivityDetailsState();
}

class _ViewActivityDetailsState extends State<ViewActivityDetails> {
  @override
  void initState() {
    initialize();
    setState(() {
    });
  }
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(currentUserId_()).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    setState(() {
    });
  }
  currentUserId_() {
    return firebaseAuth.currentUser!.uid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0), // here the desired height
          child: Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        //padding: EdgeInsets.only(left: 10),
                        //margin: EdgeInsets.only(left: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.9),
                              blurRadius: 2,
                              offset: const Offset(0,0.2),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          child:SvgPicture.asset("assets/back.svg",),
                          onTap: () => Navigator.of(context).pop(),

                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(top: 20),
                        child: Text("${users!.username}    ",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Gilroy'),),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        //padding: EdgeInsets.only(left: 10),
                        // margin: EdgeInsets.only(right: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.9),
                              blurRadius: 2,
                              offset: const Offset(0,0.2),
                            ),
                          ],
                        ),
                        child:InkWell(
                            onTap: (){
                              // Navigator.pushNamed(context, '/profileScreen',arguments:
                              // ScreenArguments(firebaseAuth.currentUser!.uid)
                              // );
                              if(users?.type=='Personal'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: firebaseAuth.currentUser!.uid,)));
                              }
                              else if(users?.type=='Business'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => pagee(profileId: firebaseAuth.currentUser!.uid,)));
                              }
                            },
                            child:users?.photoUrl==''?
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/avatar.jpg"),
                              radius: 40.0,
                            ):
                            CircleAvatar(
                              backgroundImage: NetworkImage(users!.photoUrl.toString()),
                              radius: 40.0,
                            )

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
      body: ListView(
        children: [
          buildImage(context),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            leading: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     CupertinoPageRoute(
                //       builder: (_) =>
                //           Profile(profileId: widget.activity!.userId),
                //     ));
              },
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(widget.activity!.userDp!),
              ),
            ),
            title: Text(
              widget.activity!.username!,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Row(
              children: [
                Icon(Ionicons.alarm_outline, size: 13.0),
                SizedBox(width: 3.0),
                Text(
                  timeago.format(widget.activity!.timestamp!.toDate()),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.activity?.commentData ?? "",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          imageUrl: widget.activity!.mediaUrl!,
          placeholder: (context, url) {
            return circularProgress(context);
          },
          errorWidget: (context, url, error) {
            return Icon(Icons.error);
          },
          height: 400.0,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
