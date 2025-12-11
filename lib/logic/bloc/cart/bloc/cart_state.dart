import 'package:ecomerce_bloc_new/data/models/product_models.dart';

class CartItem {
  final Product product;
  final String size;
  int quantity;

  CartItem({required this.product, required this.size, this.quantity = 1});
}

class CartState {
  final List<CartItem> items;
  final double discount;

  CartState({required this.items, this.discount = 0});

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  double get finalAmount => totalPrice - discount;
}
