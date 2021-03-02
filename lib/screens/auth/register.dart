import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_basic/data/register.dart';
import 'package:flutter_basic/network/helper.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/image_utils.dart';
import 'package:flutter_basic/utils/widgets.dart';
import 'package:flutter_basic/utils/routes.dart' as routes;

class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  TextFormField emailTextField, passwordTextField, nameTextField;
  RaisedButton registerButton;
  bool isLoading = false;
  Column mainColumn;
  Container progressLoader;
  File selectedImage;

  @override
  Widget build(BuildContext context) {
    nameTextField = CommonAppWidgets.makeCommonTextField(
        TextInputType.text,
        false,
        false,
        Icon(Icons.person),
        null,
        null,
        AppStrings.NAME_HINT,
        new TextEditingController());

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

    progressLoader = CommonAppWidgets.makeCommonLoader();

    mainColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: selectedImage == null
              ? Icon(Icons.add_a_photo, size: 100)
              : ClipOval(
                  child: Image.file(selectedImage,
                      height: 100, width: 100, fit: BoxFit.cover),
                ),
          onTap: onAddPhotoClick,
        ),
        SizedBox(
          height: 20,
        ),
        nameTextField,
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
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(padding: const EdgeInsets.all(10.0), child: mainColumn),
            isLoading ? progressLoader : Container()
          ]),
        ));
  }

  void onRegisterButtonClick() {
    String email = emailTextField.controller.text;
    String password = passwordTextField.controller.text;

    setState(() {
      isLoading = true;
    });

    HttpRepository()
        .register(email, password)
        .then((value) => onRegisterResponse(value));
  }

  void onRegisterResponse(RegisterResponse registerResponse) {
    setState(() {
      isLoading = false;
    });

    if (registerResponse == null) {
      showDialog(
          context: context,
          child: CommonAppWidgets.makeCommonAlertDialog(
              AppStrings.DIALOG_TITLE_ERROR,
              AppStrings.COMMON_ERROR_MESSAGE,
              CommonAppWidgets.makeCommonButton(AppStrings.DIALOG_CANCEL,
                  Colors.lightBlueAccent, Colors.white, onDialogCancelClick),
              CommonAppWidgets.makeCommonButton(AppStrings.DIALOG_OK,
                  Colors.lightBlueAccent, Colors.white, onDialogOKClick)));
      return;
    }

    CommonAppWidgets.showCommonToast(AppStrings.REGISTER_SUCCESSFUL);

    Navigator.of(context).pushNamed(routes.LOGIN);
  }

  void onDialogOKClick() {
    Navigator.pop(context);
  }

  void onDialogCancelClick() {
    Navigator.pop(context);
  }

  void onAddPhotoClick() {
    showDialog(
        context: context,
        child: CommonAppWidgets.makeCommonAlertDialog(
            AppStrings.DIALOG_TITLE_ADD_PHOTO,
            AppStrings.DIALOG_SUB_TITLE_ADD_PHOTO,
            CommonAppWidgets.makeCommonButton(AppStrings.OPEN_GALLERY,
                Colors.lightBlueAccent, Colors.white, onOpenGalleryClick),
            CommonAppWidgets.makeCommonButton(AppStrings.TAKE_PHOTO,
                Colors.lightBlueAccent, Colors.white, onTakePhotoClick)));
  }

  void onOpenGalleryClick() {
    PickerHelper().getFromGallery().then((value) => setState(() {
          selectedImage = value;
        }));

    Navigator.pop(context);
  }

  void onTakePhotoClick() {
    PickerHelper().getFromCamera().then((value) => setState(() {
          selectedImage = value;
        }));

    Navigator.pop(context);
  }
}
