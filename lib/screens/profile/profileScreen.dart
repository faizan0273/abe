import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../chats/conversation.dart';
import '../../chats/recent_chats.dart';
import '../../components/stream_builder_wrapper.dart';
import '../../components/stream_grid_wrapper.dart';
import '../../container/drawer_container.dart';
import '../../models/message.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../utils/firebase.dart';
import '../../widgets/indicators.dart';
import '../../widgets/post_tiles.dart';
import '../../widgets/posts_view.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
class profile extends StatefulWidget {
  final String profileId;

  profile({required this.profileId});
  @override
  _profileScreenState createState() => _profileScreenState(this.profileId);
}

class _profileScreenState extends State<profile> {
  final profileId_;
  _profileScreenState(this.profileId_);
  bool isLoading = false;
  int postCount = 0;
  bool isToggle = true;
  bool add = false,accept=false, cancel=false,unfriend=false;
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }
  @override
  void initState() {
    checkIfFollowing();
    setState(() {
    });
    initialize();
    super.initState();
  }
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(profileId_!).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    userChatsStream(currentUserId());
    setState(() {
    });
  }
  String chatId_="newChat";
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
    return WillPopScope(
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
                  Expanded(
                    flex:1,
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
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
                              child:SvgPicture.asset("assets/back.svg",),
                              onTap: () => Navigator.of(context).pop(),

                            ),
                          ),
                        ]
                    ),
                  ),
                  widget.profileId == firebaseAuth.currentUser!.uid?Expanded(
                    flex:1,
                    child:Row(
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
                    ),
                  ):Container(),


                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white30.withOpacity(0.030),
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
                          )
                      ),
                    ),),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              users?.username!=''?Text("${users!.username}",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),):
                              Text("No name",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),)
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Business Consultant",style: TextStyle(fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              SvgPicture.asset("assets/community.svg",fit: BoxFit.none,),
                              SizedBox(width: 5,),
                              Text("Community",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Gilroy',fontSize: 15),)
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              StreamBuilder(
                                stream: friendsRef
                                    .doc(widget.profileId)
                                    .collection('friends')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    QuerySnapshot<Object?>? snap =
                                        snapshot.data;
                                    List<DocumentSnapshot> docs = snap!.docs;
                                    return buildCount(
                                        "Accquaintances", docs.length ?? 0);
                                  } else {
                                    return buildCount("Accquaintances", 0);
                                  }
                                },
                              ),
                            ],
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
                                              style: TextStyle(fontFamily: 'Gilroy'),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                  ),
                                                ),
                                                TextSpan(text: '154'),
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
                                              style: TextStyle(fontFamily: 'Gilroy'),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: SvgPicture.asset("assets/col.svg",fit: BoxFit.none,),
                                                  ),
                                                ),
                                                TextSpan(text: '154'),
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
                                              style: TextStyle(fontFamily: 'Gilroy'),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                  ),
                                                ),
                                                TextSpan(text: '154',style: TextStyle(fontFamily: 'Gilroy')),
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
                    users!.type=='Personal'?
                    Expanded(
                        flex: 1,
                        child: buildProfileButton()
                    ):SizedBox.shrink(),
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Conversation(userId: widget.profileId,chatId: chatId_,)));
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
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (val){
                    setState(() {
                      usersRef.doc(widget!.profileId).update({
                        'owner':'${val}',
                      });
                    });
                  },
                  enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_pin),
                    hintText:users!.owner==''?"Owner at":"${users!.owner}",
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
                      'work':'${appPass}',
                    });
                  },
                  enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.work),
                    hintText:users!.work!=''?"${users!.work}":'Works at',
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
                      'from':'${appPass}',
                    });
                  },
                  enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.pin_drop),
                    hintText:users!.from!=''?"${users!.from}":'From',
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
                      'education':'${appPass}',
                    });
                  },
                  enabled: firebaseAuth.currentUser?.uid==users!.id?true:false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.school),
                    hintText:users!.education!=''?"${users!.education}":'Education',
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
                              'Experience',
                              style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
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
                              style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
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
                              'Skills',
                              style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
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
                        style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
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
    ), onWillPop: () async => false);
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    print("Document Id:"+documentId);
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

   userChatsStream(String uid) async{
     chatRef
         .where('users', arrayContains:'${currentUserId()}')
         .get()
         .then((value) {
       value.docs.forEach((element) {
         chatRef
             .where('users', arrayContains:'${uid}')
             .get()
             .then((value) {
           value.docs.forEach((element) {
             chatId_=element.id;
             print("Hello: "+element.id);
           });
         });
       });
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

  Widget buildButton({String? text, Function()? function}) {
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

  buildProfileButton() {
    //if isMe then display "edit profile"
    bool isMe = widget.profileId == firebaseAuth.currentUser!.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {});
    }
    else if (accept) {
      return buildButton(
        text: "Accept",
        function: ()=>handleAcceptRequest(widget.profileId),
      );
    } else if (cancel) {
      return buildButton(
        text: "Cancel",
        function: ()=>handleCancelRequest(widget.profileId),
      );
    }
    else if (add) {
      return buildButton(
        text: "Add",
        function: ()=> handleSendRequest(widget.profileId),
      );
    } else if (unfriend) {
      return buildButton(
        text: "Unfriend",
        function: ()=> handleUnfriend(widget.profileId),
      );
    } else{
      return Container();
    }
  }

  buildCount(String label, int count) {
    return Row(
      children: <Widget>[
        SizedBox(width: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
      ],
    );
  }

  handleSendRequest(String? id)async{
    setState(() {
      add = false;
      cancel=true;
      accept=false;
      unfriend=false;
    });
    sentRef
        .doc(currentUserId())
        .collection('sentRequests')
        .doc(id)
        .set({});
    requestsRef
        .doc(id)
        .collection('Requests')
        .doc(currentUserId())
        .set({});
    suggestionRef
        .doc(currentUserId())
        .collection('suggestions')
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    suggestionRef
        .doc(id)
        .collection('suggestions')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleAcceptRequest(String? id)async{
    setState(() {
      add = false;
      cancel=false;
      accept=false;
      unfriend=true;
    });
    requestsRef
        .doc(currentUserId())
        .collection('Requests')
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    sentRef
        .doc(id)
        .collection('sentRequests')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    friendsRef
        .doc(currentUserId())
        .collection('friends')
        .doc(id)
        .set({});
    friendsRef
        .doc(id)
        .collection('friends')
        .doc(currentUserId())
        .set({});
  }

  handleCancelRequest(String? id)async{
    setState(() {
      add = true;
      cancel=false;
      accept=false;
      unfriend=false;
    });
    requestsRef
        .doc(id)
        .collection('requests')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    sentRef
        .doc(currentUserId())
        .collection('sentRequests')
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    suggestionRef
        .doc(currentUserId())
        .collection('suggestions')
        .doc(id)
        .set({});
    suggestionRef
        .doc(id)
        .collection('suggestions')
        .doc(currentUserId())
        .set({});
  }

  handleUnfriend(String? id)async{
    setState(() {
      add = true;
      cancel=false;
      accept=false;
      unfriend=false;
    });
    friendsRef
        .doc(currentUserId())
        .collection('friends')
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    friendsRef
        .doc(id)
        .collection('friends')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    suggestionRef
        .doc(currentUserId())
        .collection('suggestions')
        .doc(id)
        .set({});
    suggestionRef
        .doc(id)
        .collection('suggestions')
        .doc(currentUserId())
        .set({});


  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await suggestionRef
        .doc(widget.profileId)
        .collection('suggestions')
        .doc(currentUserId())
        .get();
    setState(() {
      add = doc.exists;
    });
    DocumentSnapshot doc1 = await sentRef
        .doc(widget.profileId)
        .collection('sentRequests')
        .doc(currentUserId())
        .get();
    setState(() {
      cancel = doc1.exists;
    });
    DocumentSnapshot doc2 = await requestsRef
        .doc(widget.profileId)
        .collection('Requests')
        .doc(currentUserId())
        .get();
    setState(() {
      accept = doc2.exists;
    });
    DocumentSnapshot doc3 = await friendsRef
        .doc(widget.profileId)
        .collection('friends')
        .doc(currentUserId())
        .get();
    setState(() {
      unfriend = doc3.exists;
    });
  }

}