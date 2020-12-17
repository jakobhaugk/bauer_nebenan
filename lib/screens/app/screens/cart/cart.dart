import 'package:flutter/material.dart';

import 'views/cart_items.dart';

class CartScreen extends StatefulWidget {
  final Function navigateTo;

  const CartScreen({this.navigateTo});
  
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return CartItemsView();
            }
          },
        ),
      );
}
