import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductImages extends StatelessWidget {
  final List<String> images;

  const ProductImages({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) => CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.width,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
        ),
        items: images
            .map(
              (String image) => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: FadeInImage.memoryNetwork(
                    image: image,
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover),
              ),
            )
            .toList(),
      );
}
