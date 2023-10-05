import 'package:flutter/material.dart';

typedef Validator = String? Function (String?);
class CustomFormField extends StatelessWidget {
  String hint;
  TextInputType keyboardType;
  bool secureText ;
  Validator? validator;
  TextEditingController? controller;

  CustomFormField({
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.secureText = false,
    this.validator,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: secureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hint,
      ),
    );
  }
}
