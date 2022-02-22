import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  final IconData prefixIcon;
  final TextInputType textInputType;

  AppTextField({
    required this.textEditingController,
    required this.hint,
    required this.prefixIcon,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
