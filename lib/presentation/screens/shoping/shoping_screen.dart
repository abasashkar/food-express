import 'package:ecomerce_bloc_new/data/repositories/product_repository.dart';
import 'package:ecomerce_bloc_new/logic/bloc/product/product_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/product/product_event.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecomerce_bloc_new/presentation/screens/productdetails/product_details.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/category_chip.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopingScreen extends StatelessWidget {
  const ShopingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                      // ✅ Categories Title
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
                      SizedBox(height: 10),

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
