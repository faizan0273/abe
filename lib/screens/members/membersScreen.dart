import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../container/community_post_container.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

class membersPage extends StatefulWidget {
  const membersPage({Key? key}) : super(key: key);
  @override
  _membersPageScreenState createState() => _membersPageScreenState();
}

class _membersPageScreenState extends State<membersPage> {

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    super.initState();
  }
  static String videoID = 'dFKhWe2bBkM';

  // YouTube Video Full URL : https://www.youtube.com/watch?v=dFKhWe2bBkM&feature=emb_title&ab_channel=BBKiVines

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

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
      child:WillPopScope(child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(left: 20,right: 10,top: 20,bottom: 20),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
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
                                onTap: () => Navigator.of(context).pop(),

                                child:SvgPicture.asset("assets/back.svg",),
                              ),
                            ),
                            SizedBox(width: 5,),
                          ],
                        ),
                      ),
                      Text("UAE Community Members",style: TextStyle(fontSize: 15,fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                      Expanded(
                        flex: 1,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: SvgPicture.asset("assets/settings.svg",fit: BoxFit.none,),
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
                                  hintText:"Search members",
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
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.06),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
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
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.white,
                                  child:Container(
                                    decoration:  BoxDecoration(
                                      image:  DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("assets/accq1.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),),
                              Expanded(flex: 5,child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Text("Johnson Stone",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy',fontSize: 10),),

                                    ],
                                  ),
                                  SizedBox(height: 2,),
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Text("Business Consultant",style: TextStyle(fontFamily: 'Gilroy',fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: ClipRRect(
                                          borderRadius:
                                          const BorderRadius.horizontal(left: Radius.circular(16.0),right: Radius.circular(16.0)),
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              child: SizedBox(width: 20, height: 20, child: Icon(Icons.person_add_alt)),
                                              onTap: () {},
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.horizontal(left: Radius.circular(16.0),right: Radius.circular(16.0)),
                                              child: Material(// b
                                                color: Colors.white,
                                                child: InkWell(// inkwell color
                                                  child: SizedBox(width: 20, height: 20, child: Icon(Icons.forward_to_inbox)),
                                                  onTap: () {},
                                                ),
                                              ),
                                            ))

                                      ]
                                  ),
                                ],
                              ),),

                            ],
                          ),
                        ),),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.06),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
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
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.white,
                                  child:Container(
                                    decoration:  BoxDecoration(
                                      image:  DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("assets/pic.jpeg"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),),
                              Expanded(flex: 5,child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Text("Johnson Stone",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy',fontSize: 10),),

                                    ],
                                  ),
                                  SizedBox(height: 2,),
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Text("Business Consultant",style: TextStyle(fontFamily: 'Gilroy',fontSize: 8),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: ClipRRect(
                                          borderRadius:
                                          const BorderRadius.horizontal(left: Radius.circular(16.0),right: Radius.circular(16.0)),
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              child: SizedBox(width: 20, height: 20, child: Icon(Icons.person_add_alt)),
                                              onTap: () {},
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.horizontal(left: Radius.circular(16.0),right: Radius.circular(16.0)),
                                              child: Material(// b
                                                color: Colors.white,
                                                child: InkWell(// inkwell color
                                                  child: SizedBox(width: 20, height: 20, child: Icon(Icons.forward_to_inbox)),
                                                  onTap: () {},
                                                ),
                                              ),
                                            ))

                                      ]
                                  ),
                                ],
                              ),),

                            ],
                          ),
                        ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage('assets/dp1.png'),
                                    radius: 26,
                                    child: Container(),
                                  ),
                                  trailing: const Icon(Icons.more_vert),
                                  title: Text("Cristina")),
                              Divider(thickness: 0.3,color: Colors.grey,)
                            ],
                          );
                        }
                    ),),
                ],
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
      ),onWillPop: () async =>false,),
    );
  }
}


