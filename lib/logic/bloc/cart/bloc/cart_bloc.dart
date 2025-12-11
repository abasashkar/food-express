import 'package:bloc/bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/cart/bloc/cart_event.dart';
import 'package:ecomerce_bloc_new/logic/bloc/cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<IncreaseQty>(_increaseQty);
    on<DecreaseQty>(_decreaseQty);
    on<ApplyCode>(_applyPromo);
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) {
    final updated = List<CartItem>.from(state.items);

    final index = updated.indexWhere(
      (item) => item.product.id == event.product.id && item.size == event.size,
    );

    if (index >= 0) {
      updated[index].quantity++;
    } else {
      updated.add(CartItem(product: event.product, size: event.size));
    }

    emit(CartState(items: updated, discount: state.discount));
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updated = state.items
        .where((e) => e.product.id != event.productId)
        .toList();

    emit(CartState(items: updated, discount: state.discount));
  }

  void _increaseQty(IncreaseQty event, Emitter<CartState> emit) {
    final updated = List<CartItem>.from(state.items);
    final index = updated.indexWhere((e) => e.product.id == event.productId);

    if (index != -1) {
      updated[index].quantity++;
    }

    emit(CartState(items: updated, discount: state.discount));
  }

  void _decreaseQty(DecreaseQty event, Emitter<CartState> emit) {
    final updated = List<CartItem>.from(state.items);
    final index = updated.indexWhere((e) => e.product.id == event.productId);

    if (index != -1 && updated[index].quantity > 1) {
      updated[index].quantity--;
    }

    emit(CartState(items: updated, discount: state.discount));
  }

  void _applyPromo(ApplyCode event, Emitter<CartState> emit) {
    double discount = 0;
    final code = event.code.trim().toUpperCase();

    if (code == "SAVE10") {
      discount = state.totalPrice * 0.10;
    } else if (code == "SAVE100") {
      discount = 100;
    } else {
      discount = 0;
    }

    emit(CartState(items: state.items, discount: discount));
  }
}
