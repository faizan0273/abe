import 'package:abe/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:abe/components/chat_item.dart';
import 'package:abe/models/message.dart';
import 'package:abe/utils/firebase.dart';
import 'package:abe/view_models/user/user_view_model.dart';
import 'package:abe/widgets/indicators.dart';

import '../container/drawer_container.dart';
import '../screens/discover/discoverScreen.dart';
import '../screens/homePage/homePageScreen.dart';
import '../screens/page/pageScreen.dart';
import '../screens/profile/profileScreen.dart';
import '../screens/search/searchScreen.dart';


class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (_)=> UserViewModel(),
      child: ChatPage(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }
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
    var viewModel =
        Provider.of<UserViewModel>(context);
    viewModel.setUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0), // here the desired height
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
              Text("Inbox",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Gilroy'),),
              SizedBox(height: 15,),
              Container(
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
                        margin: EdgeInsets.all(9),
                        child: TextField(
                          //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                          //   controller: appPass,
                            onChanged: (appPass){
                              setState(() {
                                appPass=appPass;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText:"Type here..",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Gilroy'
                              ),
                            )
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              // StoryScreenUI(),
            ],
          ),
        )
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userChatsStream('${viewModel.user!.uid ?? ""}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List chatList = snapshot.data!.docs;
            if (chatList.isNotEmpty) {
              return ListView.separated(
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot chatListSnapshot = chatList[index];
                  return StreamBuilder<QuerySnapshot>(
                    stream: messageListStream(chatListSnapshot.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List messages = snapshot.data!.docs;
                        Message message = Message.fromJson(
                          messages.first.data(),
                        );
                        List users = chatListSnapshot.get('users');
                        // remove the current user's id from the Users
                        // list so we can get the second user's id
                        users.remove('${viewModel.user!.uid ?? ""}');
                        String recipient = users[0];
                        return ChatItem(
                          userId: recipient,
                          messageCount: messages.length,
                          msg: message.content!,
                          time: message.time!,
                          chatId: chatListSnapshot.id,
                          type: message.type!,
                          currentUserId:  "abc",
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          } else {
            return Center(child: circularProgress(context));
          }
        },
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


  Stream<QuerySnapshot> userChatsStream(String uid) {
    return chatRef
        .where('users', arrayContains: '${uid}')
        .snapshots();
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
