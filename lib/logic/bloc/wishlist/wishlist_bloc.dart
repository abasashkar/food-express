import 'package:bloc/bloc.dart';
import 'package:ecomerce_bloc_new/data/models/product_models.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_state.dart';

part 'wishlist_event.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistState([])) {
    on<AddToWishList>(_onAddToWishList);
    on<RemoveWishListEvent>(_onRemoveFromWishList);
  }

  Future<void> _onAddToWishList(
    AddToWishList event,
    Emitter<WishlistState> emit,
  ) async {
    final updated = List<Product>.from(state.items);

    if (!updated.any((p) => p.id == event.product.id)) {
      updated.add(event.product);
    }

    emit(WishlistState(updated));
  }

  Future<void> _onRemoveFromWishList(
    RemoveWishListEvent event,
    Emitter<WishlistState> emit,
  ) async {
    final updated = state.items.where((p) => p.id != event.product.id).toList();
    emit(WishlistState(updated));
  }
}
