import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../model/chatModel.dart';
import '../chat_components/conversation_screen_ui.dart';

class ChatScreenUI extends StatelessWidget {
  const ChatScreenUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          dragStartBehavior: DragStartBehavior.start,
          itemCount: dummyData.length,
          itemBuilder: (context, i) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.03),
                  blurRadius: 1,
                  offset: const Offset(0,0.2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(profilePic: dummyData[i].avatarUrl, username: dummyData[i].name, online: dummyData[i].online, time: dummyData[i].time,flag:false)),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/login.png'),
                    radius: 26,
                    child: Container(),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dummyData[i].name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy'
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      dummyData[i].message=="Offer"? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            margin: EdgeInsets.all(5),
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
                            child: InkWell(
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(profilePic: dummyData[i].avatarUrl, username: dummyData[i].name, online: dummyData[i].online, time: dummyData[i].time,flag:true)),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start ,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 5,),
                                  SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
                                  SizedBox(width: 5,),
                                  Text(
                                    'Offer',
                                    style: TextStyle(color: Colors.black,fontSize: 9,fontFamily: 'Gilroy' ),
                                  ),
                                ],
                              ),
                            )
                          )
                        ],
                      ):Row(children: [Expanded(
                            child: Text(
                              dummyData[i].message,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'Gilroy'
                              ),
                            ),
                          ),],),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
      ),
    );
  }
}
