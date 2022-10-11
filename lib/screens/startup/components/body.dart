import 'dart:async';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'content.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  int currentPage = 0;

  List<Map<String, String>> onBoardingData = [
    {
      "image": "assets/image1.png",
      "title": "Discover Rare \n \nCollectibles",
    },
    {
      "image": "assets/image2.png",
      "title": "Discover Rare \n \nCollectibles",
    },
    {
      "image": "assets/image3.png",
      "title": "Discover Rare \n\n Collectibles",
    },
  ];

  @override
  initState(){
    super.initState();
    Timer(Duration(seconds: 5),() {
      Navigator.pushNamed(context, '/loginScreen',);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: size.height * 0.8,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onBoardingData.length,
              itemBuilder: (context, index) => Content(
                size: size,
                image: onBoardingData[index]["image"]!,
                title: onBoardingData[index]["title"]!,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onBoardingData.length,
                  (index) => Container(
                margin: EdgeInsets.only(right: 15),
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                  color: currentPage == index ? kPrimaryColor : Colors.white,
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}