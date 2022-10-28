import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../chats/recent_chats.dart';
import '../../components/stream_builder_wrapper.dart';
import '../../components/stream_grid_wrapper.dart';
import '../../container/drawer_container.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../utils/firebase.dart';
import '../../widgets/post_tiles.dart';
import '../../widgets/posts_view.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

class pagee extends StatefulWidget {
  final String profileId;

  pagee({required this.profileId});
  @override
  _pageScreenState createState() => _pageScreenState(this.profileId);
}

class _pageScreenState extends State<pagee> {

  final profileId_;
  _pageScreenState(this.profileId_);
  User? user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isToggle = true;
  bool isFollowing = false;
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();
  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }
  @override
  void initState() {
    initialize();
    checkIfFollowing();
    setState(() {
    });
    super.initState();
  }
  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(profileId_!).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    setState(() {
    });
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _onItemTapped(int index) async {
    _selectedIndex = index;
    if (index < 5)
      if(index == 4) {
        scaffoldKey.currentState!.openEndDrawer(); // CHANGE THIS LINE
      }
      else{
        Navigator.pushReplacement(context,PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => _children[_selectedIndex],
        ));
      }
    if (firstsyncRequired == false && index != 2)
      setState(() {
        _selectedIndex = index;
      });
  }
  int _selectedIndex = 0;
  bool firstsyncRequired = false;
  final List<Widget> _children = [
    discover(),
    Chats(),
    Home(),
    search(),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child:WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            //padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(left: 10,top: 20),
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
                                onTap: () => Navigator.of(context).pop(),
                                child:SvgPicture.asset("assets/back.svg",)
                            ),
                          ),
                        ],
                      )),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.profileId==currentUserId()? Container(
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
                              child: IconButton(
                                  onPressed: (){
                                    firebaseAuth.signOut();
                                    Navigator.pushNamed(context, '/loginScreen',);
                                  },
                                  icon: Icon(
                                    Icons.logout,color: Colors.red,
                                    size: 15,
                                  ))
                          ):Container(),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.070),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(flex: 3,child: ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),//or 15.0
                          child: Container(
                            height: 140.0,
                            width: 140.0,
                            color: Colors.white,
                            child:users?.photoUrl==''?
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/avatar.jpg"),
                              radius: 20.0,
                            ):
                            CircleAvatar(
                              backgroundImage: NetworkImage(users!.photoUrl.toString()),
                              radius: 20.0,
                            ),
                          ),
                        ),),
                        Expanded(flex: 5,child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 27,),
                                      users?.username!=''?Text("${users!.username}",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),):
                                      Text("No name",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),)
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          StreamBuilder(
                                            stream: followersRef
                                                .doc(widget.profileId)
                                                .collection('userFollowers')
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasData) {
                                                QuerySnapshot<Object?>? snap =
                                                    snapshot.data;
                                                List<DocumentSnapshot> docs = snap!.docs;
                                                return buildCount(
                                                    "FOLLOWERS", docs.length ?? 0);
                                              } else {
                                                return buildCount("FOLLOWERS", 0);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      VerticalDivider(
                                        color: Colors.black,
                                        thickness: 0.6,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          StreamBuilder(
                                            stream: followingRef
                                                .doc(widget.profileId)
                                                .collection('userFollowing')
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasData) {
                                                QuerySnapshot<Object?>? snap =
                                                    snapshot.data;
                                                List<DocumentSnapshot> docs = snap!.docs;
                                                return buildCount(
                                                    "FOLLOWING", docs.length ?? 0);
                                              } else {
                                                return buildCount("FOLLOWING", 0);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(right: 5,left: 5),
                              height: 20,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: ()async{

                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.99),
                                                  blurRadius: 1,
                                                  offset: const Offset(0,0.5),
                                                )
                                              ],
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                    ),
                                                  ),
                                                  TextSpan(text: '154',style: TextStyle(fontFamily: 'Gilroy'),),
                                                ],
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: ()async{

                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.99),
                                                  blurRadius: 1,
                                                  offset: const Offset(0,0.5),
                                                )
                                              ],
                                            ),
                                            child:RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      child: SvgPicture.asset("assets/col.svg",fit: BoxFit.none,),
                                                    ),
                                                  ),
                                                  TextSpan(text: '154',style: TextStyle(fontFamily: 'Gilroy'),),
                                                ],
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: ()async{

                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.99),
                                                  blurRadius: 1,
                                                  offset: const Offset(0,0.5),
                                                )
                                              ],
                                            ),
                                            child:RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                    ),
                                                  ),
                                                  TextSpan(text: '154',style: TextStyle(fontFamily: 'Gilroy'),),
                                                ],
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: buildProfileButton(user)
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:SvgPicture.asset("assets/reviews.svg",fit: BoxFit.none,)
                                    ),
                                    Expanded(
                                      flex:2,
                                      child:Text(
                                        'Reviews',
                                        style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                      ), ),
                                  ],
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:SvgPicture.asset("assets/chat.svg",fit: BoxFit.none,)
                                    ),
                                    Expanded(
                                      flex:2,
                                      child:Text(
                                        'Inbox',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ), ),
                                  ],
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:SvgPicture.asset("assets/share.svg",fit: BoxFit.none,)
                                    ),
                                    Expanded(
                                      flex:2,
                                      child:Text(
                                        'Share',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ), ),
                                  ],
                                ),
                              ),
                            )
                        ),
                        InkWell(
                          child: Icon(
                            Icons.more_vert,color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5,),
                      Text("\nAbout",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5,),
                      users?.about!=''?
                      Text("${users?.about}",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),):Text("No About",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                    //controller: appPass,
                      onChanged: (appPass){
                        usersRef.doc(widget!.profileId).update({
                          'from':'${appPass}',
                        });
                      },
                      enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pin_drop),
                        hintText:users!.from!=''?"${users!.from}":'Office Location',
                        hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black),
                        // ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      )
                  ),
                  TextField(
                    //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                    //controller: appPass,
                      onChanged: (appPass){
                        usersRef.doc(widget!.profileId).update({
                          'mobile':'${appPass}',
                        });
                      },
                      enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mobile_screen_share_rounded),
                        hintText:users!.number!=''?"${users!.number}":'Mobile',
                        hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black),
                        // ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      )
                  ),
                  TextField(
                    //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                    //controller: appPass,
                      onChanged: (appPass){
                      },
                      enabled: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText:users!.email!=''?"${users!.email}":"Email",
                        hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black),
                        // ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      )
                  ),
                  TextField(
                    //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                    //controller: appPass,
                      onChanged: (appPass){
                        usersRef.doc(widget!.profileId).update({
                          'website':'${appPass}',
                        });
                      },
                      enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.ac_unit),
                        hintText:users!.website!=''?"${users!.website}":'Website',
                        hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black),
                        // ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      )
                  ),
                  SizedBox(height: 8,),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.0070),
                          blurRadius: 1,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Text(
                                  'Need Experience',
                                  style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Text(
                                  'Interests',
                                  style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()async{

                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.99),
                                      blurRadius: 1,
                                      offset: const Offset(0,0.5),
                                    )
                                  ],
                                ),
                                child: Text(
                                  'Specifity',
                                  style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: ()async{
                          Navigator.pushNamed(context, '/startUpScreen');
                        },
                        child: Container(
                          width: 190,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,)
                            ],
                          ),
                          child: Text(
                            'Posts',
                            style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: ()async{
                          Navigator.pushNamed(context, '/startUpScreen');
                        },
                        child: Container(
                          width: 190,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,)
                            ],
                          ),
                          child: Text(
                            'Commercials',
                            style: TextStyle(color: Colors.white,fontFamily: 'Gilroy' ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 0.4,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Feed",style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                      Spacer(),
                      buildIcons(),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      buildPostView()
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 0,
                  offset: const Offset(0,0.1),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Container(
                      //padding: const EdgeInsets.all(7),
                        child:SvgPicture.asset("assets/compass.svg",fit: BoxFit.none,)
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      //padding: const EdgeInsets.all(7),
                        child:SvgPicture.asset("assets/mail.svg",fit: BoxFit.none,)
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      //padding: const EdgeInsets.all(7),
                        child:SvgPicture.asset("assets/home.svg",fit: BoxFit.none,)

                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      //padding: const EdgeInsets.all(7),
                        child:SvgPicture.asset("assets/search.svg",fit: BoxFit.none,)
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      //padding: const EdgeInsets.all(7),
                        child:SvgPicture.asset("assets/three.svg",fit: BoxFit.none,)
                    ),
                    label: '',
                  ),

                ],
                currentIndex: _selectedIndex,
                selectedItemColor:  Colors.black.withOpacity(0.5),
                unselectedItemColor: Colors.black45,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: _onItemTapped,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
          endDrawer: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
            width: (width)/3,
            child: MainDrawer(),
          ),
        ),
      ),
    );
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
      ],
    );
  }

  handleUnfollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    //users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = false;
    });
    //remove follower
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove following
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove from notifications feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    //users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = true;
    });
    //updates the followers collection of the followed user
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .set({});
    //updates the following collection of the currentUser
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({});
    //update the notification feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": users?.username,
      "userId": users?.id,
      "userDp": users?.photoUrl,
      "timestamp": timestamp,
    });
  }

  buildPostView() {
    if (isToggle == true) {
      return buildGridPost();
    } else if (isToggle == false) {
      return buildPosts();
    }
  }

  buildIcons() {
    if (isToggle) {
      return IconButton(
          icon: Icon(Ionicons.list),
          onPressed: () {
            setState(() {
              isToggle = false;
            });
          });
    } else if (isToggle == false) {
      return IconButton(
        icon: Icon(Icons.grid_on),
        onPressed: () {
          setState(() {
            isToggle = true;
          });
        },
      );
    }
  }

  buildPosts() {
    return StreamBuilderWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      stream: postRef
          .where('ownerId', isEqualTo: this.profileId_)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        PostModel posts = PostModel.fromJson(
          snapshot.data() as Map<String, dynamic>,
        );
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Posts(
            post: posts,
          ),
        );
      },
    );
  }

  buildGridPost() {
    return StreamGridWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: postRef
          .where('ownerId', isEqualTo: this.profileId_)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        PostModel posts =
        PostModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return PostTile(
          post: posts,
        );
      },
    );
  }

  buildButton({String? text, Function()? function}) {
    return Center(
      child: GestureDetector(
        onTap: function!,
        child: Container(
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.99),
                blurRadius: 1,
                offset: const Offset(0,0.5),
              )
            ],
          ),
          child: text=='Edit Profile'?
          Text(
            '${text}',
            style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
          ):text=='Follow'?
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child:SvgPicture.asset("assets/add.svg",fit: BoxFit.none,)
              ),
              Expanded(
                flex:2,
                child:Text(
                  '${text}',
                  style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                ), ),
            ],
          ):Text(
            '${text}',
            style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
          ),
        ),
      ),
    );
  }

  buildProfileButton(user) {
    //if isMe then display "edit profile"
    bool isMe = widget.profileId == firebaseAuth.currentUser!.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {
            // Navigator.of(context).push(
            //   CupertinoPageRoute(
            //     builder: (_) => EditProfile(
            //       user: user,
            //     ),
            //   ),
            // );
          });
      //if you are already following the user then "unfollow"
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
      //if you are not following the user then "follow"
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }

}