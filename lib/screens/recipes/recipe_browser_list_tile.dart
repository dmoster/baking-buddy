import 'package:flutter/material.dart';
import 'package:pan_pal/widgets/palette.dart';

class RecipeBrowserListTile extends StatelessWidget {
  const RecipeBrowserListTile({
    Key key,
    @required this.imageUrl,
    @required this.name,
    @required this.category,
    @required this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String category;
  final VoidCallback onTap;

  static bool hasImageUrl = false;

  @override
  Widget build(BuildContext context) {
    hasImageUrl = imageUrl != '' && imageUrl != 'null' && imageUrl != null;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Palette().light,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: hasImageUrl
                  ? Image.network(imageUrl)
                  : Container(
                      color: Palette().warningLight,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Palette().darkIcon,
                        size: 24,
                      ),
                    ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    color: Palette().dark,
                  ),
                ),
                subtitle: Text(
                  category,
                  style: TextStyle(
                    color: Palette().darkIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
