import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../chats/recent_chats.dart';
import '../../container/city_post_container.dart';
import '../../container/community_post_container.dart';
import '../../container/country_post_container.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

class cityPage extends StatefulWidget {
  const cityPage({Key? key}) : super(key: key);
  @override
  _cityPageScreenState createState() => _cityPageScreenState();
}

class _cityPageScreenState extends State<cityPage> {

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
    return SafeArea(
      child:WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                    Flexible(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),

                              image: DecorationImage(
                                fit: BoxFit.fill,
                                scale: 1.0,
                                image: AssetImage('assets/sharjah.png',),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0,0.2),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0,0.2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 20,),
                                        Image(image: AssetImage('assets/uae.png'),width: 20,height: 20,),
                                        SizedBox(width: 10,),
                                        Text("Sharjah Circles",style: TextStyle(fontFamily: 'Gilroy',fontSize: 16,fontWeight: FontWeight.w900,color: Colors.black),),
                                      ],)),
                                Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/membersScreen',);

                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 20,),
                                          Container(
                                              height: 30,
                                              margin: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.3),
                                                    blurRadius: 3,
                                                    offset: const Offset(0,0.2),
                                                  ),
                                                ],
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("  Members 154k ",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                                                ],
                                              )
                                          )
                                        ],),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{
                                      Navigator.pushNamed(context, '/galleryScreen');
                                    },
                                    child: Container(
                                      height: 20,
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
                                      child: Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
                                      height: 20,
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
                                      child: Text(
                                        'Events',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
                                      height: 20,
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
                                      child: Text(
                                        'Topics',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
                                      height: 20,
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
                                      child: Text(
                                        'Invite',
                                        style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [

                              Expanded(
                                child: Container(
                                    width: 200,
                                    height: 30,
                                    alignment: Alignment.center,
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage: AssetImage('assets/dp1.png'),

                                          ),
                                          Expanded(child: Container(
                                            margin: EdgeInsets.only(top: 7,bottom: 7,left: 7),
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
                                                  hintText:"Write something",
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Gilroy',color: Colors.black
                                                  ),
                                                )
                                            ),
                                          ),)
                                        ],
                                      ),
                                    )
                                ),),
                              Container(
                                width: 30,
                                child:IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: (){},
                                ),
                              ),
                            ],
                          ),
                          CityPostContainer(),
                        ],
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
        ),
      ),
    );
  }
}


