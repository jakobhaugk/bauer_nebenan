import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemCard extends StatelessWidget {
  final Function onTap;

  final String title, subtitle, imageURL;

  const ItemCard({
    Key key,
    this.title = '',
    this.subtitle = '',
    this.imageURL = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Card(
                // padding: EdgeInsets.all(8),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: imageURL,
                  fit: BoxFit.cover,
                ),
                elevation: 3,
              ),
            ),
            if (title.isNotEmpty) Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            if (subtitle.isNotEmpty) Text(
              subtitle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
