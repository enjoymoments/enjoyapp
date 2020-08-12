import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required this.validate,
    @required this.hintText,
    @required this.labelText,
    @required this.textInputType,
  }) : super(key: key);

  final Function(String) validate;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 17,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: validate,
    );
  }
}
