import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:abe/screens/password_form_builder.dart';
import 'package:abe/screens/text_form_builder.dart';
import 'package:abe/utils/validation.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../view_models/auth/register_view_model.dart';
import '../../widgets/indicators.dart';

class Sign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_)=> RegisterViewModel(),
      child: signupScreen(), // So Provider.of<FormProvider>(context) can be read here
    );
  }
}

class signupScreen extends StatefulWidget {
  const signupScreen({Key? key}) : super(key: key);
  @override
  _signupScreenState createState() => _signupScreenState();
}
const _items = ['Personal','Business'];
class _signupScreenState extends State<signupScreen>{

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
  String? selectedCategory;

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            hintText: "First Name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.firstnameFN,
            nextFocusNode: viewModel.lastnameFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            hintText: "Last Name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName1(val);
            },
            focusNode: viewModel.lastnameFN,
            nextFocusNode: viewModel.numberFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            hintText: "Number",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateMobile,
            onSaved: (String val) {
              viewModel.setNumber(val);
            },
            focusNode: viewModel.numberFN,
            nextFocusNode: viewModel.emailFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel..setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_open_outline,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            // submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_open_outline,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            // submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
            nextFocusNode: viewModel.aboutFN,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildChips()
            ],
          ),
          SizedBox(height: 25.0),
          _selectedIndex==1?TextFormBuilder(
            enabled: !viewModel.loading,
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            hintText: "About",
            onSaved: (String val) {
              viewModel.setAbout(val);
            },
            focusNode: viewModel.aboutFN,
          ):Container(),
          InkWell(
            onTap: (){
              if(_selectedIndex==0){
                viewModel.register(context,'Personal');
              }
              else{
                viewModel.register(context,'Business');
              }
            },
            child: Container(
              height: 36.0,
              width: 155.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,)
                ],
              ),
              child: Text(
                'Sign Up'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  int _selectedIndex=0;
  List<String> _options = ['Personal Account',' Business Page'];

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i], style: TextStyle(color: Colors.white)),
        elevation: 5,
        pressElevation: 5,
        backgroundColor: Colors.grey[400],
        selectedColor: Colors.black,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(choiceChip);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: chips,
    );
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }



  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<RegisterViewModel>(context);
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
      create: (_)=> viewModel,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .06),
                    _title('signup',200.0),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Sign Up",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200,fontFamily: 'Gilroy')),
                    SizedBox(
                      height: 20,
                    ),
                    // _textFieldWidget(),
                    buildForm(viewModel,context),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account? " ,style: TextStyle(color: Colors.black, fontFamily: 'Gilroy')),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/loginScreen');
                          },
                          child: Row(
                            children: [
                              Text("Sign In" ,style: TextStyle(color: Colors.black, fontFamily: 'Gilroy')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    ));
  }

}
