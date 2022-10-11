import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 15,width: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)
                  ),
                  margin: EdgeInsets.only(top: 10,right: 10),
                  child:GestureDetector(
                    child:SvgPicture.asset("assets/cross.svg",alignment: Alignment.center,fit: BoxFit.none,),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/dp1.png'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Jaguar",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Gilroy'
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/offerScreen');
            },
            leading: SvgPicture.asset("assets/offer.svg",fit: BoxFit.none,),
            title: Text("Offers",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/homePageScreen');
            },
            leading:SvgPicture.asset("assets/notification.svg",fit: BoxFit.none,),
            title: Text("Notifications",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/communityScreen');
            },
            leading: SvgPicture.asset("assets/community.svg",fit: BoxFit.none,),
            title: Text("Communities",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/shareAppScreen');
            },
            leading: SvgPicture.asset("assets/share.svg",fit: BoxFit.none,),
            title: Text("Share App",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset("assets/language.svg",fit: BoxFit.none,),
            title: Text("Languages",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset("assets/tc.svg",fit: BoxFit.none,),
            title: Text("T & C, Contract & Licenses",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          Spacer(),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset("assets/about.svg",fit: BoxFit.none,),
            title: Text("About",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset("assets/help.svg",fit: BoxFit.none,),
            title: Text("Help and Support",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset("assets/settings.svg",fit: BoxFit.none,),
            title: Text("Settings and privacy",style: TextStyle(fontFamily: 'Gilroy'),),
            minLeadingWidth : 10,
          ),
    ]);
  }
}