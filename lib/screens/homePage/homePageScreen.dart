import 'package:abe/chats/recent_chats.dart';
import 'package:abe/models/user.dart';
import 'package:abe/screens/page/pageScreen.dart';
import 'package:abe/view_models/user/user_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/stories_editor.dart';
import '../../components/notification_stream_wrapper.dart';
import '../../container/drawer_container.dart';
import '../../dummy.dart';
import '../../models/notification.dart';
import '../../temp.dart';
import '../../utils/firebase.dart';
import '../../widgets/indicators.dart';
import '../../widgets/notification_items.dart';
import '../profile/profileScreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import '../story/story.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (_)=> UserViewModel(),
      child: homePage(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  _homePageScreenState createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePage> {


  int page = 5;
  @override
  void initState(){
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    initialize();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          page = page + 5;
        });
      }
    });
    super.initState();
    getallUsers();
    if(hours.hour>=1 && hours.hour<=12){
      greeting = "Good Morning";
    } else if(hours.hour>=12 && hours.hour<=16){
      greeting = "Good Afternoon";
    } else if(hours.hour>=16 && hours.hour<=21){
      greeting = "Good Evening";
    } else if(hours.hour>=21 && hours.hour<=24){
      greeting = "Good Night";
    }
    setState(() {
    });
  }
  DateTime hours = DateTime.now();
  String greeting = "";

  static String videoID = 'w_yAYgc2aYw';
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(currentUserId_()).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    setState(() {
    });
  }
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
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
  currentUserId_() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    var viewModel = Provider.of<UserViewModel>(context);
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .height;
    return ChangeNotifierProvider(
      create: (_)=> viewModel,
      child: SafeArea(
        child:Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset:false,
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.only(left: 20,right: 10,top: 20,bottom: 20),
            child: Column(
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
                                // Navigator.pushNamed(context, '/profileScreen',arguments:
                                // ScreenArguments(firebaseAuth.currentUser!.uid)
                                // );
                                if(users?.type=='Personal'){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: firebaseAuth.currentUser!.uid,)));
                                }
                                else if(users?.type=='Business'){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => pagee(profileId: firebaseAuth.currentUser!.uid,)));
                                }
                              },
                              child:users?.photoUrl==''?
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/avatar.jpg"),
                                radius: 40.0,
                              ):
                              CircleAvatar(
                                backgroundImage: NetworkImage(users!.photoUrl.toString()),
                                radius: 40.0,
                              )

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                temp(context),
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

  Widget temp(BuildContext context){
    return Flexible(child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
                        TextSpan(text:"${greeting}  "),
                        TextSpan(text:"${firebaseAuth.currentUser!.displayName}",style: TextStyle(fontWeight: FontWeight.bold)),
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
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                            child: SizedBox(
                                height: 300,
                                width: 300,
                                child: YoutubePlayer(
                                  width: 60,
                                  controller: _controller,
                                  liveUIColor: Colors.amber,
                                  showVideoProgressIndicator: false,
                                ),));
                      });
                },
                child:Container(
                  height: 60,
                  width: 60,
                  child: Image.network('https://img.youtube.com/vi/w_yAYgc2aYw/0.jpg',width: 60,height: 60,),
                )
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
                    onTap: (){
                      Navigator.pushNamed(context, '/friends');
                    },
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
            child: FutureBuilder<List<UserModel>>(
              future:getallUsers(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data![index].type=='Personal'?Column(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(snapshot.data![index].photoUrl.toString()),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: snapshot.data![index].id.toString(),)));
                                  },
                                ),
                                SizedBox(height: 5,),
                                Text("${snapshot.data![index].username}",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                              ],
                            ):Center();
                          }));
                } else
                  return Center(
                    child: Text('No Accquaintances',textAlign: TextAlign.center,),
                  );
              },
            )
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StoriesEditor(
                        giphyKey: 'FwyhmyWhQ45IkXGOsRhxrd0mBsizWNr4',
                        onDone: (uri){
                          print("uriiiii::"+uri);
                        },
                      ))
                      );
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoryScreen(stories: stories,)));
                    },
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
            child: FutureBuilder<List<UserModel>>(
              future:getallUsers(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data![index].type=='Business'?Column(
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
                                  child: InkWell(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image(
                                          fit: BoxFit.fill,
                                          height:80,
                                          width:100,
                                          image: NetworkImage(snapshot.data![index].photoUrl.toString()),
                                        )
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => pagee(profileId: snapshot.data![index].id.toString(),)));
                                    },
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("${snapshot.data![index].username}",style: TextStyle(fontSize: 12,fontFamily: 'Gilroy',fontWeight: FontWeight.w600),)
                              ],
                            ):Center();
                          }));
                } else
                  return Center(
                    child: Text('No Pages',textAlign: TextAlign.center,),
                  );
              },
            )
        ),
        SizedBox(height: 10,),
        Divider(thickness: 0.4,color: Colors.grey,),
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
                  InkWell(
                    onTap: ()async{
                      Navigator.pushNamed(context, '/notifications');
                    },
                    child: Text("View all",style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.w300,fontSize: 10),),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        getActivities()
      ],
    ));
  }

  getActivities() {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 100.0,
      width: 100.0,
      child: ActivityStreamWrapper(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        stream: notificationRef
            .doc(currentUserId_())
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        physics: ClampingScrollPhysics(),
        itemBuilder: (_, DocumentSnapshot snapshot) {
          ActivityModel activities = ActivityModel.fromJson(snapshot.data() as Map<String, dynamic>);
          return ActivityItem(
            activity: activities,
          );
        },
      ),
    );
  }

  Future<List<UserModel>> getallUsers()async{

    List<UserModel> allUserList = [];
    await usersRef
        .where('id', isNotEqualTo: firebaseAuth.currentUser!.uid)
        .get()
        .then((qSnap) {
      if (qSnap.docs.length > 0) {
        allUserList.clear();
        qSnap.docs.forEach((element) {
          //* in future we can also remove friend whom already request sent
          allUserList.add(UserModel.fromDocumentSnapshot(element));
        });
      }
    });
    return allUserList ;
  }
}

class ScreenArguments {
  final String id;
  ScreenArguments(this.id);
}




