import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        horizontalTitleGap: 8.0,
        tileColor: Colors.white10,
        leading: Container(
          width: 64,
          child: imageUrl != '' && imageUrl != 'null' && imageUrl != null
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Center(
                  child: Icon(Icons.camera_alt_outlined),
                ),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        subtitle: Text(
          category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
