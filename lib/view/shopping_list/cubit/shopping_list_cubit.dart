import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final component = "ShoppingListCubit";
  ShoppingListCubit() : super(ShoppingListInitial());

  void loadData() async {
    logger.d("fetching shopping list data", component);
    var l = await ApiService().fetchShoppingList();
    emit(ShoppingListLoaded(l));
  }

  void fillUp(ProductList products) async {
    logger.d("fill up missing products", component);
    List<int> ids = [];
    for (var product in products.productList) {
      if (product.selected) {
        ids.add(product.id);
      }
    }

    if (ids.isNotEmpty) {
      await ApiService().fillUp(ids);
      emit(ShoppingListInitial());
    } else {
      logger.i("0 products selected", component);
    }
  }

  void reloadData() async {
    logger.d("reloading data", component);
    emit(ShoppingListInitial());
  }
}
