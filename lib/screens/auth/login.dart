import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_basic/data/auth/login.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  TextFormField emailTextField, passwordTextField;
  RaisedButton loginButton, registerButton;
  bool isLoading = false;
  Image logo;
  Column mainColumn;
  Container progressLoader;

  @override
  Widget build(BuildContext context) {
    emailTextField = CommonAppWidgets.makeCommonTextField(
        TextInputType.emailAddress,
        false,
        false,
        Icon(Icons.email),
        null,
        null,
        AppStrings.EMAIL_HINT,
        new TextEditingController());

    passwordTextField = CommonAppWidgets.makeCommonTextField(
        null,
        false,
        true,
        Icon(Icons.lock),
        null,
        null,
        AppStrings.PASSWORD_HINT,
        new TextEditingController());

    loginButton = CommonAppWidgets.makeCommonButton(AppStrings.LOGIN_BUTTON,
        Colors.lightBlueAccent, Colors.white, onLoginButtonClick);

    registerButton = CommonAppWidgets.makeCommonButton(
        AppStrings.REGISTER_BUTTON,
        Colors.lightBlueAccent,
        Colors.white,
        onRegisterButtonClick);

    logo = Image.asset('assets/images/flutter.png', height: 80, width: 80);

    progressLoader = CommonAppWidgets.makeCommonLoader();

    mainColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        logo,
        SizedBox(
          height: 50,
        ),
        emailTextField,
        SizedBox(
          height: 10,
        ),
        passwordTextField,
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginButton,
            SizedBox(
              width: 15,
            ),
            registerButton
          ],
        ),
      ],
    );

    return Scaffold(
      body: Stack(children: [
        Container(padding: const EdgeInsets.all(10.0), child: mainColumn),
        isLoading ? progressLoader : Container()
      ]),
    );
  }

  void onLoginButtonClick() {
    String email = emailTextField.controller.text;
    String password = passwordTextField.controller.text;

    setState(() {
      isLoading = true;
    });

    login(email, password);
  }

  void onRegisterButtonClick() {
    Navigator.of(context).pushNamed(Routes.REGISTER);
  }

  void onDialogOKClick() {
    Navigator.pop(context);
  }

  void onDialogCancelClick() {
    Navigator.pop(context);
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(HttpServer.BASE_URL + HttpServer.LOGIN,
        body: Login(email: email, password: password).toJson());

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      debugPrint(
          'response: ${(LoginResponse.fromJson(jsonDecode(response.body))).token}');

      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {

      showDialog(
          context: context,
          child: CommonAppWidgets.makeCommonAlertDialog(
              AppStrings.DIALOG_TITLE_ERROR,
              AppStrings.COMMON_ERROR_MESSAGE,
              CommonAppWidgets.makeCommonButton(AppStrings.DIALOG_CANCEL,
                  Colors.lightBlueAccent, Colors.white, onDialogCancelClick),
              CommonAppWidgets.makeCommonButton(AppStrings.DIALOG_OK,
                  Colors.lightBlueAccent, Colors.white, onDialogOKClick)));

      throw Exception('Failed to load album');
    }
  }
}
