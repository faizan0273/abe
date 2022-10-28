import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:abe/components/custom_image.dart';
import 'package:abe/models/user.dart';
import 'package:abe/utils/firebase.dart';
import 'package:abe/view_models/auth/posts_view_model.dart';
import 'package:abe/widgets/indicators.dart';

class createPostC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsViewModel>(
      create: (_)=> PostsViewModel(),
      child: CreatePostC(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}

class CreatePostC extends StatefulWidget {
  @override
  _CreatePostCState createState() => _CreatePostCState();
}

class _CreatePostCState extends State<CreatePostC> {
  @override
  Widget build(BuildContext context) {
    currentUserId() {
      return firebaseAuth.currentUser!.uid;
    }

    PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        await viewModel.resetPost();
        return true;
      },
      child: LoadingOverlay(
        progressIndicator: circularProgress(context),
        isLoading: viewModel.loading,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Ionicons.close_outline),
              onPressed: () {
                viewModel.resetPost();
                Navigator.pop(context);
              },
            ),
            title: Text('Post your Community'.toUpperCase(),style: TextStyle(fontSize: 14),),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  await viewModel.uploadPostsC(context);
                  Navigator.pop(context);
                  viewModel.resetPost();
                  Navigator.pushNamed(context, '/communityPageScreen');
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
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              SizedBox(height: 15.0),
              // StreamBuilder(
              //   stream: usersRef.doc(currentUserId()).snapshots(),
              //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     if (snapshot.hasData) {
              //       UserModel user = UserModel.fromJson(
              //         snapshot.data!.data() as Map<String, dynamic>,
              //       );
              //       return ListTile(
              //         leading: CircleAvatar(
              //           radius: 25.0,
              //           backgroundImage: NetworkImage(user!.photoUrl!.toString()),
              //         ),
              //         title: Text(
              //           user!.username!,
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //         subtitle: Text(
              //           user!.email!,
              //         ),
              //       );
              //     }
              //     return Container();
              //   },
              // ),
              InkWell(
                onTap: () => showImageChoices(context, viewModel),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    border: Border.all(
                      color: Colors.black,
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
                      'Upload a Photo',
                      style: TextStyle(
                        color:Colors.black,
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
              SizedBox(height: 20.0),
              Text(
                'Add Description'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                initialValue: viewModel.description,
                decoration: InputDecoration(
                  hintText: 'Type here',
                  focusedBorder: UnderlineInputBorder(),
                ),
                maxLines: null,
                onChanged: (val) => viewModel.setDescription(val),
              ),
              // SizedBox(height: 20.0),
              // Text(
              //   'Location'.toUpperCase(),
              //   style: TextStyle(
              //     fontSize: 15.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // ListTile(
              //   contentPadding: EdgeInsets.all(0.0),
              //   title: Container(
              //     width: 250.0,
              //     child: TextFormField(
              //       controller: viewModel.locationTEC,
              //       decoration: InputDecoration(
              //         contentPadding: EdgeInsets.all(0.0),
              //         hintText: 'United States,Los Angeles!',
              //         focusedBorder: UnderlineInputBorder(),
              //       ),
              //       maxLines: null,
              //       onChanged: (val) => viewModel.setLocation(val),
              //     ),
              //   ),
              //   trailing: IconButton(
              //     tooltip: "Use your current location",
              //     icon: Icon(
              //       CupertinoIcons.map_pin_ellipse,
              //       size: 25.0,
              //     ),
              //     iconSize: 30.0,
              //     color: Theme.of(context).colorScheme.secondary,
              //     onPressed: () => viewModel.getLocation(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
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
                  'Select Image',
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
                  viewModel.pickImage(camera: true);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
