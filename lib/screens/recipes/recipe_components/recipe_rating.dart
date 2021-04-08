import 'package:flutter/material.dart';
import 'package:pan_pal/widgets/palette.dart';

class RecipeRating extends StatefulWidget {
  const RecipeRating({
    Key key,
    @required this.rating,
    @required this.numRatings,
    @required this.textColor,
  }) : super(key: key);

  final String rating;
  final int numRatings;
  final Color textColor;

  @override
  _RecipeRatingState createState() => _RecipeRatingState();
}

class _RecipeRatingState extends State<RecipeRating> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ..._getStars(widget.rating),
          ],
        ),
        Row(
          children: widget.numRatings == 0
              ? [
                  Text(
                    'Not Rated',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 12,
                    ),
                  ),
                ]
              : [
                  Text(
                    widget.rating,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '(${widget.numRatings})',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
        ),
      ],
    );
  }

  List<dynamic> _getStars(String ratingString) {
    final double rating = double.parse(ratingString);
    final int maxRating = 5;
    List<dynamic> stars = [];

    for (double i = 0; i < maxRating; i++) {
      stars.add(
        Stack(
          children: [
            Icon(
              Icons.star_outline,
              color: Palette().secondary,
              size: 12.0,
            ),
            getStarFill(i, rating),
          ],
        ),
      );
    }

    return stars;
  }

  Widget getStarFill(double index, double rating) {
    if (rating >= index + 0.8) {
      return Icon(
        Icons.star,
        color: Palette().secondary,
        size: 12,
      );
    } else if (rating >= index + 0.3) {
      return Icon(
        Icons.star_half,
        color: Palette().secondary,
        size: 12,
      );
    }
    return Container();
  }
}
