import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListInitial());

  void first() => emit(ShoppingListFirst());
  void second() => emit(ShoppingListSecond());
}
