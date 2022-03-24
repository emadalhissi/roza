import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final TextInputType textInputType;
  final bool obscure;
  final int lines;

  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.obscure = false,
    this.lines = 1,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      keyboardType: widget.textInputType,
      maxLines: widget.lines,
      obscureText: showPassword == false ? widget.obscure : !widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: widget.obscure
            ? InkWell(
                onTap: () {
                  setState(() {
                    showPassword == true
                        ? showPassword = false
                        : showPassword = true;
                  });
                },
                child: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff8E8E93),
                ),
              )
            : const SizedBox.shrink(),
        suffixIconColor: const Color(0xff8E8E93),
        enabledBorder: myOutlineInputBorder(color: const Color(0xffB9B9BB)),
        focusedBorder: myOutlineInputBorder(color: const Color(0xff63CEDA)),
        errorBorder: myOutlineInputBorder(color: const Color(0xffFF4343)),
      ),
    );
  }

  OutlineInputBorder myOutlineInputBorder({
    required Color color,
    double width = 1,
    double radius = 8,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
