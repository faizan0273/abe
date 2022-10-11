import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
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

class galleryPage extends StatefulWidget {
  const galleryPage({Key? key}) : super(key: key);
  @override
  _galleryPageScreenState createState() => _galleryPageScreenState();
}

class _galleryPageScreenState extends State<galleryPage> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/videos/share.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

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
                          SizedBox(height: 15,),
                          Text("Pictures",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Gilroy'),),
                          SizedBox(height: 15,),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
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
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0//or 15.0
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
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
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
                                  )),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
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
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0//or 15.0
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
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
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
                                  )),
                                ],
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Videos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Gilroy'),),
                          SizedBox(height: 15,),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 10,),
                                  Expanded(child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),//or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: Colors.white,
                                      child:Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              // If the VideoPlayerController has finished initialization, use
                                              // the data it provides to limit the aspect ratio of the video.
                                              return AspectRatio(
                                                aspectRatio: _controller.value.aspectRatio,
                                                // Use the VideoPlayer widget to display the video.
                                                child: VideoPlayer(_controller),
                                              );
                                            } else {
                                              // If the VideoPlayerController is still initializing, show a
                                              // loading spinner.
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Files",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Gilroy'),),
                          SizedBox(height: 15,),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 3.0,
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.folder,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 21,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Business Proposal",
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 21),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Events management",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            "By Khalid",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey,thickness: 0.4,),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 3.0,
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.folder,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 21,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Business Proposal",
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 21),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Events management",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            "By Khalid",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey,thickness: 0.4,),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 3.0,
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.folder,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 21,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Business Proposal",
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 21),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Events management",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            "By Khalid",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey,thickness: 0.4,),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 3.0,
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.folder,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 21,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Business Proposal",
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 21),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Events management",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            "By Khalid",
                                            style: TextStyle(color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey,thickness: 0.4,),
                            ],
                          ),
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


