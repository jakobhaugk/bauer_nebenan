import 'package:flutter/material.dart';
import 'package:bauer_nebenan/models/category.dart';
import 'package:bauer_nebenan/models/farmer.dart';

class ProductListView extends StatefulWidget {

  final Category category;
  final Farmer farmer;

  const ProductListView({Key key, this.category, this.farmer}) : super(key: key);
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.category.name ?? widget.farmer.name),
    );
  }
}