import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';

class UserViewModel extends ChangeNotifier {
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  setUser() {
    user = auth.currentUser;
    //notifyListeners();
  }
}
