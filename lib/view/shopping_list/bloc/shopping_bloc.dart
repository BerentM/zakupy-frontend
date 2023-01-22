import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(ShoppingInitial()) {
    on<ShoppingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
