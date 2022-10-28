import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:abe/components/notification_stream_wrapper.dart';
import 'package:abe/models/notification.dart';
import 'package:abe/utils/firebase.dart';
import 'package:abe/widgets/notification_items.dart';
import 'package:flutter_svg/svg.dart';

import '../../chats/recent_chats.dart';
import '../../container/drawer_container.dart';
import '../../models/user.dart';
import '../discover/discoverScreen.dart';
import '../homePage/homePageScreen.dart';
import '../page/pageScreen.dart';
import '../profile/profileScreen.dart';
import '../search/searchScreen.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0), // here the desired height
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Gilroy'),),
                      ],
                    )),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () => deleteAllItems(),
                            child: Text(
                              'CLEAR ALL',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.black26,thickness: 0.4,)
              ],
            ),
          )
      ),
      body: ListView(
        children: [
          getActivities(),
        ],
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
    );
  }

  getActivities() {
    return ActivityStreamWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: notificationRef
          .doc(currentUserId_())
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        ActivityModel activities = ActivityModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return ActivityItems(
          activity: activities,
        );
      },
    );
  }

  deleteAllItems() async {
//delete all notifications associated with the authenticated user
    QuerySnapshot notificationsSnap = await notificationRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notifications')
        .get();
    notificationsSnap.docs.forEach(
          (doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      },
    );
  }
}
