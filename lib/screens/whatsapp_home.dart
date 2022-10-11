import 'package:abe/bottomBar/bottomNavigartionBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/home_components/chat_screen_ui.dart';
import 'components/home_components/components/bottom_navigation.dart';
import 'components/home_components/components/story_screen_ui.dart';
import 'constants.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';


class WhatsappHome extends StatefulWidget {
  @override
  _WhatsappHomeState createState() => _WhatsappHomeState();
}

class _WhatsappHomeState extends State<WhatsappHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _onItemTapped(int index) async {
    _selectedIndex = index;
    if (index < 5)
      if(index == 4) {
        print(123);
        scaffoldKey.currentState!.openEndDrawer(); // CHANGE THIS LINE
        print(456);
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
    return WillPopScope(child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
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
            SizedBox(height: 10,),
            // StoryScreenUI(),
            ChatScreenUI(),
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
    ), onWillPop: () async => false);
  }
}
