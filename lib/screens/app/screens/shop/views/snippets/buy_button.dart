import 'package:flutter/material.dart';
import '../../../widgets/row_card.dart';

class ProductBuyButton extends StatefulWidget {
  final int available, quantitySelected;
  final void Function(int quantity) addToCart;
  final Function goToCart;

  const ProductBuyButton(
      {Key key, this.available, this.addToCart, this.quantitySelected = 0, this.goToCart})
      : super(key: key);

  @override
  _ProductBuyButtonState createState() => _ProductBuyButtonState();
}

class _ProductBuyButtonState extends State<ProductBuyButton> {
  int _quantity;

  @override
  void initState() {
    _quantity = 1;
    super.initState();
  }

  void _increment() {
    if (_quantity < widget.available) setState(() => _quantity++);
  }

  void _decrement() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Builder(builder: (BuildContext context) {
        if (widget.quantitySelected > 0) {
          return GestureDetector(
            onTap: widget.goToCart,
            child: RowCard(
              color: Theme.of(context).primaryColor,
              height: 60,
              content: Text(
                '${widget.quantitySelected} mal im Warenkorb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        } else if (widget.available > 0) {
          return RowCard(
            color: Theme.of(context).primaryColor,
            height: 60,
            sidePadding: 0,
            leading: Expanded(
              child: IconButton(
                icon: Icon(Icons.remove),
                onPressed: _quantity > 1 ? _decrement : null,
                color: Colors.white,
                disabledColor: Colors.white54,
                splashRadius: 24,
              ),
            ),
            trailing: Expanded(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: _quantity < widget.available ? _increment : null,
                color: Colors.white,
                disabledColor: Colors.white54,
                splashRadius: 24,
              ),
            ),
            content: GestureDetector(
              onTap: () => widget.addToCart(_quantity),
              child: Expanded(
                child: Text(
                  '$_quantity mal in den Warenkorb',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        } else {
          return RowCard(
            height: 60,
            content: Text(
              'Leider ist das Produkt zur Zeit nicht lieferbar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
      }),
    );
  }
}
