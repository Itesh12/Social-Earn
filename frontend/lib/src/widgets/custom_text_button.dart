import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  const CustomTextButton({
    super.key,
    this.onPressed,
    this.buttonText = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonText ?? '',
        textAlign: TextAlign.center,
      ),
    );
  }
}
