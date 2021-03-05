import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/daniel_cookies.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
