import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../chats/recent_chats.dart';
import '../../container/drawer_container.dart';
import '../../models/user.dart';
import '../../utils/firebase.dart';
import '../discover/discoverScreen.dart';
import '../homePage/homePageScreen.dart';
import '../search/searchScreen.dart';

// ignore: must_be_immutable
class CategoriesTab extends StatefulWidget {
  final String postId;

  CategoriesTab({required this.postId});
  @override
  _CategoriesTabState createState() => _CategoriesTabState(this.postId);
}

class _CategoriesTabState extends State<CategoriesTab> {
  final postId_;
  _CategoriesTabState(this.postId_);
  @override
  // ignore: must_call_super
  void initState() {
  }
  TextEditingController P_PlatinumBenefits=TextEditingController();
  TextEditingController P_GoldBenefits=TextEditingController();
  TextEditingController P_SilverBenefits=TextEditingController();
  TextEditingController P_BronzeBenefits=TextEditingController();
  TextEditingController P_KindBenefits=TextEditingController();
  TextEditingController I_PlatinumBenefits=TextEditingController();
  TextEditingController I_GoldBenefits=TextEditingController();
  TextEditingController I_SilverBenefits=TextEditingController();
  TextEditingController I_BronzeBenefits=TextEditingController();
  TextEditingController I_KindBenefits=TextEditingController();
  TextEditingController S_PlatinumBenefits=TextEditingController();
  TextEditingController S_GoldBenefits=TextEditingController();
  TextEditingController S_SilverBenefits=TextEditingController();
  TextEditingController S_BronzeBenefits=TextEditingController();
  TextEditingController S_KindBenefits=TextEditingController();
  TextEditingController P_PlatinumAmount=TextEditingController();
  TextEditingController P_GoldAmount=TextEditingController();
  TextEditingController P_SilverAmount=TextEditingController();
  TextEditingController P_BronzeAmount=TextEditingController();
  TextEditingController P_KindAmount=TextEditingController();
  TextEditingController I_PlatinumAmount=TextEditingController();
  TextEditingController I_GoldAmount=TextEditingController();
  TextEditingController I_SilverAmount=TextEditingController();
  TextEditingController I_BronzeAmount=TextEditingController();
  TextEditingController I_KindAmount=TextEditingController();
  TextEditingController S_PlatinumAmount=TextEditingController();
  TextEditingController S_GoldAmount=TextEditingController();
  TextEditingController S_SilverAmount=TextEditingController();
  TextEditingController S_BronzeAmount=TextEditingController();
  TextEditingController S_KindAmount=TextEditingController();
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
    Chats(),
    Home(),
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Ionicons.close_outline),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('ADD DETAILS'.toUpperCase(),style: TextStyle(fontSize: 14),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              postRef.doc(widget.postId).update({
                "partner":{"bronze":{"amount":"${P_BronzeAmount.text}","benefits":"${P_BronzeBenefits.text}"},"gold":{"amount":"${P_GoldAmount.text}","benefits":"${P_GoldBenefits.text}"},"platinum":{"amount":"${P_PlatinumAmount.text}","benefits":"${P_PlatinumBenefits.text}"},"silver":{"amount":"${P_SilverAmount.text}","benefits":"${P_SilverBenefits.text}"},"kind":{"amount":"${P_KindAmount.text}","benefits":"${P_KindBenefits.text}"},},
                "investor":{"bronze":{"amount":"${I_BronzeAmount.text}","benefits":"${I_BronzeBenefits.text}"},"gold":{"amount":"${I_GoldAmount.text}","benefits":"${I_GoldBenefits.text}"},"platinum":{"amount":"${I_PlatinumAmount.text}","benefits":"${I_PlatinumBenefits.text}"},"silver":{"amount":"${I_SilverAmount.text}","benefits":"${I_SilverBenefits.text}"},"kind":{"amount":"${I_KindAmount.text}","benefits":"${I_KindBenefits.text}"},},
                "sponsor":{"bronze":{"amount":"${S_BronzeAmount.text}","benefits":"${S_BronzeBenefits.text}"},"gold":{"amount":"${S_GoldAmount.text}","benefits":"${S_GoldBenefits.text}"},"platinum":{"amount":"${S_PlatinumAmount.text}","benefits":"${S_PlatinumBenefits.text}"},"silver":{"amount":"${S_SilverAmount.text}","benefits":"${S_SilverBenefits.text}"},"kind":{"amount":"${S_KindAmount.text}","benefits":"${S_KindBenefits.text}"},},

              });
              Navigator.pushNamed(context, '/commercialScreen');
              showInSnackBar('Uploaded successfully!', context);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Post'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          )
        ],
      ),
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: 900,
              child: Column(
                children: [
                  Container(

                    height: 50,
                    child: TabBar(
                        onTap: (index) {
                        },
                        indicatorColor: Colors.black54,
                        isScrollable: true,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: "Partner",
                          ),
                          Tab(
                            text: "Investor",
                          ),
                          Tab(
                            text: "Sponsor",
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Partner(),
                        Sponsor(),
                        Investor()
                      ],
                    ),
                  ),
                ],
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
          )
      ),
    );
  }
  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  Partner(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text("Become a Partner",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,fontFamily: 'Gilroy'),),
              SizedBox(width: 20,),
              _title('partner1',90.0),
            ],
          ),
          SizedBox(height: 10,),
          Container(
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
                Row(
                  children: [
                    Expanded(child: Text("   ")),
                    Expanded(child: Text("     Benefits")),
                    Expanded(child: Text("         Amount")),
                  ],
                ),
                textFieldWidget("Platinum",P_PlatinumBenefits),
                textFieldWidget("Gold",P_GoldBenefits),
                textFieldWidget("Silver",P_SilverBenefits),
                textFieldWidget("Bronze",P_BronzeBenefits),
                textFieldWidget("In kind",P_KindBenefits),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Investor(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text("Become a Investor",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,fontFamily: 'Gilroy'),),
              SizedBox(width: 20,),
              _title('investor1',90.0),
            ],
          ),
          SizedBox(height: 10,),
          Container(
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
                Row(
                  children: [
                    Expanded(child: Text("   ")),
                    Expanded(child: Text("     Benefits")),
                    Expanded(child: Text("         Amount")),
                  ],
                ),
                textFieldWidget("Platinum",I_PlatinumBenefits),
                textFieldWidget("Gold",I_GoldBenefits),
                textFieldWidget("Silver",I_SilverBenefits),
                textFieldWidget("Bronze",I_BronzeBenefits),
                textFieldWidget("In kind",I_KindBenefits),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Sponsor(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text("Become a Sponsor",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,fontFamily: 'Gilroy'),),
              SizedBox(width: 20,),
              _title('sponsor1',70.0),
            ],
          ),
          SizedBox(height: 10,),
          Container(
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
                Row(
                  children: [
                    Expanded(child: Text("   ")),
                    Expanded(child: Text("     Benefits")),
                    Expanded(child: Text("         Amount")),
                  ],
                ),
                textFieldWidget("Platinum",S_PlatinumBenefits),
                textFieldWidget("Gold",S_GoldBenefits),
                textFieldWidget("Silver",S_SilverBenefits),
                textFieldWidget("Bronze",S_BronzeBenefits),
                textFieldWidget("In kind",S_KindBenefits),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget  textFieldWidget(name,appPass) {
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
                controller: appPass,
                maxLines: null,
                onChanged: (appPass){
                  setState(() {
                    appPass=appPass;
                  });
                },
                obscureText: false,
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText:"",
                    border: InputBorder.none
                )
            ),
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget _title(name,double size) {
    return Image.asset(
      'assets/${name}.png',
      width: size,
    );
  }

  Future<UserModel> getUsers(String id)async{

    UserModel allUserList = UserModel();
    await usersRef
        .doc(id).get()
        .then((qSnap) {
      allUserList= UserModel.fromDocumentSnapshot(qSnap);
    });
    return allUserList ;
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
      ],
    );
  }

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }



}