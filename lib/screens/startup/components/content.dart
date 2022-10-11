import 'package:flutter/material.dart';
import 'constants.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.size,
    required this.image,
    required this.title,
  }) : super(key: key);

  final Size size;
  final image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              RichText(
                text: TextSpan(
                  text: 'Discover Rare \n ',
                  style: kHeadingTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: 'Collectibles', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Text to Fill provides a flexible platform to sell your products or \n services so that you can focus on your sales provides a flexible\n platform to sell your products or services so that you can focus on\n your sales.",
                textAlign: TextAlign.center,
                style: kDefaultTextStyle.copyWith(fontSize: 12,fontFamily: 'Gilroy'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}