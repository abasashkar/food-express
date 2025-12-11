import 'package:ecomerce_bloc_new/data/repositories/product_repository.dart';
import 'package:ecomerce_bloc_new/logic/bloc/cart/bloc/cart_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/cart/bloc/cart_state.dart';
import 'package:ecomerce_bloc_new/logic/bloc/product/product_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/product/product_event.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecomerce_bloc_new/presentation/screens/cart/user_cart.dart';
import 'package:ecomerce_bloc_new/presentation/screens/productdetails/product_details.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/category_chip.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/offer_banner.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ GET CURRENT USER
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "User";

    return BlocProvider(
      create: (_) =>
          ProductBloc(repository: ProductRepository())..add(LoadProducts()),

      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // ✅ GREETING ROW
                      Row(
                        children: [
                          const CircleAvatar(radius: 22),
                          const SizedBox(width: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello $userName",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(
                                "Good Morning!",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          const Icon(Icons.notifications_none, size: 26),
                          const SizedBox(width: 12),

                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              int totalItems = state.items.fold(
                                0,
                                (sum, item) => sum + item.quantity,
                              );

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      const Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 26,
                                      ),

                                      if (totalItems > 0)
                                        Positioned(
                                          right: 0,
                                          top: -2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Text(
                                              totalItems.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ✅ SEARCH BAR
                      TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            context.read<ProductBloc>().add(LoadProducts());
                          } else {
                            context.read<ProductBloc>().add(
                              SearchProducts(value),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search...",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("See All"),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<ProductBloc>().add(LoadProducts());
                            },
                            child: const CategoryChip(
                              label: "All",
                              isSelected: true,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              context.read<ProductBloc>().add(
                                FilterByCategory("sweatshirt"),
                              );
                            },
                            child: const CategoryChip(label: "Sweatshirt"),
                          ),

                          GestureDetector(
                            onTap: () {
                              context.read<ProductBloc>().add(
                                FilterByCategory("shirt"),
                              );
                            },
                            child: const CategoryChip(label: "Shirt"),
                          ),

                          GestureDetector(
                            onTap: () {
                              context.read<ProductBloc>().add(
                                FilterByCategory("Jacket"),
                              );
                            },
                            child: const CategoryChip(label: "Jacket"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const OfferBanner(),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Popular Product",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("See All"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      BlocConsumer<ProductBloc, ProductState>(
                        listener: (context, state) {
                          if (state is ProductError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is ProductLoaded) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.65,
                                    mainAxisSpacing: 14,
                                    crossAxisSpacing: 14,
                                  ),
                              itemBuilder: (context, index) {
                                final product = state.products[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductDetails(product: product),
                                      ),
                                    );
                                  },
                                  child: ProductCard(
                                    onWishListTap: () {
                                      context.read<WishlistBloc>().add(
                                        AddToWishList(product),
                                      );
                                    },
                                    title: product.category,
                                    price: "\$${product.price}",
                                    image:
                                        "http://10.0.2.2:6000/uploads/${product.image}",
                                  ),
                                );
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
