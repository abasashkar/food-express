import 'dart:io';

import 'package:ecomerce_bloc_new/data/models/product_models.dart';
import 'package:ecomerce_bloc_new/data/repositories/product_repository.dart';
import 'package:ecomerce_bloc_new/logic/bloc/product/product_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProduct);
    on<FilterByCategory>(_onFilterCategory);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProduct();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onSearchProduct(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.searchProduct(event.query);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onFilterCategory(
    FilterByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchByCategory(event.category);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
