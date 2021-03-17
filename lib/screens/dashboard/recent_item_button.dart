import 'package:flutter/material.dart';

class RecentItemButton extends StatelessWidget {
  const RecentItemButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  final dynamic label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: label,
      style: ButtonStyle(),
    );
  }
}
