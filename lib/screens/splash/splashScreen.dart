import 'dart:async';
import 'package:abe/screens/loginScreen/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../signup/signupScreen.dart';

class splashScreen extends StatefulWidget{
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  initState(){
    super.initState();
    Timer(Duration(seconds: 5),() {
      Navigator.pushNamed(context, '/startUpScreen',);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration:BoxDecoration(
          image:DecorationImage(
            scale: 1.0,
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}