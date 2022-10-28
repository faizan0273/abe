import 'package:abe/screens/components/chat_components/components/bottom_send_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class ConversationScreen extends StatelessWidget {
  final String? username, profilePic, time;
  final bool online,flag;

  const ConversationScreen({
    Key? key,
    required this.username,
    required this.profilePic,
    required this.time,
    required this.online,
    required this.flag,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            SizedBox(height: 30,),
            Row(
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
                ),
                SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username.toString(),
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
                          "Typing...",
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
            Divider(thickness: 0.4,color: Colors.grey,),
            SizedBox(height: 30,),
          ],
        ),
      ),
      body: BottomSendNavigation(flagg:flag),
    ), onWillPop: () async=> false);
  }
}
