import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostContainer extends StatelessWidget {
  PostContainer({Key? key}) : super(key: key);
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
                  height: 150,
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
                    image:DecorationImage(
                      fit: BoxFit.none,
                      scale: 1.0,
                      image: AssetImage('assets/temp.png'),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex:1,
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                                onTap: (){
                                  Navigator.pushNamed(context, '/partnerScreen',);
                                },
                                child:SvgPicture.asset("assets/partner.svg",fit: BoxFit.none,),
                              ),
                            ),
                            Text("Partner",style: TextStyle(fontSize: 10),)
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
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
                                onTap: (){
                                  Navigator.pushNamed(context, '/investorScreen',);
                                },
                                child:SvgPicture.asset("assets/investor.svg",fit: BoxFit.none,),
                              ),
                            ),
                            Text("Invest",style: TextStyle(fontSize: 10),)
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
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
                                onTap: (){
                                  Navigator.pushNamed(context, '/sponsorScreen',);
                                },
                                child:SvgPicture.asset("assets/sponsor.svg",fit: BoxFit.none,),
                              ),
                            ),
                            Text("Sponsor",style: TextStyle(fontSize: 10),)
                          ],
                        ),
                      ],
                    ),
                    ),
                    Expanded(
                      flex:1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
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
                                  child:SvgPicture.asset("assets/share.svg",fit: BoxFit.none,),
                                ),
                              ),
                              Text("Share",style: TextStyle(fontSize: 10),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
                Text("The @GaboBrandX's answer is the correct one, so I added some code to reverse the animation, for example, it will animate from 0,1,2 pages and when reaching the end, it will reverse to 2,1,0.",style:TextStyle(color: Colors.black,fontSize: 10)),
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
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatefulWidget {

  _PostHeader({Key?  key}) : super(key: key);

  @override
  State<_PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<_PostHeader> {
  int  abc=0;

  final double profileheight=114;

  @override
  void initState(){
    setState(){};
  }

  late int _selected=0;
  List<String> options=['Foods','Automotives','Events','IT','Non Profit Projects'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/profileScreen',);
            },
            child:CircleAvatar(radius: 12, backgroundImage: AssetImage('assets/dp1.png'), key: null,),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jane',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy'
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Categories"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        actions: <Widget>[
                          // FlatButton(
                          //   child: const Text('CANCEL',style: TextStyle(color: Colors.black),),
                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //   textColor: Theme.of(context).accentColor,
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                          // FlatButton(
                          //   child: const Text('OK',style: TextStyle(color: Colors.black),),
                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //   textColor: Theme.of(context).accentColor,
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //     showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return Dialog(
                          //             backgroundColor: Colors.white,
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                 BorderRadius.circular(20.0)), //this right here
                          //             child: Container(
                          //               margin: EdgeInsets.all(10),
                          //               padding: EdgeInsets.all(10),
                          //               height: 130,
                          //               child: Column(
                          //                 children: [
                          //                   Row(
                          //                     mainAxisAlignment: MainAxisAlignment.end,
                          //                     children: [
                          //                       GestureDetector(
                          //                         child:SvgPicture.asset("assets/cross.svg",fit: BoxFit.none,),
                          //                         onTap: (){
                          //                           Navigator.pop(context);
                          //                         },
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   SizedBox(height: 5,),
                          //                   Row(
                          //                     children: [
                          //                       Text("Select a photo",style: TextStyle(color: Colors.grey.shade600,fontFamily: 'Gilroy'),)
                          //                     ],
                          //                   ),
                          //                   SizedBox(height: 10,),
                          //                   GestureDetector(
                          //                     child:Row(
                          //                       children: [
                          //                         SvgPicture.asset("assets/photo.svg",fit: BoxFit.none,),
                          //                         SizedBox(width: 10,),
                          //                         Text("Take a photo",style: TextStyle(fontFamily: 'Gilroy'),),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   SizedBox(height: 10,),
                          //                   GestureDetector(
                          //                     child: Row(
                          //                       children: [
                          //                         SvgPicture.asset("assets/library.svg",fit: BoxFit.none,),
                          //                         SizedBox(width: 10,),
                          //                         Text("Select from library",style: TextStyle(fontFamily: 'Gilroy'),),
                          //                       ],
                          //                     ),
                          //                     onTap: (){
                          //                       Navigator.pop(context);
                          //                       showDialog(
                          //                         context: context,
                          //                         builder: (BuildContext context) {
                          //                           return Dialog(
                          //                             backgroundColor: Colors.white,
                          //                             shape: RoundedRectangleBorder(
                          //                                 borderRadius:
                          //                                 BorderRadius.circular(20.0)), //this right here
                          //                             child: Container(
                          //                               margin: EdgeInsets.all(10),
                          //                               padding: EdgeInsets.all(10),
                          //                               height: 130,
                          //                               child: Column(
                          //                                 children: [
                          //                                   Row(
                          //                                     mainAxisAlignment: MainAxisAlignment.end,
                          //                                     children: [
                          //                                       GestureDetector(
                          //                                         child:SvgPicture.asset("assets/cross.svg",fit: BoxFit.none,),
                          //                                         onTap: (){
                          //                                           Navigator.pop(context);
                          //                                         },
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                   SizedBox(height: 5,),
                          //                                   Row(
                          //                                     children: [
                          //                                       SvgPicture.asset("assets/folder.svg",height: 15,width: 15,fit: BoxFit.none,),
                          //                                       SizedBox(width: 10),
                          //                                       Flexible(
                          //                                           child: Card(
                          //                                             borderOnForeground: false,
                          //                                             elevation: 0,
                          //                                             surfaceTintColor: Colors.white,
                          //                                             shadowColor: Colors.white,
                          //                                             child: Column(
                          //                                               children: [
                          //                                                 RichText(
                          //                                                     text: TextSpan(
                          //                                                       style: new TextStyle(
                          //                                                         height: 1.7,
                          //                                                         fontSize: 12.0,
                          //                                                         color: Colors.black,
                          //                                                         fontFamily: 'Gilroy',
                          //                                                       ),
                          //                                                       children: <TextSpan>[
                          //                                                         new TextSpan(text: 'Allow ',style: TextStyle(fontFamily: 'Gilroy'),),
                          //                                                         new TextSpan(text: 'ABE', style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy')),
                          //                                                         new TextSpan(text: ' to access photo, media and files on your device?',style: TextStyle(fontFamily: 'Gilroy'),),
                          //                                                       ],
                          //                                                     )),
                          //                                               ],
                          //                                             ),
                          //                                           )),
                          //                                     ],
                          //                                   ),
                          //                                   SizedBox(height: 20,),
                          //                                   Row(
                          //                                     mainAxisAlignment: MainAxisAlignment.center,
                          //                                     crossAxisAlignment: CrossAxisAlignment.center,
                          //                                     children: [
                          //                                       GestureDetector(
                          //                                         child:Text("Deny",style: TextStyle(color: Colors.grey.shade600,fontFamily: 'Gilroy'),),
                          //                                         onTap: (){
                          //                                           Navigator.pop(context);
                          //                                         },
                          //                                       ),
                          //                                       SizedBox(width: 15,),
                          //                                       GestureDetector(
                          //                                         onTap: (){
                          //                                           Navigator.pop(context);
                          //                                           showDialog(
                          //                                               context: context,
                          //                                               builder: (BuildContext context) {
                          //                                                 return Dialog(
                          //                                                   backgroundColor: Colors.white,
                          //                                                   shape: RoundedRectangleBorder(
                          //                                                       borderRadius:
                          //                                                       BorderRadius.circular(20.0)), //this right here
                          //                                                   child: Container(
                          //                                                     margin: EdgeInsets.all(10),
                          //                                                     padding: EdgeInsets.all(10),
                          //                                                     height: 320,
                          //                                                     child: Column(
                          //                                                       children: [
                          //                                                         Row(
                          //                                                           mainAxisAlignment: MainAxisAlignment.end,
                          //                                                           children: [
                          //                                                             Text("Post your commercial               ",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),),
                          //                                                             GestureDetector(
                          //                                                               child:SvgPicture.asset("assets/cross.svg",fit: BoxFit.none,),
                          //                                                               onTap: (){
                          //                                                                 Navigator.pop(context);
                          //                                                               },
                          //                                                             ),
                          //                                                           ],
                          //                                                         ),
                          //                                                         SizedBox(height: 5,),
                          //                                                         Row(
                          //                                                           children: [
                          //                                                             SizedBox(width: 10),
                          //                                                             Flexible(
                          //                                                               child: Column(
                          //                                                                 children: [
                          //                                                                   Container(
                          //                                                                     height: 100,
                          //                                                                     decoration:BoxDecoration(
                          //                                                                       color: Colors.white,
                          //                                                                       borderRadius: BorderRadius.circular(20),
                          //                                                                       boxShadow: [
                          //                                                                         BoxShadow(
                          //                                                                           color: Colors.black.withOpacity(0.3),
                          //                                                                           blurRadius: 1,
                          //                                                                           offset: const Offset(0,0.2),
                          //                                                                         ),
                          //                                                                       ],
                          //                                                                       image:DecorationImage(
                          //                                                                         scale: 1.0,
                          //                                                                         image: AssetImage('assets/OBJECTS.png'),
                          //                                                                       ),
                          //                                                                     ),
                          //                                                                   ),
                          //                                                                   SizedBox(height: 5,),
                          //                                                                   Row(
                          //                                                                     mainAxisAlignment: MainAxisAlignment.end,
                          //                                                                     children: [
                          //                                                                       InkWell(
                          //                                                                         onTap: ()async{
                          //
                          //                                                                         },
                          //                                                                         child: Container(
                          //                                                                           height: 10,
                          //                                                                           width: 50,
                          //                                                                           alignment: Alignment.center,
                          //                                                                           decoration: BoxDecoration(
                          //                                                                             color: Colors.black,
                          //                                                                             borderRadius: BorderRadius.all(Radius.circular(30)),
                          //                                                                             boxShadow: <BoxShadow>[
                          //                                                                               BoxShadow(
                          //                                                                                 color: Colors.black.withOpacity(0.99),
                          //                                                                                 blurRadius: 1,
                          //                                                                                 offset: const Offset(0,0.5),
                          //                                                                               )
                          //                                                                             ],
                          //                                                                           ),
                          //                                                                           child: Text(
                          //                                                                             'Change',
                          //                                                                             style: TextStyle(color: Colors.white,fontSize: 9 ,fontFamily: 'Gilroy'),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                       ),
                          //                                                                     ],
                          //                                                                   ),
                          //                                                                   SizedBox(height: 5,),
                          //                                                                   Row(
                          //                                                                     mainAxisAlignment: MainAxisAlignment.start,
                          //                                                                     children: [
                          //                                                                       Text("Add Description",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),)
                          //                                                                     ],
                          //                                                                   ),
                          //                                                                   SizedBox(height: 5,),
                          //                                                                   Container(
                          //                                                                     height: 70,
                          //                                                                     decoration:BoxDecoration(
                          //                                                                       color: Colors.white,
                          //                                                                       borderRadius: BorderRadius.circular(2),
                          //                                                                       boxShadow: [
                          //                                                                         BoxShadow(
                          //                                                                           color: Colors.black.withOpacity(0.3),
                          //                                                                           blurRadius: 1,
                          //                                                                           offset: const Offset(0,0.2),
                          //                                                                         ),
                          //                                                                       ],
                          //                                                                     ),
                          //                                                                   ),
                          //                                                                   Row(
                          //                                                                     mainAxisAlignment: MainAxisAlignment.end,
                          //                                                                     children: [
                          //                                                                       Text("280 words limit",style: TextStyle(fontFamily: 'Gilroy',fontSize: 10,color: Colors.black),)
                          //                                                                     ],
                          //                                                                   ),
                          //                                                                 ],
                          //                                                               ),
                          //                                                             ),
                          //                                                           ],
                          //                                                         ),
                          //                                                         SizedBox(height: 20,),
                          //                                                         Row(
                          //                                                           mainAxisAlignment: MainAxisAlignment.center,
                          //                                                           crossAxisAlignment: CrossAxisAlignment.center,
                          //                                                           children: [
                          //                                                             InkWell(
                          //                                                               onTap: ()async{
                          //
                          //                                                               },
                          //                                                               child: Container(
                          //                                                                 height: 20,
                          //                                                                 width: 100,
                          //                                                                 alignment: Alignment.center,
                          //                                                                 decoration: BoxDecoration(
                          //                                                                   color: Colors.black,
                          //                                                                   borderRadius: BorderRadius.all(Radius.circular(30)),
                          //                                                                   boxShadow: <BoxShadow>[
                          //                                                                     BoxShadow(
                          //                                                                       color: Colors.black.withOpacity(0.99),
                          //                                                                       blurRadius: 1,
                          //                                                                       offset: const Offset(0,0.5),
                          //                                                                     )
                          //                                                                   ],
                          //                                                                 ),
                          //                                                                 child: Text(
                          //                                                                   'Post',
                          //                                                                   style: TextStyle(color: Colors.white,fontSize: 9 ,fontFamily: 'Gilroy'),
                          //                                                                 ),
                          //                                                               ),
                          //                                                             ),
                          //                                                           ],
                          //                                                         ),
                          //                                                       ],
                          //                                                     ),
                          //                                                   ),
                          //                                                 );});
                          //                                         },
                          //                                         child:Text("Allow",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),),
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                           );
                          //                         },
                          //
                          //                       );
                          //                     },
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         });
                          //   },
                          // ),
                        ],
                        content: SingleChildScrollView(
                          child: Container(
                            width: double.maxFinite,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Divider(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                                  ),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (BuildContext context, int index) {
                                        return RadioListTile(
                                            title: Text(options[index]),
                                            value: index,
                                            groupValue: _selected,
                                            onChanged: (value) async {
                                              setState(() {
                                                _selected = index;
                                              });
                                            });
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}
