import 'package:flutter/material.dart';
import 'package:pan_pal/widgets/palette.dart';

class RecipeHeader extends StatelessWidget {
  const RecipeHeader({
    Key key,
    @required this.imageUrl,
    @required this.recipeName,
    @required this.recipeCategory,
  }) : super(key: key);

  final String imageUrl;
  final String recipeName;
  final String recipeCategory;

  static bool hasImageUrl = false;

  @override
  Widget build(BuildContext context) {
    hasImageUrl = imageUrl != '' && imageUrl != 'null' && imageUrl != null;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        hasImageUrl
            ? Container(
                height: 192,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hasImageUrl
                  ? Palette().darkBackground
                  : Palette().lightBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  recipeName,
                  style: TextStyle(
                    color: hasImageUrl ? Palette().light : Palette().dark,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Category
                Text(
                  recipeCategory,
                  style: TextStyle(
                    color:
                        hasImageUrl ? Palette().lightIcon : Palette().darkIcon,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
