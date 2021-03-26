import 'package:flutter/material.dart';

class ImageUploaderButton extends StatelessWidget {
  const ImageUploaderButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 32,
            ),
            Text(
              'Add Image',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
