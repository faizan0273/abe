import 'package:abe/models/user.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/profile/profileScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
import 'package:abe/view_models/auth/posts_view_model.dart';
import 'package:abe/widgets/indicators.dart';
import 'package:abe/widgets/userPosts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../chats/recent_chats.dart';
import '../../container/drawer_container.dart';
import '../../container/post_container.dart';
import '../../models/post.dart';
import '../../utils/firebase.dart';
import '/bottomBar/bottomNavigartionBar.dart';

class Commercial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsViewModel>(
      create: (_)=> PostsViewModel(),
      child: commercial(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}
class commercial extends StatefulWidget {
  const commercial({Key? key}) : super(key: key);
  @override
  _commercialScreenState createState() => _commercialScreenState();
}

class _commercialScreenState extends State<commercial> {

  @override
  void initState() {
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
  int _selectedIndex = 0;
  bool firstsyncRequired = false;
  UserModel? users=UserModel(id:'',education: '',email: '',from: '',number: '',owner: '',photoUrl: '',type: '',username: '',website: '',work: '',about: '',);
  final List<Widget> _children = [
    discover(),
    Chats(),
    Home(),
    search(),
  ];
  void initialize()async{
    DocumentSnapshot doc = await usersRef!.doc(currentUserId_()).get();
    users = UserModel.fromJson((doc?.data()??{}) as Map<String, dynamic>);
    setState(() {
    });
  }
  currentUserId_() {
    return firebaseAuth.currentUser!.uid;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int page = 5;
  bool loadingMore = false;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<PostsViewModel>(context);
    List<String> options=['Foods','Automotives','Events','IT','Non Profit Projects'];
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
        onWillPop: () async {
          await viewModel.resetPost();
          return false;
        },
        child: LoadingOverlay(
          progressIndicator: circularProgress(context),
          isLoading: viewModel.loading,
          child: ChangeNotifierProvider(
            create: (_) => viewModel,
            child: Scaffold(
              key: viewModel.scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                //margin: EdgeInsets.only(top: 20),
                                child: Text("${firebaseAuth.currentUser!.displayName}",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Gilroy'),),
                              ),
                              SizedBox(width: 5,),

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
                                    child:users?.photoUrl==''?
                                    CircleAvatar(
                                      backgroundImage: AssetImage("assets/avatar.jpg"),
                                      radius: 40.0,
                                    ):
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(users!.photoUrl.toString()),
                                      radius: 40.0,
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: firebaseAuth.currentUser!.uid,)));
                                    }
                                ),
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
                                style: TextStyle(color: Colors.white,fontSize: 13 ,fontFamily: 'Gilroy'),
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
                    Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                child:users?.photoUrl==''?
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/avatar.jpg"),
                                  radius: 20.0,
                                ):
                                CircleAvatar(
                                  backgroundImage: NetworkImage(users!.photoUrl.toString()),
                                  radius: 20.0,
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(profileId: firebaseAuth.currentUser!.uid,)));
                                }
                            ),
                            Expanded(child: Container(
                              width: 200,
                              height: 30,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
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
                                      hintText:"Post your commercial",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Gilroy'
                                      ),
                                    )
                                ),
                              ),
                            ),),
                            Container(
                              width: 30,
                              child:GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/writePost');
                                  },
                                  child:SvgPicture.asset("assets/gallery.svg",fit: BoxFit.none,)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Flexible(
                        child: FutureBuilder(
                      future:
                      postRef.orderBy('timestamp', descending: true).limit(page).get(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var snap = snapshot.data;
                          List docs = snap!.docs;
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: docs!.length,
                            itemBuilder: (context, index) {
                              PostModel posts = PostModel.fromJson(docs[index].data());
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CommercialPostContainer(post: posts),
                              );
                            },
                          );
                        } else
                          return Center(
                            child: Text('No Feeds'),
                          );
                      },
                    )
                    ),
                  ],
                ),
              ),
              bottomNavigationBar:Container(
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
        ),
      ),
    );
  }
}