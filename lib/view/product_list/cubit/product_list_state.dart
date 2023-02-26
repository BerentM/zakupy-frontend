part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final ProductList currentData;

  const ProductListLoaded(this.currentData);
}
