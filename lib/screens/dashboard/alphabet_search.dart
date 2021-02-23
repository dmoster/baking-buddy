import 'package:flutter/material.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search_button.dart';

class AlphabetSearch extends StatefulWidget {
  const AlphabetSearch({Key key, @required this.context}) : super(key: key);

  final BuildContext context;

  @override
  _AlphabetSearchState createState() => _AlphabetSearchState();
}

class _AlphabetSearchState extends State<AlphabetSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Alphabet Search',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFF9F00),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(context: context, btnText: 'A'),
            AlphabetSearchButton(context: context, btnText: 'B'),
            AlphabetSearchButton(context: context, btnText: 'C'),
            AlphabetSearchButton(context: context, btnText: 'D'),
            AlphabetSearchButton(context: context, btnText: 'E'),
            AlphabetSearchButton(context: context, btnText: 'F'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(context: context, btnText: 'G'),
            AlphabetSearchButton(context: context, btnText: 'H'),
            AlphabetSearchButton(context: context, btnText: 'I'),
            AlphabetSearchButton(context: context, btnText: 'J'),
            AlphabetSearchButton(context: context, btnText: 'K'),
            AlphabetSearchButton(context: context, btnText: 'L'),
            AlphabetSearchButton(context: context, btnText: 'M'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(context: context, btnText: 'N'),
            AlphabetSearchButton(context: context, btnText: 'O'),
            AlphabetSearchButton(context: context, btnText: 'P'),
            AlphabetSearchButton(context: context, btnText: 'Q'),
            AlphabetSearchButton(context: context, btnText: 'R'),
            AlphabetSearchButton(context: context, btnText: 'S'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(context: context, btnText: 'T'),
            AlphabetSearchButton(context: context, btnText: 'U'),
            AlphabetSearchButton(context: context, btnText: 'V'),
            AlphabetSearchButton(context: context, btnText: 'W'),
            AlphabetSearchButton(context: context, btnText: 'X'),
            AlphabetSearchButton(context: context, btnText: 'Y'),
            AlphabetSearchButton(context: context, btnText: 'Z'),
          ],
        ),
      ],
    );
  }
}
