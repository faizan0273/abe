import 'package:abe/screens/components/chat_components/components/messageBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants.dart';
import '../../../model/messageModel.dart';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class BottomSendNavigation extends StatefulWidget {
  final bool flagg;
  BottomSendNavigation({Key? key,required  this.flagg}) : super(key: key);
  @override
  _BottomSendNavigationState createState() => _BottomSendNavigationState();
}

class _BottomSendNavigationState extends State<BottomSendNavigation>
    with SingleTickerProviderStateMixin {
  TextEditingController _sendMessageController = TextEditingController();
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  Icon _emojiIcon = Icon(
    FontAwesomeIcons.smileWink,
    color: Colors.grey,
    size: 20,
  );

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
            _emojiIcon = Icon(
              FontAwesomeIcons.smileWink,
              color: Colors.grey,
              size: 20,
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: widget.flagg==true? PreferredSize(
          preferredSize: Size.fromHeight(250.0), // here the desired height
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.06),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 25,
                                      width: 25,
                                      //padding: EdgeInsets.only(left: 10),
                                      //margin: EdgeInsets.only(left: 10,top: 20),
                                      child: SvgPicture.asset("assets/col.svg",fit: BoxFit.none,)
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Investor",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy'
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Gold Category",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontFamily: 'Gilroy'
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Container(
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
                                        hintText:"Amount",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Gilroy'
                                        ),
                                      )
                                  ),
                                ),
                              ),
                              //SizedBox(height: 2,),
                              Container(
                                width: 200,
                                height: 70,
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
                                      hintText:"   Benefits",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Gilroy'
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 0.4,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(height: 15,),
                            InkWell(
                              onTap: ()async{
                              },
                              child: Container(
                                width: 175,
                                height: 30,
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
                                  'Accept',
                                  style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
                                ),
                              ),
                            ),
                            SizedBox(height: 2,),
                            InkWell(
                              onTap: ()async{
                              },
                              child: Container(
                                width: 175,
                                height: 30,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.pinkAccent,)
                                  ],
                                ),
                                child: Text(
                                  'Decline',
                                  style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy'),
                                ),
                              ),
                            ),
                            SizedBox(height: 2,),
                            InkWell(
                              onTap: ()async{
                              },
                              child: Container(
                                width: 175,
                                height: 30,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey,)
                                  ],
                                ),
                                child: Text(
                                  'Send new offer',
                                  style: TextStyle(color: Colors.white ,fontFamily: 'Gilroy',fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ):PreferredSize(
          preferredSize: Size.fromHeight(0), // here the desired height
          child: Container(),
        ),
        body: Container(
          color: Colors.white,
          child:Stack(
            children: [
              ListView(
                children: List.generate(
                  messages.length,
                      (index) {
                    return Container();
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child:Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.attach_file,color: Colors.white,),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor:
                                Colors.transparent,
                                context: context,
                                builder: (builder) =>
                                    bottomSheet());
                          },
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Type Something...",
                                hintStyle: TextStyle( color:     Colors.white),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 2,
                                offset: const Offset(0,0.2),
                              ),
                            ],
                          ),
                          child:SvgPicture.asset("assets/send.svg",fit: BoxFit.none,color: Colors.white,),
                        ),
                        SizedBox(width: 10,)

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
    );
  }
  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
