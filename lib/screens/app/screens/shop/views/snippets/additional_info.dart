import 'package:bauer_nebenan/models/product.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductAdditionalInfo extends StatelessWidget {
  final List<AdditionalInfo> info;

  const ProductAdditionalInfo({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return info != null && info.length > 0
        ? ExpandableNotifier(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: info
                  .map((AdditionalInfo info) => Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: ScrollOnExpand(
                          child: ExpandablePanel(
                            header: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, left: 45),
                              child: Center(
                                child: Text(
                                  info.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.only(bottom: 36),
                              child: Column(
                                children: [
                                  if (info.image != null)
                                    FittedBox(
                                      child: FadeInImage.memoryNetwork(
                                        image: info.image,
                                        placeholder: kTransparentImage,
                                      ),
                                    ),
                                  if (info.text != null) Text(info.text)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        : Container(width: 0, height: 0);
  }
}
