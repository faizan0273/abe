import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../utils/firebase.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? firstname,lastname, email, number, password, cPassword,about='';
  FocusNode firstnameFN = FocusNode();
  FocusNode lastnameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode numberFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  FocusNode aboutFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context,type) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      if (password == cPassword) {
        loading = true;
        notifyListeners();
        try {
          if(type=='Personal') {
            bool success = await auth.createUser(
              firstname: firstname,
              lastname: lastname,
              email: email,
              password: password,
              number: number,
              type: type,
            );
            List<UserModel> allUserList = [];
            String ty='Personal';
            await usersRef
                .where('id', isNotEqualTo: firebaseAuth.currentUser!.uid)
                .get()
                .then((qSnap) {
              if (qSnap.docs.length > 0) {
                allUserList.clear();
                qSnap.docs.forEach((element) {
                  //* in future we can also remove friend whom already request sent
                  allUserList.add(UserModel.fromDocumentSnapshot(element));
                });
              }
            });
            for(var i=0;i<allUserList.length&&allUserList[i].type=='Personal';i++){
              suggestionRef
                  .doc(auth.getCurrentUser().uid)
                  .collection('suggestions').doc(allUserList[i].id).set({});
              suggestionRef
                  .doc(allUserList[i].id)
                  .collection('suggestions').doc(auth.getCurrentUser().uid).set({});
            }
            await auth.getCurrentUser().updateDisplayName("${firstname}");
            if (success) {
              Navigator.pushNamed(context, '/choosePhoto',);
            }
          }
            else if(type=='Business'){
              bool success = await auth.createUser(
                firstname: firstname,
                lastname: lastname,
                email: email,
                password: password,
                number: number,
                type:type,
              );
              await auth.getCurrentUser().updateDisplayName("${firstname}");
              if (success) {
                usersRef.doc(auth.getCurrentUser().uid).update({
                  'about':'${about}',
                });
                Navigator.pushNamed(context, '/choosePhoto',);
              }
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e);
          showInSnackBar(
              '${auth.handleFirebaseAuthError(e.toString())}', context);
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords does not match', context);
      }
    }
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setAbout(val) {
    about = val;
    print(about);
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setName(val) {
    firstname = val;
    notifyListeners();
  }

  setName1(val) {
    lastname = val;
    notifyListeners();
  }

  setConfirmPass(val) {
    cPassword = val;
    notifyListeners();
  }

  setNumber(val) {
    number = val;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
