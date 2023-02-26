import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListInitial());

  void loadData() async {
    var l = await ApiService().fetchShoppingList();
    emit(ShoppingListLoaded(l));
  }

  void fillUp(ProductList products) async {
    List<int> ids = [];
    for (var product in products.productList) {
      if (product.selected) {
        ids.add(product.id);
      }
    }

    if (ids.isNotEmpty) {
      await ApiService().fillUp(ids);
      emit(ShoppingListInitial());
    }
  }

  void reloadData() async {
    emit(ShoppingListInitial());
  }
}
