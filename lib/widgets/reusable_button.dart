import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;

  const ReusableButton({
    @required this.color,
    @required this.title,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      textColor: Colors.white,
      child: Text(title),
      onPressed: onPressed,
    );
  }
}
