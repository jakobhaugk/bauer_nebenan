import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../standard_route.dart';
import 'views/category_list.dart';
import 'views/product_detail.dart';
import 'views/product_list.dart';
import 'package:bauer_nebenan/models/product.dart';
import 'package:bauer_nebenan/models/category.dart';
import 'package:bauer_nebenan/models/farmer.dart';

class ShopScreen extends StatefulWidget {
  final Map navKeys;

  const ShopScreen({Key key, this.navKeys}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) => Navigator(
        key: widget.navKeys['shop'],
        onGenerateRoute: (RouteSettings settings) {
          String title;
          Widget body;
          PageTransitionType transition = PageTransitionType.fade;

          switch (settings.name) {
            case '/':
              title = 'Unser Sortiment';
              body = CategoryListView();
              break;

            case '/product-list':
              // transition = PageTransitionType.rightToLeft;
              if (settings.arguments is Category) {
                Category category = settings.arguments;
                title = category.name;
                body = ProductListView(category: category);
              } else if (settings.arguments is Farmer) {
                Farmer farmer = settings.arguments;
                title = farmer.name;
                body = ProductListView(farmer: farmer);
              }
              break;

            case '/product-detail':
              transition = PageTransitionType.bottomToTop;
              Product product = settings.arguments;
              if (product != null) {
                body = ProductDetailView(
                    product: product, navKeys: widget.navKeys);
              }
              break;
          }

          return StandardRoute(
            body: body,
            title: title,
            transition: transition,
            name: settings.name,
          );
        },
        initialRoute: '/',
      );
}
