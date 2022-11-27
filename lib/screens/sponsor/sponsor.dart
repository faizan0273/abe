import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:abe/chats/recent_chats.dart';
import 'package:abe/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
import '../../chats/conversation.dart';
import '../../components/customDialog.dart';
import '../../container/drawer_container.dart';
import '../../models/post.dart';
import '../../utils/firebase.dart';
import '/bottomBar/bottomNavigartionBar.dart';


class Sponsor extends StatefulWidget {
  final List<category> elements;
  final String? id;
  Sponsor({required this.elements,required this.id});
  @override
  _SponsorScreenState createState() => _SponsorScreenState();
}

class _SponsorScreenState extends State<Sponsor>{
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  @override
  void initState() {
    initialize();
    setState(() {
    });
  }
  User? user;
  bool isFollowing = false;
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(widget.id).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    userChatsStream(currentUserId());
    checkIfFollowing();
    checkIfFollowingg();
    setState(() {
    });
  }
  checkIfFollowingg() async {
    DocumentSnapshot doc = await suggestionRef
        .doc(widget.id)
        .collection('suggestions')
        .doc(currentUserId())
        .get();
    setState(() {
      add = doc.exists;
    });
    DocumentSnapshot doc1 = await sentRef
        .doc(widget.id)
        .collection('sentRequests')
        .doc(currentUserId())
        .get();
    setState(() {
      cancel = doc1.exists;
    });
    DocumentSnapshot doc2 = await requestsRef
        .doc(widget.id)
        .collection('Requests')
        .doc(currentUserId())
        .get();
    setState(() {
      accept = doc2.exists;
    });
    DocumentSnapshot doc3 = await friendsRef
        .doc(widget.id)
        .collection('friends')
        .doc(currentUserId())
        .get();
    setState(() {
      unfriend = doc3.exists;
    });
  }
  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.id)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
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
  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }
  String chatId_="newChat";
  bool value=false;
  List<bool> isChecked=[false,false,false,false,false];
  Widget _title(name,double size) {
    return Image.asset(
      'assets/${name}.png',
      width: size,
    );
  }

  Widget _submitButton(text) {
    return InkWell(
      onTap: ()async{
      },
      child: Container(
        width: 175,
        height: 36,
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,)
          ],
        ),
        child: Text(
          '${text}',
          style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
        ),
      ),
    );
  }
  Widget _submitButton1(text) {
    return InkWell(
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
              child:Icon(
                size: 8,
                color:Colors.black.withOpacity(0.99),
                Icons.arrow_back_ios,
              ),
            ),
            Expanded(
              flex:2,
              child:Text(
                '${text}',
                style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
              ), ),
          ],
        ),
      ),
    );
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
    return WillPopScope(child: Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          color: Colors.white,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        ),
                      ],
                    ),),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/proposal.svg",alignment: Alignment.center,fit: BoxFit.none,),
                        Container(
                          padding: EdgeInsets.only(top: 3,bottom: 3,right: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.99),
                                blurRadius: 1,
                                offset: const Offset(0,0.1),
                              ),
                            ],
                          ),
                          child:Text("  View Proposal  ",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),),
                        ),
                        SvgPicture.asset("assets/presentations.svg",alignment: Alignment.center,fit: BoxFit.none,),
                        Container(
                          padding: EdgeInsets.only(top: 3,bottom: 3,right: 3,left: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.99),
                                blurRadius: 1,
                                offset: const Offset(0,0.1),
                              ),
                            ],
                          ),
                          child:Text("Watch Presentations",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Become a Sponsor",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,fontFamily: 'Gilroy'),),
                  SizedBox(width: 20,),
                  _title('sponsor1',90.0),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: width,
                //margin: EdgeInsets.all(15),
                //padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.99),
                      blurRadius: 2,
                      offset: const Offset(0,0.5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:Text("   Platinum",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
                        ),
                        Expanded(
                          flex: 2,
                          child:Container(
                            height: 60,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[3].benefits}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            height: 40,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[3].amount}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: Checkbox(
                              checkColor: Colors.amber,
                              fillColor: MaterialStateProperty.all(Colors.white),
                              value: isChecked[0],
                              shape: RoundedRectangleBorder( // Making around shape
                                  borderRadius: BorderRadius.circular(30)),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked[0]=value!;
                                  isChecked[3]=false!;
                                  isChecked[1]=false!;
                                  isChecked[2]=false!;
                                  isChecked[4]=false!;
                                });
                              },

                            )
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:Text("   Gold",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
                        ),
                        Expanded(
                          flex: 2,
                          child:Container(
                            height: 60,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[1].benefits}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            height: 40,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[1].amount}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: Checkbox(
                              checkColor: Colors.amber,
                              fillColor: MaterialStateProperty.all(Colors.white),
                              value: isChecked[1],
                              shape: RoundedRectangleBorder( // Making around shape
                                  borderRadius: BorderRadius.circular(30)),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked[1]=value!;
                                  isChecked[3]=false!;
                                  isChecked[0]=false!;
                                  isChecked[2]=false!;
                                  isChecked[4]=false!;
                                });
                              },

                            )
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:Text("   Silver",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
                        ),
                        Expanded(
                          flex: 2,
                          child:Container(
                            height: 60,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[4].benefits}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            height: 40,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[4].amount}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: Checkbox(
                              checkColor: Colors.amber,
                              fillColor: MaterialStateProperty.all(Colors.white),
                              value: isChecked[2],
                              shape: RoundedRectangleBorder( // Making around shape
                                  borderRadius: BorderRadius.circular(30)),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked[2]=value!;
                                  isChecked[0]=false!;
                                  isChecked[1]=false!;
                                  isChecked[3]=false!;
                                  isChecked[4]=false!;
                                });
                              },

                            )
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:Text("   Bronze",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
                        ),
                        Expanded(
                          flex: 2,
                          child:Container(
                            height: 60,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[0].benefits}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            height: 40,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[0].amount}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: Checkbox(
                              checkColor: Colors.amber,
                              fillColor: MaterialStateProperty.all(Colors.white),
                              value: isChecked[3],
                              shape: RoundedRectangleBorder( // Making around shape
                                  borderRadius: BorderRadius.circular(30)),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked[3]=value!;
                                  isChecked[0]=false!;
                                  isChecked[1]=false!;
                                  isChecked[2]=false!;
                                  isChecked[4]=false!;

                                });
                              },

                            )
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:Text("   In kind",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
                        ),
                        Expanded(
                          flex: 2,
                          child:Container(
                            height: 60,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[2].benefits}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            height: 40,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: TextField(
                              //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                              //   controller: appPass
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText:"${widget.elements[2].amount}",
                                    border: InputBorder.none
                                )
                            ),
                          ),
                        ),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.99),
                                  blurRadius: 1,
                                  offset: const Offset(0,0.5),
                                ),
                              ],
                            ),
                            child: Checkbox(
                              checkColor: Colors.amber,
                              fillColor: MaterialStateProperty.all(Colors.white),
                              value: isChecked[4],
                              shape: RoundedRectangleBorder( // Making around shape
                                  borderRadius: BorderRadius.circular(30)),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked[4]=value!;
                                  isChecked[0]=false!;
                                  isChecked[1]=false!;
                                  isChecked[2]=false!;
                                  isChecked[3]=false!;
                                });
                              },

                            )
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  users!.type=='Personal'?
                  Expanded(
                      flex: 1,
                      child: buildProfileButton()
                  ):Expanded(
                      flex: 1,
                      child: buildProfileButtonn(user)
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
                              SizedBox(width: 1,),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Reviews',
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Conversation(userId: widget.id!,chatId: chatId_,)));
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
                              SizedBox(width: 1,),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Chat',
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
                        onTap: () => isChecked.contains(true)?showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                title: "Offer",
                                content:"Are you sure you want to send offer?",
                                positiveBtnText: "Sure",
                                negativeBtnText: "Cancel",
                                positiveBtnPressed: () async {
                                  List types=["Platinum","Gold","Silver","Bronze","In Kind"];
                                  int index=0;
                                  for(int i=0;i<5;i++){
                                    if(isChecked[i]==true){
                                      index=i;
                                      break;
                                    }
                                  }
                                  print(currentUserId());
                                  print(widget.id);
                                  offerRef.doc(widget.id).collection('offers').doc(currentUserId())
                                      .set({
                                    "page": "Sponsor",
                                    "category": types[index].toString(),
                                    "benefits": widget.elements[index].benefits.toString(),
                                    "amount": widget.elements[index].amount.toString(),
                                    "accept": "No",
                                  });
                                  Navigator.of(context).pop();
                                  showInSnackBar('Offer sent',context);

                                },
                              );
                            }):showInSnackBar('Error Occured',context),
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
                                  child:SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,)
                              ),
                              SizedBox(width: 1,),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Send Offer',
                                  style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                ), ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Column(
                children: [
                  _submitButton("Budget"),
                  _submitButton("Breif Discription"),
                  _submitButton("Scopes & Limitations"),
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
  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
  bool add = false,accept=false, cancel=false,unfriend=false;

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
    bool isMe = widget.id == firebaseAuth.currentUser!.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {});
    }
    else if (accept) {
      return buildButton(
        text: "Accept",
        function: ()=>handleAcceptRequest(widget.id),
      );
    } else if (cancel) {
      return buildButton(
        text: "Cancel",
        function: ()=>handleCancelRequest(widget.id),
      );
    }
    else if (add) {
      return buildButton(
        text: "Add",
        function: ()=> handleSendRequest(widget.id),
      );
    } else if (unfriend) {
      return buildButton(
        text: "Unfriend",
        function: ()=> handleUnfriend(widget.id),
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

  buildProfileButtonn(user) {
    //if isMe then display "edit profile"
    bool isMe = widget.id == firebaseAuth.currentUser!.uid;
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
  handleUnfollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    //users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = false;
    });
    //remove follower
    followersRef
        .doc(widget.id)
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
        .doc(widget.id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove from notifications feeds
    notificationRef
        .doc(widget.id)
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
        .doc(widget.id)
        .collection('userFollowers')
        .doc(currentUserId())
        .set({});
    //updates the following collection of the currentUser
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.id)
        .set({});
    //update the notification feeds
    notificationRef
        .doc(widget.id)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "follow",
      "ownerId": widget.id,
      "username": users?.username,
      "userId": users?.id,
      "userDp": users?.photoUrl,
      "timestamp": timestamp,
    });
  }
  final DateTime timestamp = DateTime.now();

}


