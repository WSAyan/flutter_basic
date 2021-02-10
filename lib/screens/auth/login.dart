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

    final logo =
        Image.asset('assets/images/flutter.png', height: 80, width: 80);

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
          )),
    );
  }

  void onLoginButtonClick() {
    String email = emailTextField.controller.text;
    String password = passwordTextField.controller.text;

    login(email, password);
    //log('email: $email ----- password: $password');
  }

  void onRegisterButtonClick() {
    Navigator.of(context).pushNamed(Routes.REGISTER);
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(HttpServer.BASE_URL + HttpServer.LOGIN,
        body: Login(email: email, password: password).toJson());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      debugPrint(
          'response: ${(LoginResponse.fromJson(jsonDecode(response.body))).token}');
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
