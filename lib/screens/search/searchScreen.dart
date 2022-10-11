import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

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
    return WillPopScope(child: SafeArea(child:Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                                        fontFamily: 'Gilroy',
                                        fontSize: 12,
                                      ),
                                    )
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
      ),), onWillPop: () async => false);

  }
}