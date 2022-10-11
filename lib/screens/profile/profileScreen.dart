import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../container/drawer_container.dart';
import '/bottomBar/bottomNavigartionBar.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  @override
  _profileScreenState createState() => _profileScreenState();
}
class _profileScreenState extends State<profile> {

  List<String>? myStringList;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    super.initState();
  }
  Widget _title(name,double size) {
    return Image.asset(
      'assets/${name}.png',
      width: size,
    );
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
          'Share Your Version',
          style: TextStyle(color: Colors.white ),
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
    return WillPopScope(child: Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
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
              SizedBox(height: 10,),
              Container(
                height: 150,
                decoration: BoxDecoration(
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
                    Expanded(flex: 3,child: ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),//or 15.0
                      child: Container(
                        height: 140.0,
                        width: 140.0,
                        color: Colors.white,
                        child:Container(
                          decoration:  BoxDecoration(
                            image:  DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/accq2.png"),
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
                            Text("Johnson Stone",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),),

                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Text("Business Consultant",style: TextStyle(fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            SvgPicture.asset("assets/community.svg",fit: BoxFit.none,),
                            SizedBox(width: 5,),
                            Text("Community",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Gilroy',fontSize: 15),)
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Text('Acquantances  ',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy',fontSize: 13)),
                            SizedBox(width: 5,),
                            Text(' 876,546',style: TextStyle(fontFamily: 'Gilroy',fontSize: 13)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(right: 5,left: 5),
                          height: 20,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
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
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(fontFamily: 'Gilroy'),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                ),
                                              ),
                                              TextSpan(text: '154'),
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
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
                                        child:RichText(
                                          text: TextSpan(
                                            style: TextStyle(fontFamily: 'Gilroy'),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: SvgPicture.asset("assets/col.svg",fit: BoxFit.none,),
                                                ),
                                              ),
                                              TextSpan(text: '154'),
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
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
                                        child:RichText(
                                          text: TextSpan(
                                            style: TextStyle(fontFamily: 'Gilroy'),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                                ),
                                              ),
                                              TextSpan(text: '154',style: TextStyle(fontFamily: 'Gilroy')),
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: ()async{

                          },
                          child: Container(
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
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:SvgPicture.asset("assets/add.svg",fit: BoxFit.none,)
                                ),
                                Expanded(
                                  flex:2,
                                  child:Text(
                                    'Add',
                                    style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                  ), ),
                              ],
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
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:SvgPicture.asset("assets/reviews.svg",fit: BoxFit.none,)
                                ),
                                Expanded(
                                  flex:2,
                                  child:Text(
                                    'Reviews',
                                    style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
                                  ), ),
                              ],
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
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:SvgPicture.asset("assets/chat.svg",fit: BoxFit.none,)
                                ),
                                Expanded(
                                  flex:2,
                                  child:Text(
                                    'Inbox',
                                    style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                  ), ),
                              ],
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
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:SvgPicture.asset("assets/share.svg",fit: BoxFit.none,)
                                ),
                                Expanded(
                                  flex:2,
                                  child:Text(
                                    'Share',
                                    style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                  ), ),
                              ],
                            ),
                          ),
                        )
                    ),
                    InkWell(
                      child: Icon(
                        Icons.more_vert,color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Owner at",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Works at",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"From",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Education",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Mobile",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Email",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              TextField(
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                //controller: appPass,
                  onChanged: (appPass){
                    setState(() {
                      appPass=appPass;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:"Website",
                    hintStyle: TextStyle(color: Colors.black45,fontSize: 14,fontFamily: 'Gilroy'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  )
              ),
              SizedBox(height: 8,),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.0070),
                      blurRadius: 1,
                      offset: const Offset(0,0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: ()async{

                          },
                          child: Container(
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
                              'Experience',
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
                              'Interests',
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
                              'Skills',
                              style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: ()async{
                    },
                    child: Container(
                      width: 190,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,)
                        ],
                      ),
                      child: Text(
                        'Posts',
                        style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: ()async{
                    },
                    child: Container(
                      width: 190,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,)
                        ],
                      ),
                      child: Text(
                        'Commercials',
                        style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
              SizedBox(height: 5,),
              Divider(thickness: 0.4,color: Colors.grey,),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Feed",style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 10,),
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
            ],
          ),
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
    ), onWillPop: () async => false);
  }
}