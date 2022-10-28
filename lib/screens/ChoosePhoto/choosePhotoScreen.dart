import 'package:abe/view_models/auth/posts_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../components/custom_image.dart';

class ChoosePhotoScreen extends StatefulWidget {
  @override
  _ChoosePhotoScreenState createState() => _ChoosePhotoScreenState();
}

class _ChoosePhotoScreenState extends State<ChoosePhotoScreen> {
  final nameController = TextEditingController();

  _imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //userController.profilePhoto = File(pickedFile.path);
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //userController.profilePhoto = File(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsViewModel>(
      create: (BuildContext context) => PostsViewModel(),
      child: Consumer<PostsViewModel>(
          builder: (context, PostsViewModel viewModel, Widget? child) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Your Photo',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Be creative when choosing a photo!',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                  color:  Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          // Center(
                          //   child: GestureDetector(
                          //     child: CircleAvatar(
                          //       radius: 55,
                          //       backgroundColor:  Colors.black,
                          //       // child: userController.profilePhoto != null
                          //       //     ? ClipRRect(
                          //       //   borderRadius: BorderRadius.circular(50),
                          //       //   child:
                          //       //   Image.file(
                          //       //     userController.profilePhoto,
                          //       //     width: 100,
                          //       //     height: 100,
                          //       //     fit: BoxFit.fitHeight,
                          //       //   ),
                          //       // )
                          //       //     : Container(
                          //       //   decoration: BoxDecoration(
                          //       //       color:  Colors.white,
                          //       //       borderRadius: BorderRadius.circular(50)),
                          //       //   width: 100,
                          //       //   height: 100,
                          //       //   child: Icon(
                          //       //     Icons.camera_alt,
                          //       //     color: Colors.grey[800],
                          //       //   ),
                          //       // ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          GestureDetector(
                            onTap: () => showImageChoices(context, viewModel),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: viewModel.imgLink != null
                                  ? CustomImage(
                                imageUrl: viewModel.imgLink,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 30,
                                fit: BoxFit.cover,
                              )
                                  : viewModel.mediaUrl == null

                                  ? Center(
                                child: Text(
                                  'Tap to add your profile picture',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              )
                                  : Image.file(
                                viewModel.mediaUrl!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(28.0),
                              //     child: Text(
                              //       "BACK",
                              //       style: TextStyle(color: Colors.white, fontSize: 18),
                              //     ),
                              //   ),
                              // ),
                              // abi yeh karo aur sath test bhi ho jay ga sign up and login ka password email galt lihk k test karo abi
                              GestureDetector(
                                onTap: () {
                                  viewModel.uploadProfilePicture(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Text(
                                    viewModel.mediaUrl != null
                                        ? "NEXT"
                                        : 'Skip',
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                  ),

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ) // This trailing comma makes auto-formatting nicer for build methods.
            );
          },
      )
    );
  }

  showImageChoices(BuildContext context, PostsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select from  ${viewModel.mediaUrl}'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Ionicons.camera_outline),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(camera: true,context: context);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(context: context);
                  // viewModel.pickProfilePicture();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
