import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../container/community_post_container.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

class communityPage extends StatefulWidget {
  const communityPage({Key? key}) : super(key: key);
  @override
  _communityPageScreenState createState() => _communityPageScreenState();
}

class _communityPageScreenState extends State<communityPage> {

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    super.initState();
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
    WhatsappHome(),
    homePage(),
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
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Text("Jaguar     ",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Gilroy'),),
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
                                child:CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage('assets/dp1.png'),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, '/profileScreen');

                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
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
                      Expanded(child: InkWell(
                        onTap: ()async{
                          Navigator.pushNamed(context, '/commercialScreen');
                        },
                        child: Container(
                          width: 155,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.white,)
                            ],
                          ),
                          child: Text(
                            'COMMERCIAL',
                            style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'Gilroy' ),
                          ),
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: ()async{
                          Navigator.pushNamed(context, '/communityPageScreen');
                        },
                        child: Container(
                          width: 155,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,)
                            ],
                          ),
                          child: Text(
                            'COMMUNITY',
                            style: TextStyle(color: Colors.white ,fontSize: 13,fontFamily: 'Gilroy'),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/dp2.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/dp.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/dp1.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/dp3.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/yammy.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/jessy.png'),
                          ),
                          SizedBox(height: 5,),
                          Text("Jaugar",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Container(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/dp1.png'),
                              ),
                              onTap: (){

                              },
                            ),
                            Expanded(
                              child: Container(
                                width: 200,
                                height: 30,
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10),
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
                                        hintText:"What do you want to talk about?",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Gilroy'
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        CommunityPostContainer(),
                      ],
                    ),
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
        ),
      ),
    );
  }
}