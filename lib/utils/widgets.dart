import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonAppWidgets {
  static TextFormField makeCommonTextField(
          TextInputType textInputType,
          bool autoFocus,
          bool obscureText,
          Icon prefixIcon,
          Icon suffixIcon,
          String initialValue,
          String hint,
          TextEditingController textEditingController) =>
      TextFormField(
        keyboardType: textInputType,
        autofocus: autoFocus,
        obscureText: obscureText,
        initialValue: initialValue,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );

  static RaisedButton makeCommonButton(String text, Color backGroundColor,
          Color textColor, Function() onPressed) =>
      RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: onPressed,
        color: backGroundColor,
        child: Text(text, style: TextStyle(color: textColor)),
      );

  static Container makeCommonLoader() => Container(
      color: Colors.transparent,
      child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 5.0)));

  static AlertDialog makeCommonAlertDialog(String title, String content,
          RaisedButton okButton, RaisedButton cancelButton) =>
      AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: [cancelButton, okButton],
      );

  static ListTile makeCommonListRow(
      String title, String subtitle, String imageUri) {
    return ListTile(
      leading: ClipOval(child: Image.network(imageUri, height: 50, width: 50)),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.navigate_next),
    );
  }

  static void showCommonToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
