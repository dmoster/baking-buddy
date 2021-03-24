import 'package:flutter/material.dart';

class AlphabetSearchButton extends StatelessWidget {
  const AlphabetSearchButton({
    Key key,
    @required this.context,
    @required this.btnText,
    @required this.onPressed,
  }) : super(key: key);

  final BuildContext context;
  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(),
      ),
    );
  }
}
