import 'package:ecomerce_bloc_new/data/models/product_models.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  final String size;

  AddToCart(this.product, this.size);
}

class RemoveFromCart extends CartEvent {
  final String productId;
  RemoveFromCart(this.productId);
}

class IncreaseQty extends CartEvent {
  final String productId;
  IncreaseQty(this.productId);
}

class DecreaseQty extends CartEvent {
  final String productId;
  DecreaseQty(this.productId);
}

class ApplyCode extends CartEvent {
  final String code;
  ApplyCode(this.code);
}
