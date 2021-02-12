import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class ProviderButton extends StatefulWidget {
  const ProviderButton({Key key, this.context, this.signInType})
      : super(key: key);

  final BuildContext context;
  final String signInType;

  @override
  _ProviderButtonState createState() => _ProviderButtonState();
}

class _ProviderButtonState extends State<ProviderButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.signInType) {
      case 'google':
        return InkWell(
          onTap: () => context.signInWithGoogle(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white38,
              ),
            ),
            child: LitAuthIcon.google(
              size: const Size(30, 30),
            ),
          ),
        );
        break;
      // case 'twitter':
      //   return InkWell(
      //     onTap: () => context.signInWithTwitter(),
      //     child: Container(
      //       padding: const EdgeInsets.all(12.0),
      //       alignment: Alignment.center,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         border: Border.all(
      //           color: Colors.white26,
      //         ),
      //       ),
      //       child: Transform.scale(
      //         scale: 1.3,
      //         child: LitAuthIcon.twitter(
      //           size: const Size(30, 30),
      //         ),
      //       ),
      //     ),
      //   );
      //   break;
      default:
        return const Text('Something went wrong :(');
    }
  }
}
