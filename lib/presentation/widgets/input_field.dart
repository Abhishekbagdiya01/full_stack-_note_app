import 'package:flutter/material.dart';
import 'package:note_app/utils/const.dart';

class InputField extends StatelessWidget {
  InputField(
      {required this.controller,
      required this.color,
      this.hintText,
      this.icon,
      this.textInputType,
      this.suffixIcon,
      this.voidCallback,
      this.obscureText = false});

  final TextEditingController controller;
  IconData? icon;
  String? hintText;
  Color color ;
  TextInputType? textInputType;
  IconData? suffixIcon;
  VoidCallback? voidCallback;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
  
    return TextField(
      // style: TextStyle(),
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        // hintStyle:TextStyle(),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        suffixIcon: InkWell(
          onTap: voidCallback,
          child: Icon(
            suffixIcon,
            color: color,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: UnderlineInputBorder(),
      ),
    );
  }
}
