import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? textEditingController;
  final bool obscure;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.hintText = '',
    this.labelText = '',
    this.textInputType,
    this.textInputAction,
    this.textEditingController,
    this.suffixIcon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      textInputAction: textInputAction ?? TextInputAction.next,
      obscureText: obscure,
      decoration: InputDecoration(
        label: Text(labelText ?? ''),
        hintText: hintText ?? '',
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
