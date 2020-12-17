import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cart = [];

  void clear() {
    cart = [];
    notifyListeners();
  }

  int _find(String productID) => cart.indexWhere((p) => p.id == productID);

  Product getProduct(String productID) {
    int i = _find(productID);
    return i >= 0 ? cart[i] : null;
  }

  void add(Product product) {

    int index =_find(product.id);

    if (index >= 0) {
      cart[index].quantitySelected += product.quantitySelected;
    } else {
      cart.add(product);
    }
    print(cart);

    notifyListeners();
  }

  void remove(Product product) {
    int index = cart.indexWhere((p) => p.id == product.id);
    cart.removeAt(index);
    notifyListeners();
  }

  Future submit() async {

  }
}