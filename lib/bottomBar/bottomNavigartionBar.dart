import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../container/drawer_container.dart';
import '../screens/commercial/commercialScreen.dart';
import '../screens/community/communityScreen.dart';
import '../screens/discover/discoverScreen.dart';
import '../screens/search/searchScreen.dart';
import '../screens/startup/startupScreen.dart';
import '../screens/whatsapp_home.dart';

class BottomNavigation extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int _selectedIndex;
  BottomNavigation(this._selectedIndex, this.scaffoldKey, {Key?  key,}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}
class _BottomNavigationState extends State<BottomNavigation> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final key = GlobalKey<State<BottomNavigationBar>>();
  int _selectedIndex = 0;
  static double iconeWidth = 25;
  static double iconesHeight = 25;
  double spaceBtIconeText = 8.0;
  final iconColor = Color(0xFFCC9B00);
  final selectedIconColor = Color(0xFFCC9B00);
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontFamily: "SourceSansPro-Regular");
  bool firstsyncRequired = false;
  final List<Widget> _children = [
    discover(),
    WhatsappHome(),
    homePage(),
    search(),
  ];

  @override
  void initState()  {
    super.initState();
    checkfirstsync();
    _selectedIndex = widget._selectedIndex;
  }
  loadData()async {
  }
  checkfirstsync() async {
  }
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
  @override
  Widget build(BuildContext context) {
    checkfirstsync();
    return Container(
      margin: EdgeInsets.only(bottom: 2,right: 2,left: 2,top: 2),
      padding: EdgeInsets.only(bottom: 5,right: 5,left: 5,top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 0,
            offset: const Offset(0,0.1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        key: scaffoldKey,
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
    );
  }
}