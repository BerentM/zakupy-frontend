part of 'shopping_list_cubit.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

class ShoppingListInitial extends ShoppingListState {}

class ShoppingListLoaded extends ShoppingListState {
  final ShoppingListElement currentData;

  ShoppingListLoaded(this.currentData);
}
