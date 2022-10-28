import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../chats/recent_chats.dart';
import '../../container/drawer_container.dart';
import '../../models/user.dart';
import '../../utils/firebase.dart';
import '../../widgets/indicators.dart';
import '../discover/discoverScreen.dart';
import '../homePage/homePageScreen.dart';
import '../page/pageScreen.dart';
import '../search/searchScreen.dart';
import '../view_image.dart';
import '../whatsapp_home.dart';
import 'friend_card_row.dart';

// ignore: must_be_immutable
class FriendsTab extends StatefulWidget {
  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  @override
  // ignore: must_call_super
  void initState() {
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
    return
      DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: 900,
              child: Column(
                children: [
                  Container(

                    height: 50,
                    child: TabBar(
                        onTap: (index) {
                        },
                        indicatorColor: Colors.black54,
                        isScrollable: true,
                        labelColor: Colors.black,
                        // backgroundColor: Colors.red,
                        // unselectedBackgroundColor: Colors.grey[300],
                        // unselectedLabelStyle: TextStyle(color: Colors.black),
                        // labelStyle: TextStyle(
                        //     color: Colors.red, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            // child: InkWell(
                            //     onTap: () {
                            //       friendController.getAlluser();
                            //     },
                            //     child: Text('tapp')),
                            // icon: Icon(Icons.directions_car),
                            text: "Suggestions",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "Requests",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "Friends",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "Sents",
                          )
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        suggestedFirends(),
                        requests(),
                        friends(),
                        sent(),
                      ],
                    ),
                  ),
                ],
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
          )
      );
  }

  suggestedFirends(){
    return StreamBuilder(
      stream: suggestionRef
          .doc(currentUserId())
          .collection('suggestions').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot>? docs = snapshot.data!.docs as List<DocumentSnapshot<Object?>>;
          return ListView.builder(
            itemCount: docs!.length,
              itemBuilder: (BuildContext context, int index){
            return docs!.length>0?
              FutureBuilder(
              future: getUsers(docs[index]!.id),
                builder: (context, AsyncSnapshot<UserModel> snapshot){
                return snapshot.data!=null?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                            },
                            child: snapshot?.data?.photoUrl==''?
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/avatar.jpg"),
                              radius: 40.0,
                            ):
                            CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.photoUrl.toString()),
                              radius: 40.0,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: snapshot?.data!.username!=''?
                            Text(
                              "${snapshot?.data!.username}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ):Text(
                              "No Name",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: ()=>handleSendRequest(snapshot?.data!.id),
                              child: Card(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Add Friend",
                                        style: TextStyle(fontSize: 14,color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Container();
                }):Container();
          });
        } else {
          return Container();
        }
      },
    );
  }

  sent(){
    return StreamBuilder(
      stream: sentRef
          .doc(currentUserId())
          .collection('sentRequests').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs as List<DocumentSnapshot<Object?>>;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index){
                return FutureBuilder(
                    future: getUsers(docs[index].id),
                    builder: (context, AsyncSnapshot<UserModel> snapshot){
                      return snapshot.data!=null?Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                  },
                                  child: snapshot.data?.photoUrl==''?
                                  CircleAvatar(
                                    backgroundImage: AssetImage("assets/avatar.jpg"),
                                    radius: 40.0,
                                  ):
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.photoUrl.toString()),
                                    radius: 40.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${snapshot.data!.username}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: ()=>handleCancelRequest(snapshot.data!.id),
                                    child: Card(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Cancel Request",
                                              style: TextStyle(fontSize: 14,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):Container();
                    });
              });
        } else {
          return Container();
        }
      },
    );
  }

  friends(){
    return StreamBuilder(
      stream: friendsRef
          .doc(currentUserId())
          .collection('friends').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs as List<DocumentSnapshot<Object?>>;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index){
                return FutureBuilder(
                    future: getUsers(docs[index].id),
                    builder: (context, AsyncSnapshot<UserModel> snapshot){
                      return snapshot.data!=null?Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                  },
                                  child: snapshot.data?.photoUrl==''?
                                  CircleAvatar(
                                    backgroundImage: AssetImage("assets/avatar.jpg"),
                                    radius: 40.0,
                                  ):
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.photoUrl.toString()),
                                    radius: 40.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${snapshot.data!.username}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: ()=>handleUnfriend(snapshot.data!.id),
                                    child: Card(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Un Friend",
                                              style: TextStyle(fontSize: 14,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):Container();
                    });
              });
        } else {
          return Container();
        }
      },
    );
  }

  requests(){
    return StreamBuilder(
      stream: requestsRef
          .doc(currentUserId())
          .collection('Requests').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs as List<DocumentSnapshot<Object?>>;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index){
                return FutureBuilder(
                    future: getUsers(docs[index].id),
                    builder: (context, AsyncSnapshot<UserModel> snapshot){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: snapshot.data!=null?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                  },
                                  child: snapshot.data?.photoUrl==''?
                                  CircleAvatar(
                                    backgroundImage: AssetImage("assets/avatar.jpg"),
                                    radius: 40.0,
                                  ):
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.photoUrl.toString()),
                                    radius: 40.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${snapshot.data!.username}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: ()=>handleAcceptRequest(snapshot.data!.id),
                                    child: Card(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Accept Request",
                                              style: TextStyle(fontSize: 14,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ):Container(),
                          ),
                        ),
                      );
                    });
              });
        } else {
          return Container();
        }
      },
    );
  }

  Future<UserModel> getUsers(String id)async{

    UserModel allUserList = UserModel();
    await usersRef
        .doc(id).get()
        .then((qSnap) {
      allUserList= UserModel.fromDocumentSnapshot(qSnap);
    });
    return allUserList ;
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

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }
  UserModel? user=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);

  handleSendRequest(String? id)async{
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    DocumentSnapshot doc1 = await usersRef.doc(id).get();
    UserModel user1 = UserModel.fromJson(doc1.data() as Map<String, dynamic>);
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

    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
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

    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
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

    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    DocumentSnapshot doc1 = await usersRef.doc(id).get();
    UserModel user1 = UserModel.fromJson(doc1.data() as Map<String, dynamic>);
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

  // Future<List<UserModel>> getallUsers()async{
  //   List<UserModel> allUserList = [];
  //   print(11);
  //   print(currentUserId());
  //   allUserList= (await suggestionRef.doc(currentUserId()).collection('suggestions').snapshots().toList()).cast<UserModel>();
  //   print(allUserList[0]);
  //   return allUserList ;
  // }

}