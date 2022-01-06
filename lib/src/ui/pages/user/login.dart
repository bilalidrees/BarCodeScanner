import 'package:flutter/material.dart';
import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';
import 'package:barcode_scanner/src/bloc/utility/SharedPrefrence.dart';
import 'package:barcode_scanner/src/bloc/utility/Validations.dart';
import 'package:barcode_scanner/src/model/User.dart';
import 'package:barcode_scanner/src/resource/networkConstant.dart';
import 'package:toast/toast.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/AppColors.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/string.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/style.dart';
import 'package:barcode_scanner/src/ui/widgets/CustomButton.dart';
import 'package:barcode_scanner/src/ui/widgets/CustomTextField.dart';
import 'package:barcode_scanner/src/bloc/AuthenticationBloc.dart';

import '../../../../route_generator.dart';
import 'package:barcode_scanner/src/ui/widgets/CustomBackButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? username, password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  bool _isVisible = false,
      isToShowLoginDialog = false,
      isPasswordHidden = true,
      isKeyBoardOpen = false,
      userStatus = false;

  setVisiblity(bool visiblity) {
    setState(() {
      _isVisible = visiblity;
    });
  }

  setPasswordStatus() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      User? user = await SharedPref.createInstance().getCurrentUser();
      if (user == null) {
        setState(() {
          userStatus = true;
        });
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.SPLASH);
      }
    });
    authenticationBloc.userAuthStream.listen((status) {
      if (status == "Error") {
        Toast.show("Error", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        saveUser(
            user: User(
          email: emailController.text,
          password: passwordController.text,
        ));
      }
    }, onError: (exception) {
      Toast.show(exception.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: userStatus ? loginWithEmailWidget(context) : Container(),
      ),
    );
  }

  Widget loginWithEmailWidget(BuildContext context) {
    final app = AppConfig(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.red, Colors.white54])),
      child: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  margin: EdgeInsets.all(AppConfig.of(context).appWidth(5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: app.appHeight(5)),
                          Form(
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: AppConfig.of(context).appWidth(5),
                                  right: AppConfig.of(context).appWidth(5)),
                              child: Column(
                                children: <Widget>[
                                  CustomTextField(
                                      "Email",
                                      TextInputType.text,
                                      VALIDATION_TYPE.TEXT,
                                      Icons.account_circle,
                                      emailController,
                                      false,
                                      () {}),
                                  SizedBox(height: app.appHeight(2)),
                                  CustomTextField(
                                      "Password",
                                      TextInputType.visiblePassword,
                                      VALIDATION_TYPE.PASSWORD,
                                      Icons.lock,
                                      passwordController,
                                      isPasswordHidden, () {
                                    setPasswordStatus();
                                  }),
                                  SizedBox(height: app.appHeight(1)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: app.appHeight(3)),
                          Container(
                            margin: EdgeInsets.only(
                                left: AppConfig.of(context).appWidth(5),
                                right: AppConfig.of(context).appWidth(5)),
                            child: CustomButton(
                              onPressed: () async {
                                authenticationBloc.userAuth(
                                    user: User(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                    url: NetworkConstants.LOGIN_URL);
                                setState(() {
                                  _isVisible = true;
                                });
                              },
                              radius: 10,
                              text: "login",
                              textColor: Colors.white,
                              backgorundColor: Colors.red,
                              width: AppConfig.of(context).appWidth(84),
                              isToShowEndingIcon: false,
                            ),
                          ),
                          SizedBox(height: app.appHeight(3)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
//          top: AppConfig.of(context).appHeight(50),
//          right: AppConfig.of(context).appHeight(28),
            child: Visibility(
                visible: _isVisible,
                child: Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }

  Future<void> saveUser({User? user}) async {
    await SharedPref.createInstance().setCurrentUser(user!);
    Navigator.pushReplacementNamed(context, RouteNames.SPLASH);
  }
}
