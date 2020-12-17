import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  ProductDescription({this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Beschreibung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          SizedBox(height: 6,),
          Text(description, style: TextStyle(height: 1.5)),
        ],
      )
    );
  }
}