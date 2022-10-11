import 'package:abe/view_models/auth/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../widgets/indicators.dart';
import '../../utils/validation.dart';
import '../password_form_builder.dart';
import '../text_form_builder.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:ionicons/ionicons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_)=> LoginViewModel(),
      child: LoginScreen(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);

    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _title(name,double size) {
    return Image.asset(
      'assets/${name}.png',
      width: size,
    );
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .height;
    return LoadingOverlay(
        progressIndicator: circularProgress(context),
        isLoading: viewModel.loading,
        child: ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .06),
                  _title('login',200.0),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Sign In",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200,fontFamily: 'Gilroy')),
                  SizedBox(
                    height: 20,
                  ),
                  // _emailPasswordWidget(),
                  _emailPasswordWidget(context,viewModel),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account? " ,style: TextStyle(color: Colors.black, fontFamily: 'Gilroy')),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/signupScreen',);
                        },
                        child: Row(
                          children: [
                            Text("Sign up" ,style: TextStyle(color: Colors.black, fontFamily: 'Gilroy')),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Sign in with",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black54,fontFamily: 'Gilroy')),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                        },
                        child: Row(
                          children: [
                            _title('apple', 25)
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        onTap: (){
                        },
                        child: Row(
                          children: [
                            _title('gmail', 25)
                          ],
                        ),
                      ),
                      SizedBox(height: 35,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    ));
  }

  _emailPasswordWidget(BuildContext context,LoginViewModel viewModel) {

    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.mail_outline,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passFN,
          ),
          SizedBox(height: 15.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_closed_outline,
            suffix: Ionicons.eye_outline,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.login(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
          ),
          SizedBox(height: 15.0),
          InkWell(
            onTap: ()async{
              viewModel.login(context);
            },
            child: Container(
              width: 155,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,)
                ],
              ),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white,fontFamily: 'Gilroy' ),
              ),
            ),
          )
        ],
      ),
    );
  }

}


