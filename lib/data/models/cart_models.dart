import 'package:ecomerce_bloc_new/data/models/product_models.dart';

class CartItem {
  final Product product;
  int quantity;
  final String Size;

  CartItem({required this.product, required this.quantity, required this.Size});
}
