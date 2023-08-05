import 'package:flutter/material.dart';

class InputsStyle {
  static InputDecoration loginFieldInputDecoration(
          {required String hint, Widget? suffixIcon}) =>
      InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          hintText: hint,
          labelText: hint,
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(color: Color(0xFF4F575E)),
          alignLabelWithHint: true);
}
