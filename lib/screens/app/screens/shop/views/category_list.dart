import 'package:flutter/material.dart';

import 'package:bauer_nebenan/models/category.dart';
import 'package:bauer_nebenan/screens/loading/loading_screen.dart';
import '../../widgets/item_card.dart';

class CategoryListView extends StatefulWidget {
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  Future<List<Category>> _categoryListFuture;

  @override
  void initState() {
    _categoryListFuture = Future.delayed(
        Duration(seconds: 2),
        () => [
              Category(name: 'Obst', imageUrl: 'https://www.lecker.de/assets/field/image/obstsorten-b.jpg'),
              Category(name: 'Gemüse', imageUrl: 'https://www.plantura.garden/wp-content/uploads/2019/05/Verschiedenes-Obst-und-Gem%C3%BCse-1.jpg')
            ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<Category>>(
            future: _categoryListFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Expanded(child: LoadingScreen());

                case ConnectionState.done:
                  return _buildCategoryList(context, snapshot.data);

                default:
                  return LoadingScreen();
              }
            }),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context, List categories) => Expanded(
        // padding: EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 24,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (BuildContext context, int i) {
              Category category = categories[i];
              return ItemCard(
                title: category.name,
                imageURL: category.imageUrl,
                onTap: () => Navigator.of(context)
                    .pushNamed('/product-list', arguments: category),
              );
            },
          ),
        ),
      );
}
