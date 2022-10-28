import 'package:flutter/material.dart';

import 'constants.dart';


friendCardRow(
    {photoLink = '',
    name = '',
    btnText = '',
    icon = Icons.fiber_manual_record_rounded,
    onTapfunction,
    btnColor = Colors.black,
    disableButton = false,
    userData}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Get.to(ProfileView(
                //   userData: userData,
                // ));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(photoLink == '' ? placeHolder : photoLink),
                maxRadius: 30,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            if (!disableButton)
              Center(
                child: InkWell(
                  onTap: onTapfunction,
                  child: Card(
                    color: btnColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text(
                            btnText,
                            style: TextStyle(fontSize: 14,color: Colors.white),
                          ),
                          Icon(
                            icon,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
