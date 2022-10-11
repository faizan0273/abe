import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountryPostContainer extends StatelessWidget {
  CountryPostContainer({Key? key}) : super(key: key);
  @override
  void initState(){
    setState(){};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(),
                //Padding(padding: const EdgeInsets.symmetric(vertical: 8),),
                Container(
                  height: 170,
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 1,
                        offset: const Offset(0,0.2),
                      ),
                    ],
                  ),
                  child:Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset("assets/mc.png",height: 130,fit: BoxFit.none,),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                SvgPicture.asset("assets/heart.svg",),
                                SizedBox(width: 4,),
                                Text("40",style: TextStyle(fontFamily: 'Gilroy'),),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                SvgPicture.asset("assets/comment.svg",),
                                SizedBox(width: 4,),

                                Text("24",style: TextStyle(fontFamily: 'Gilroy'),),
                              ],
                            ),
                            Spacer(),
                            Text("Share  ",style: TextStyle(fontFamily: 'Gilroy',fontSize: 12),),
                            SvgPicture.asset("assets/share.svg",),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
              ],
            ),
          ),
        ],
      ),
    );

  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;
  const _PostButton({Key?  key,  required this.icon,  required this.label,  required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label,style: TextStyle(fontFamily: 'Gilroy'),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {

  _PostHeader({Key?  key}) : super(key: key);
  int  abc=0;
  final double profileheight=114;
  @override
  void initState(){
    setState(){};
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //ProfileAvatar(imageUrl: post.user.imageUrl, key: null,),
          // FutureBuilder <profilePicData>(
          //   future: ApiServices.viewProfilePic(body),
          //   builder: (BuildContext context,AsyncSnapshot snapshot) {
          //     if (snapshot.hasData) {
          //       profilePicData  data = snapshot.data;
          //       return CircleAvatar(
          //         radius: profileheight/5,
          //         //backgroundImage: AssetImage('assets/images.jpg'),
          //         child:CachedNetworkImage(
          //           imageUrl: data .path.toString()+data.Profile_pic.toString(),
          //           imageBuilder: (context, imageProvider) => Container(
          //             width: profileheight,
          //             height: profileheight,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                   image: imageProvider, fit: BoxFit.cover),
          //             ),
          //           ),
          //           placeholder: (context, url) => CircularProgressIndicator(),
          //           errorWidget: (context, url, error) => CircleAvatar(
          //             radius: profileheight/5,
          //             backgroundImage: AssetImage('assets/images.jpg'),
          //           ),
          //         ),
          //       );
          //     }
          //     return CircleAvatar(
          //       radius: profileheight/5,
          //       backgroundImage: AssetImage('assets/images.jpg'),
          //     );
          //   },
          // ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/pageScreen',);
            },
            child:CircleAvatar(radius: 12, backgroundImage: AssetImage('assets/mc.png'), key: null,),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'McDonalds',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy',
                    fontSize: 12
                  ),
                ),
                Text(
                  '10 min.',
                  style: const TextStyle(
                      fontFamily: 'Gilroy',
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
