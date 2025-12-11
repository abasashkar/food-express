import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_state.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Wishlist",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return _buildEmptyState();
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                final product = state.items[index];

                return Stack(
                  children: [
                    ProductCard(
                      image: "http://10.0.2.2:6000/uploads/${product.image}",
                      title: product.name,
                      price: "₹${product.price}",
                      onWishListTap: () {}, // Not used here
                    ),

                    /// 🗑 REMOVE ICON
                    Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () {
                          context.read<WishlistBloc>().add(
                            RemoveWishListEvent(product),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// ✅ Empty state UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          const Text(
            "Your wishlist is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Add items to save them for later.",
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
