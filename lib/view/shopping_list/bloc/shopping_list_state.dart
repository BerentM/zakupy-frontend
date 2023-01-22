part of 'shopping_list_bloc.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();
  
  @override
  List<Object> get props => [];
}

class ShoppingListInitial extends ShoppingListState {}
