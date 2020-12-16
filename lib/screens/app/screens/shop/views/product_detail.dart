import 'package:flutter/material.dart';

import '../../widgets/details.dart';
import 'package:bauer_nebenan/models/product.dart';
import 'snippets/info_cards.dart';
import 'snippets/title.dart';


class ProductDetailView extends StatefulWidget {
  final Product product;
  final Map navKeys;

  const ProductDetailView({Key key, this.product, this.navKeys})
      : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Details(
      header: Image(
        fit: BoxFit.cover,
        image: NetworkImage(widget.product.images[0]),
      ),
      headerCollapsedHeight: 150,
      headerExpandedHeight: MediaQuery.of(context).size.width,
      initScrollOffset: MediaQuery.of(context).size.width * 0.4,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductTitle(product: widget.product,),
              if (widget.product.farmer != null)
                FarmerInfo(farmer: widget.product.farmer,),
              if (widget.product.ecoScore != null)
                EcoInfo(ecoScore: widget.product.ecoScore,)
            ],
          ),
        ),
      ),
    );
  }
}
