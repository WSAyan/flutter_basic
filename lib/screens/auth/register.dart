import 'package:flutter/material.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  TextFormField emailTextField, passwordTextField;
  RaisedButton registerButton;
  bool isLoading = false;
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

    registerButton = CommonAppWidgets.makeCommonButton(
        AppStrings.REGISTER_BUTTON,
        Colors.lightBlueAccent,
        Colors.white,
        onRegisterButtonClick);

    mainColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        emailTextField,
        SizedBox(
          height: 10,
        ),
        passwordTextField,
        SizedBox(
          height: 15,
        ),
        registerButton,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.REGISTER_SCREEN_TITLE),
      ),
      body: Stack(children: [
        Container(padding: const EdgeInsets.all(10.0), child: mainColumn),
        isLoading ? progressLoader : Container()
      ]),
    );
  }

  void onRegisterButtonClick() {}
}
