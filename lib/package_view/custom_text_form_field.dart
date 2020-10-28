import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required this.validate,
    @required this.hintText,
    @required this.labelText,
    @required this.textInputType,
    this.controller,
    this.maxLines,
  }) : super(key: key);

  final Function(String) validate;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 17,
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: validate,
    );
  }
}
