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

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  _homePageScreenState createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePage> {

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
      child:Scaffold(
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
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/profileScreen');
                                },
                                child:CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage('assets/dp1.png'),
                                ),

                              ),
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
                      temp(context),
                      tempp(context),
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
    );
  }

  Widget temp(BuildContext context){
    return Column(
      children: [
        Container(
          height: 80,
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
              Image(image: AssetImage("assets/sun.png")),
              RichText(
                  text: TextSpan(
                      style: TextStyle(fontFamily: 'Gilroy',fontSize: 20,color: Colors.black),
                      children:[
                        TextSpan(text:"Good Morning  "),
                        TextSpan(text:"David",style: TextStyle(fontWeight: FontWeight.bold)),
                      ])
              )
            ],
          ),
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
                        color: Colors.black,)
                    ],
                  ),
                  child: Text(
                    'COMMERCIAL',
                    style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Gilroy' ),
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
                        color: Colors.white,)
                    ],
                  ),
                  child: Text(
                    'COMMUNITY',
                    style: TextStyle(color: Colors.black ,fontSize: 13,fontFamily: 'Gilroy'),
                  ),
                ),
              )),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: 80,
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
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quote of the day",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy')),
                  Text("The values of an idea lies in the using of it",style: TextStyle(fontFamily: 'Gilroy',fontSize: 12,fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(width: 20,),
              YoutubePlayer(

                width: 60,
                controller: _controller,
                liveUIColor: Colors.amber,
                showVideoProgressIndicator: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Divider(thickness: 0.4,color: Colors.grey,),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Acquaintance",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text("View all",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.w300,fontSize: 10),),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
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
        Divider(thickness: 0.4,color: Colors.grey,),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pages",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text("View all",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.w300,fontSize: 10),),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          height: 110,
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
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Google",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq1.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Ibex",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq2.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Nestle",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Createex",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq1.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Artisia",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 3,
                          offset: const Offset(0,0.2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/accq2.png",height: 70,),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("CNN",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                ],
              ),

            ],
          ),
        ),
        SizedBox(height: 10,),
        Divider(thickness: 0.4,color: Colors.grey,),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget tempp(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notifications",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text("View all",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.w300,fontSize: 10),),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width:180,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/dp1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Jane D",style: TextStyle(fontSize: 14,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),),
                        Text("Followed by Aimi",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',),)
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}


