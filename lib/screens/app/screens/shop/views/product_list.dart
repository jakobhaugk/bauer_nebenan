import 'package:flutter/material.dart';

import 'package:bauer_nebenan/screens/loading/loading_screen.dart';
import 'package:bauer_nebenan/models/category.dart';
import 'package:bauer_nebenan/models/farmer.dart';
import 'package:bauer_nebenan/models/product.dart';

import 'widgets/item_card.dart';

class ProductListView extends StatefulWidget {
  final Category category;
  final Farmer farmer;

  const ProductListView({Key key, this.category, this.farmer})
      : super(key: key);
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  Future<List<Product>> _productListFuture;

  @override
  void initState() {
    _productListFuture = Future.delayed(
        Duration(seconds: 2),
        () => [
              Product(
                title: 'Apfel',
                images: [
                  'https://www.baumschule-horstmann.de/bilder/popup/apfel-geheimrat-dr-oldenburg-m002566_h_0.jpg',
                  'https://www.tagesspiegel.de/images/yellow-color-place-and-window-with-sun-light/26102892/3-format530.jpg',
                ],
                description: 'Sehr leckerer Apfel Lorem Ipsum dies das',
                price: 4.2,
                unit: 'kg'
              ),
              Product(
                title: 'Birne',
                images: [
                  'https://www.neudorff.de/fileadmin/_processed_/2/0/csm_birne_rund_df21cdfd03.jpg',
                  'https://static.zentrum-der-gesundheit.de/img/c87b8556d02f9b64f6266d61d2830dd7?width=1280&height=1280',
                ],
                description: 'Sehr leckere Birne Lorem Ipsum dies das',
                price: 3.9,
                unit: 'kg'
              )
            ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<Product>>(
            future: _productListFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Expanded(child: LoadingScreen());

                case ConnectionState.done:
                  return _buildProductList(context, snapshot.data);

                default:
                  return LoadingScreen();
              }
            }),
      ],
    );
  }

  Widget _buildProductList(BuildContext context, List products) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 24,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (BuildContext context, int i) {
              Product product = products[i];
              return ItemCard(
                title: product.title,
                subtitle: product.displayPrice,
                imageURL: product.images.first,
                onTap: () => Navigator.of(context)
                    .pushNamed('/product-detail', arguments: product),
              );
            },
          ),
        ),
      );
}
