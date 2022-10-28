import 'package:abe/chats/recent_chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../container/drawer_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
import 'package:video_player/video_player.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);
  @override
  _ShareAppScreenState createState() => _ShareAppScreenState();
}

class _ShareAppScreenState extends State<ShareApp> {

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

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }
  Widget _submitButton() {
    return InkWell(
      onTap: ()async{
        Navigator.pushNamed(context, '/startUpScreen');
      },
      child: Container(
        width: 155,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,)
          ],
        ),
        child: Text(
          'Share App',
          style: TextStyle(color: Colors.white,fontFamily: 'Gilroy' ),
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
    return SafeArea(
    child:WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    //padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(left: 10,top: 20),
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
              SizedBox(height: 30,),
              Container(
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
              SizedBox(height: 20,),
              Text("531,345,454",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'Gilroy'),),
              Text("Installs and Counting",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,fontFamily: 'Gilroy'),),
              SizedBox(height: 20,),
              _submitButton(),
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