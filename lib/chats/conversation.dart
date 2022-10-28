import 'package:abe/screens/components/chat_components/components/messageBox.dart';
import 'package:abe/screens/view_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:abe/components/chat_bubble.dart';
import 'package:abe/models/enum/message_type.dart';
import 'package:abe/models/message.dart';
import 'package:abe/models/user.dart';
import 'package:abe/utils/firebase.dart';
import 'package:abe/view_models/conversation/conversation_view_model.dart';
import 'package:abe/view_models/user/user_view_model.dart';
import 'package:abe/widgets/indicators.dart';
import 'package:timeago/timeago.dart' as timeago;

class Conversation extends StatelessWidget {
  final String userId;
  final String chatId;
  const Conversation({required this.userId, required this.chatId});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel >(create: (_) => UserViewModel()),
          ChangeNotifierProvider<ConversationViewModel>(create: (_) => ConversationViewModel()),
    ],
      child: Conversationa(userId: this.userId,chatId: this.chatId,),
    );
  }
}

class Conversationa extends StatefulWidget {
  String userId;
  String chatId;

  Conversationa({required this.userId, required this.chatId});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversationa> {
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool isFirst = false;
  String? chatId;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      focusNode.unfocus();
    });
    if (widget.chatId == 'newChat') {
      isFirst = true;
    }
    chatId = widget.chatId;

    messageController.addListener(() {
      if (focusNode.hasFocus && messageController.text.isNotEmpty) {
        setTyping(true);
      } else if (!focusNode.hasFocus ||
          (focusNode.hasFocus && messageController.text.isEmpty)) {
        setTyping(false);
      }
    });
  }

  setTyping(typing) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    viewModel.setUser();
    var user = Provider.of<UserViewModel>(context, listen: true).user;
    Provider.of<ConversationViewModel>(context, listen: false)
        .setUserTyping(widget.chatId, user, typing);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    viewModel.setUser();
    var user = Provider.of<UserViewModel>(context, listen: true).user;
    return Consumer<ConversationViewModel>(
        builder: (BuildContext context, viewModel, Widget? child) {
      return Scaffold(
        key: viewModel.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: buildUserName(),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: messageListStream(widget.chatId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List messages = snapshot.data!.docs;
                      viewModel.setReadCount(
                          widget.chatId, user, messages.length);
                      return ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          Message message = Message.fromJson(
                            messages.reversed.toList()[index].data(),
                          );
                          return MessageBox(
                            message: '${message.content}',
                            time: message.time!,
                            isMe: message.senderUid == user!.uid,
                            type: message.type!,
                            sender: user!.uid,
                            reciepent: message.senderUid,
                          );
                        },
                      );
                    } else {
                      return Center(child: circularProgress(context));
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomAppBar(
                  elevation: 10.0,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxHeight: 100.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child:Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.photo_on_rectangle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () => showPhotoOptions(viewModel, user),
                        ),
                        Flexible(
                          child: TextField(
                            controller: messageController,
                            focusNode: focusNode,
                            style: TextStyle(
                              fontSize: 15.0,
                              color:Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "Type your message",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset("assets/send.svg",fit: BoxFit.none,color: Colors.white,),
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              sendMessage(viewModel, currentUserId());
                            }
                          },
                        ),
                        // Container(
                        //   height: 30,
                        //   width: 30,
                        //   decoration: BoxDecoration(
                        //     color: Colors.black,
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.white,
                        //         blurRadius: 2,
                        //         offset: const Offset(0,0.2),
                        //       ),
                        //     ],
                        //   ),
                        //   child:SvgPicture.asset("assets/send.svg",fit: BoxFit.none,color: Colors.white,),
                        // ),
                        //SizedBox(width: 10,)

                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _buildOnlineText(var user, bool typing,) {
    if (user.isOnline) {
      if (typing) {
        return "typing...";
      } else {
        return "online";
      }
    }
    else {
      return 'last seen';
    }
  }

  buildUserName() {
    return StreamBuilder(
      stream: usersRef.doc('${widget.userId}').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot documentSnapshot =
              snapshot.data as DocumentSnapshot<Object?>;
          UserModel user = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>,
          );
          return Column(
            children: [
              SizedBox(height: 30,),
              Row(
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
                      onTap: () => Navigator.of(context).pop(),

                      child:SvgPicture.asset("assets/back.svg",),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/login.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: user?.photoUrl==''?
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                      radius: 30.0,
                    ):
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoUrl.toString()),
                      radius: 30.0,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user!.username}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy'
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     StreamBuilder(
                      //       stream: chatRef.doc('${chatId}').snapshots(),
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasData) {
                      //           DocumentSnapshot? snap =
                      //           snapshot.data as DocumentSnapshot<Object?>;
                      //           Map? data = snap.data() as Map<dynamic, dynamic>?;
                      //           Map? usersTyping = data?['typing'] ?? {};
                      //           return Text(
                      //             _buildOnlineText(
                      //               user,
                      //               usersTyping![widget.userId] ?? false,
                      //             ),
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 11,
                      //             ),
                      //           );
                      //         } else {
                      //           return SizedBox();
                      //         }
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              Divider(thickness: 0.4,color: Colors.grey,),
              SizedBox(height: 30,),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  showPhotoOptions(ConversationViewModel viewModel, var user) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Camera"),
              onTap: () {
                sendMessage(viewModel, user, imageType: 0, isImage: true);
              },
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
                sendMessage(viewModel, user, imageType: 1, isImage: true);
              },
            ),
          ],
        );
      },
    );
  }

  sendMessage(ConversationViewModel viewModel, var user,
      {bool isImage = false, int? imageType}) async {
    String msg;
    if (isImage) {
      msg = await viewModel.pickImage(
        source: imageType!,
        context: context,
        chatId: widget.chatId,
      );
    } else {
      msg = messageController.text.trim();
      messageController.clear();
    }

    Message message = Message(
      content: '$msg',
      senderUid: user,
      type: isImage ? MessageType.IMAGE : MessageType.TEXT,
      time: Timestamp.now(),
    );


    if (msg.isNotEmpty) {
      if (isFirst) {
        String id = await viewModel.sendFirstMessage(widget.userId, message);
        setState(() {
          isFirst = false;
          widget.chatId = id.toString();
        });
      } else {
        viewModel.sendMessage(
          widget.chatId,
          message,
        );
      }
    }
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }
}
