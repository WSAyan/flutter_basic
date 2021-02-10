import 'package:flutter/material.dart';

class CommonAppWidgets {
  static TextFormField makeCommonTextField(
          TextInputType textInputType,
          bool autoFocus,
          bool obscureText,
          Icon prefixIcon,
          Icon suffixIcon,
          String initialValue,
          String hint, TextEditingController textEditingController) =>
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
}
