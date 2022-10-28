import 'dart:async';
import 'package:abe/screens/profile/profileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../chats/recent_chats.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '../../models/user.dart';
import '../../utils/firebase.dart';
import '../../widgets/indicators.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:abe/screens/search/searchScreen.dart';


class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  @override
  _searchScreenState createState() => _searchScreenState();
}
class _searchScreenState extends State<search> {

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    super.initState();
  }
  User? user;
  TextEditingController searchController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];
  List<DocumentSnapshot> filteredUsers = [];
  bool loading = true;
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
  bool isShowUsers = false;
  final List<Widget> _children = [
    discover(),
    Chats(),
    Home(),
    //search(),
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
        child: SafeArea(
          child:Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSearch(),
                SizedBox(height: 10,),
                abc()
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
          ),
        ),
        onWillPop: () async => false);
  }

  Future<List<UserModel>> getallUsers()async{

    List<UserModel> allUserList = [];
    await usersRef
        .where('firstname', isEqualTo: searchController.text,).get()
        .then((qSnap) {
      if (qSnap.docs.length > 0) {
        allUserList.clear();
        qSnap.docs.forEach((element) {
          //* in future we can also remove friend whom already request sent
          allUserList.add(UserModel.fromDocumentSnapshot(element));
        });
      }
    });
    return allUserList ;
  }

  abc(){
    return isShowUsers
        ? FutureBuilder<List<UserModel>>(
      future:getallUsers(),
      builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        print(snapshot.data![index].id.toString());
                        snapshot.data![index]!=null?
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: snapshot.data![index].id.toString(),))):{};
                      },
                      child:Row(
                      children: [
                        CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(snapshot.data![index].photoUrl.toString()),
                    ),
                        SizedBox(width: 10,),
                        Text("${snapshot.data![index].username}",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                      ],
                    ));
                  }));
        } else
          return Center(
            child: Text('Not Found',textAlign: TextAlign.center,),
          );
      },
    ):Container();
  }

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }
  getUsers() async {
    QuerySnapshot snap = await usersRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    users = doc;
    filteredUsers = doc;
    setState(() {
      loading = false;
    });
  }
  search(String query) {
    if (query == "") {
      filteredUsers = users;
    } else {
      List userSearch = users.where((userSnap) {
        Map user = userSnap.data() as Map<String, dynamic>;
        String userName = user['username'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredUsers = userSearch as List<DocumentSnapshot<Object?>>;
      });
    }
  }
  removeFromList(index) {
    filteredUsers.removeAt(index);
  }
  buildSearch(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child:Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
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
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 12,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0,0.2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(0,0.2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset("assets/search.svg",fit: BoxFit.none,),
                      ),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Container(
                          // margin: EdgeInsets.all(9),
                          child: TextFormField(
                            controller: searchController,
                            textAlignVertical: TextAlignVertical.center,
                            maxLength: 10,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (query) {
                              //search(query);
                              print(searchController.text.toString());
                            },
                            onFieldSubmitted: (String _) {
                              print(searchController.text.toString());
                              setState(() {
                                isShowUsers = true;
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  searchController.clear();
                                },
                                child: Icon(Ionicons.close_outline,
                                    size: 12.0, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.only(bottom: 15.0,),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: 'Type here...',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0,0.2),
              ),
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 70,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: GestureDetector(
                    child:Text("All",style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),textAlign: TextAlign.center,)
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 70,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: GestureDetector(
                    child:Text("Posts",style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),textAlign: TextAlign.center,)

                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 90,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: GestureDetector(
                    child:Text("Commercial",style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),textAlign: TextAlign.center,)

                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 70,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: GestureDetector(
                    child:Text("Events",style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),textAlign: TextAlign.center,)
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 80,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: GestureDetector(
                    child:Text("Community",style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),textAlign: TextAlign.center,)
                ),
              ),
              SizedBox(width: 10,),

            ],
          ),
        )
      ],
    );
  }
  buildUser(){
    if (!loading) {
      if (filteredUsers.isEmpty) {
        return Center(
          child: Text("No User Found",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
        );
      } else {
        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = filteredUsers[index];
            UserModel user =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);
            if (doc.id == currentUserId()) {
              Timer(Duration(milliseconds: 500), () {
                setState(() {
                  removeFromList(index);
                });
              });
            }
            return Column(
              children: [
                ListTile(
                  onTap: () => showProfile(context, profileId: user.id!),
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl!),
                  ),
                  title: Text(
                    user.username!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.email!,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (_) => Conversation(
                      //       userId: doc.id,
                      //       chatId: 'newChat',
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 30.0,
                      width: 62.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          },
        );
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }
  showProfile(BuildContext context, {String? profileId}) {
    // Navigator.push(
    //   context,
    //   CupertinoPageRoute(
    //     builder: (_) => Profile(profileId: profileId),
    //   ),
    // );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}