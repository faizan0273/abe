import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../container/drawer_container.dart';
import '../discover/discoverScreen.dart';
import '../homePage/homePageScreen.dart';
import '../search/searchScreen.dart';
import '../whatsapp_home.dart';
import '/bottomBar/bottomNavigartionBar.dart';


class Partner extends StatefulWidget {
  const Partner({Key? key}) : super(key: key);
  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<Partner>{

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    super.initState();
  }
  bool value=false;

  Widget _title(name,double size) {
    return Image.asset(
      'assets/${name}.png',
      width: size,
    );
  }

  Widget _submitButton(text) {
    return InkWell(
      onTap: ()async{
      },
      child: Container(
        width: 175,
        height: 36,
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,)
          ],
        ),
        child: Text(
          '${text}',
          style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
        ),
      ),
    );
  }

  Widget _submitButton1(text) {
    return InkWell(
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
              child:Icon(
                size: 8,
                color:Colors.black.withOpacity(0.99),
                Icons.arrow_back_ios,
              ),
            ),
            Expanded(
              flex:2,
              child:Text(
                '${text}',
                style: TextStyle(color: Colors.black,fontSize: 9 ,fontFamily: 'Gilroy'),
              ), ),
          ],
        ),
      ),
    );
  }
  bool isChecked=false;
  Widget  textFieldWidget(name) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child:Text("   ${name}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Gilroy'),),
        ),
        Expanded(
          flex: 2,
          child:Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.99),
                  blurRadius: 1,
                  offset: const Offset(0,0.5),
                ),
              ],
            ),
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
                    hintText:"",
                    border: InputBorder.none
                )
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child:Container(
            height: 40,
            width: 50,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.99),
                  blurRadius: 1,
                  offset: const Offset(0,0.5),
                ),
              ],
            ),
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
                    hintText:"",
                    border: InputBorder.none
                )
            ),
          ),
        ),
        Container(
          width: 20,
          height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.99),
                  blurRadius: 1,
                  offset: const Offset(0,0.5),
                ),
              ],
            ),
          child: Checkbox(
            checkColor: Colors.amber,
            fillColor: MaterialStateProperty.all(Colors.white),
            value: isChecked,
            shape: RoundedRectangleBorder( // Making around shape
                borderRadius: BorderRadius.circular(30)),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },

          )
        ),
        SizedBox(width: 10,),
      ],
    );
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
  final List<Widget> _children = [
    discover(),
    WhatsappHome(),
    homePage(),
    search(),
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          margin: EdgeInsets.all(15),
          color: Colors.white,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            child:SvgPicture.asset("assets/back.svg",),
                            onTap: () => Navigator.of(context).pop(),

                          ),
                        ),
                      ],
                    ),),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/proposal.svg",alignment: Alignment.center,fit: BoxFit.none,),
                        Container(
                          padding: EdgeInsets.only(top: 3,bottom: 3,right: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.99),
                                blurRadius: 1,
                                offset: const Offset(0,0.1),
                              ),
                            ],
                          ),
                          child:Text("  View Proposal  ",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),),
                        ),
                        SvgPicture.asset("assets/presentations.svg",alignment: Alignment.center,fit: BoxFit.none,),
                        Container(
                          padding: EdgeInsets.only(top: 3,bottom: 3,right: 3,left: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.99),
                                blurRadius: 1,
                                offset: const Offset(0,0.1),
                              ),
                            ],
                          ),
                          child:Text("Watch Presentation",style: TextStyle(fontSize: 10,fontFamily: 'Gilroy'),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Become a Partner",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,fontFamily: 'Gilroy'),),
                  SizedBox(width: 20,),
                  _title('partner1',90.0),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: width,
                //margin: EdgeInsets.all(15),
                //padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.99),
                      blurRadius: 2,
                      offset: const Offset(0,0.5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    textFieldWidget("Platinum"),
                    textFieldWidget("Gold"),
                    textFieldWidget("Silver"),
                    textFieldWidget("Bronze"),
                    textFieldWidget("In kind"),
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
                                  child:SvgPicture.asset("assets/reviews.svg",fit: BoxFit.none,)
                              ),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Reviews',
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
                                  child:SvgPicture.asset("assets/chat.svg",fit: BoxFit.none,)
                              ),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Chat',
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
                                  child:SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,)
                              ),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Send Offer',
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
                                  child:SvgPicture.asset("assets/accept.svg",fit: BoxFit.none,)
                              ),
                              Expanded(
                                flex:2,
                                child:Text(
                                  'Accept',
                                  style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                ), ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Column(
                children: [
                  _submitButton("Budget"),
                  _submitButton("Breif Discription"),
                  _submitButton("Scopes & Limitations"),
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


