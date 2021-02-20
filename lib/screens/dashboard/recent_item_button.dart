import 'package:flutter/material.dart';

class RecentItemButton extends StatelessWidget {
  const RecentItemButton({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(),
    );
  }
}
