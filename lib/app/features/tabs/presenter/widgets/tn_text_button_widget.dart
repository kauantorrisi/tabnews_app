import 'package:flutter/material.dart';

class TNTextButtonWidget extends StatelessWidget {
  const TNTextButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    required this.color,
  });

  final String text;
  final Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
