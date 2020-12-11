import 'package:flutter/material.dart';

import 'package:bauer_nebenan/models/product.dart';


class ProductDetailView extends StatefulWidget {
  final Product product;

  const ProductDetailView({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.product.title),
    );
  }
}
