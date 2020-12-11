import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'views/category_list.dart';
import 'views/product_detail.dart';
import 'views/product_list.dart';
import 'package:bauer_nebenan/models/product.dart';
import 'package:bauer_nebenan/models/category.dart';
import 'package:bauer_nebenan/models/farmer.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (RouteSettings settings) {
          
          String title;
          Widget body;
          PageTransitionType transition = PageTransitionType.fade;

          print(settings.name);

          switch (settings.name) {
            case '/':
            case '/category-list':
              title = 'Kategorien';
              body = CategoryListView();
              break;

            case '/product-list':
              transition = PageTransitionType.rightToLeft;
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
              transition = PageTransitionType.rightToLeft;
              Product product = settings.arguments;
              if (product != null) {
                title = product.title;
                body = ProductDetailView(product: product);
              }
              break;
          }

          return PageTransition(
            duration: Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            type: transition,
            child: Scaffold(
              appBar: (title != null)
                  ? AppBar(
                      title: Text(title),
                      centerTitle: true,
                    )
                  : null,
              body: body ?? Error(),
            ),
          );
        },
        initialRoute: '/',
      );
}
