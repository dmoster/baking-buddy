import 'package:flutter/material.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search_button.dart';

class AlphabetSearch extends StatefulWidget {
  const AlphabetSearch({
    Key key,
    @required this.onSearch,
    @required this.context,
  }) : super(key: key);

  final Function(String) onSearch;
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
            AlphabetSearchButton(
              context: context,
              btnText: 'A',
              onPressed: () => widget.onSearch('A'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'B',
              onPressed: () => widget.onSearch('B'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'C',
              onPressed: () => widget.onSearch('C'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'D',
              onPressed: () => widget.onSearch('D'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'E',
              onPressed: () => widget.onSearch('E'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'F',
              onPressed: () => widget.onSearch('F'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(
              context: context,
              btnText: 'G',
              onPressed: () => widget.onSearch('G'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'H',
              onPressed: () => widget.onSearch('H'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'I',
              onPressed: () => widget.onSearch('I'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'J',
              onPressed: () => widget.onSearch('J'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'K',
              onPressed: () => widget.onSearch('K'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'L',
              onPressed: () => widget.onSearch('L'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'M',
              onPressed: () => widget.onSearch('M'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(
              context: context,
              btnText: 'N',
              onPressed: () => widget.onSearch('N'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'O',
              onPressed: () => widget.onSearch('O'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'P',
              onPressed: () => widget.onSearch('P'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'Q',
              onPressed: () => widget.onSearch('Q'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'R',
              onPressed: () => widget.onSearch('R'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'S',
              onPressed: () => widget.onSearch('S'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlphabetSearchButton(
              context: context,
              btnText: 'T',
              onPressed: () => widget.onSearch('T'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'U',
              onPressed: () => widget.onSearch('U'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'V',
              onPressed: () => widget.onSearch('V'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'W',
              onPressed: () => widget.onSearch('W'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'X',
              onPressed: () => widget.onSearch('X'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'Y',
              onPressed: () => widget.onSearch('Y'),
            ),
            AlphabetSearchButton(
              context: context,
              btnText: 'Z',
              onPressed: () => widget.onSearch('Z'),
            ),
          ],
        ),
      ],
    );
  }
}
