import 'package:flutter/material.dart';

import '../../../constants.dart';

class MessageBox extends StatelessWidget {
  final bool isMe;
  final String message;
  const MessageBox({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Bader",style: TextStyle(fontFamily: 'Gilroy'),),
                SizedBox(width: 5,),
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage('assets/dp1.png'),
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage('assets/dp1.png'),
                ),
                SizedBox(width: 5,),
                Text("Aimi",style: TextStyle(fontFamily: 'Gilroy'),),
                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}
