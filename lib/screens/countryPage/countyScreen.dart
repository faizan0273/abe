import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class countryPage extends StatefulWidget {
  const countryPage({Key? key}) : super(key: key);
  @override
  _countryPageScreenState createState() => _countryPageScreenState();
}

class _countryPageScreenState extends State<countryPage> {

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
      child:WillPopScope(
        onWillPop: () async=> false,
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
                                borderRadius: BorderRadius.circular(20),
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(width: 20,),
                                  Image(image: AssetImage('assets/uae.png'),width: 20,height: 20,),
                                  SizedBox(height: 20,width: 10,),
                                  Text("Sharjah",style: TextStyle(fontFamily: 'Gilroy',fontSize: 16,fontWeight: FontWeight.w900,color: Colors.white),),
                                ],
                              )
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(20),
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
                                Expanded(flex: 1,child: ClipRRect(
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
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Johnson Stone",style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Gilroy',fontSize: 10),),

                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Business Consultant",style: TextStyle(fontFamily: 'Gilroy',fontSize: 8),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4,),
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
                                      SizedBox(height: 8,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/membersScreen',);
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("10.3 M",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,fontWeight: FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Community",style: TextStyle(fontFamily: 'Gilroy',fontSize: 8),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),),
                                Expanded(flex:1,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: ()async{
                                            Navigator.pushNamed(context, '/cityScreen',);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 30,
                                            margin: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.black)
                                              ],
                                            ),
                                            child: Text(
                                              'Circles',
                                              style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy',fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: ()async{
                                            Navigator.pushNamed(context, '/abeCirclesScreen',);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 30,
                                            margin: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.black)
                                              ],
                                            ),
                                            child: Text(
                                              'Place Membership',
                                              style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy',fontSize: 8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),

                              ],
                            ),
                          ),
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
                          CountryPostContainer(),
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


