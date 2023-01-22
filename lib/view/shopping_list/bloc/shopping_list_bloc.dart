import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListInitial()) {
    on<ShoppingListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
