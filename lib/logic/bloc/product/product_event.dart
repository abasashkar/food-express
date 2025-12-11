import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterByCategory extends ProductEvent {
  final String category;
  FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
