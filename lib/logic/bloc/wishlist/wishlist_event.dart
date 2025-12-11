part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class AddToWishList extends WishlistEvent {
  final Product product;
  AddToWishList(this.product);
}

class RemoveWishListEvent extends WishlistEvent {
  final Product product;
  RemoveWishListEvent(this.product);
}
