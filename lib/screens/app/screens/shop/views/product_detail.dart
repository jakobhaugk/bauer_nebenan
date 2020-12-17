import 'package:bauer_nebenan/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/details.dart';
import 'package:bauer_nebenan/models/product.dart';
import 'snippets/images.dart';
import 'snippets/info_cards.dart';
import 'snippets/buy_button.dart';
import 'snippets/title.dart';
import 'snippets/description.dart';
import 'snippets/additional_info.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  final Map navKeys;
  final Function navigateTo;

  const ProductDetailView(
      {Key key, this.product, this.navKeys, this.navigateTo})
      : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _quantitySelected;

  @override
  void initState() {
    _quantitySelected = _getQuantity();
    super.initState();
  }

  int _getQuantity() =>
      Provider.of<CartProvider>(context, listen: false)
          .getProduct(widget.product.id)
          ?.quantitySelected ??
      0;

  void _addToCart(int quantity) {
    Product p = widget.product;
    p.quantitySelected = quantity;
    Provider.of<CartProvider>(context, listen: false).add(p);
    setState(() {
      _quantitySelected = _getQuantity();
    });
  }

  void _goToCart() => widget.navigateTo(1);

  @override
  Widget build(BuildContext context) {
    return Details(
      header: ProductImages(images: widget.product.images),
      headerCollapsedHeight: 150,
      headerExpandedHeight: MediaQuery.of(context).size.width - 24,
      initScrollOffset: MediaQuery.of(context).size.width * 0.4,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 36, right: 36, bottom: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProductTitle(product: widget.product),
              if (widget.product.farmer != null)
                ProductFarmerInfo(farmer: widget.product.farmer),
              if (widget.product.ecoScore != null)
                ProductEcoInfo(ecoScore: widget.product.ecoScore),
              ProductBuyButton(
                available: widget.product.quantityAvailable,
                addToCart: _addToCart,
                quantitySelected: _quantitySelected,
                goToCart: _goToCart,
              ),
              ProductDescription(description: widget.product.description),
              ProductAdditionalInfo(info: widget.product.additionalInformation),
            ],
          ),
        ),
      ),
    );
  }
}
