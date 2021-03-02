import 'package:flutter/material.dart';

class RecentItemButton extends StatelessWidget {
  const RecentItemButton({
    Key key,
    @required this.label,
  }) : super(key: key);

  final dynamic label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: label,
      style: ButtonStyle(),
    );
  }
}
