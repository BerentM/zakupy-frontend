import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/shopping_list.dart';

class ApiService {
  Future<ShoppingList> fetchShoppingList() async {
    try {
      final response = await get(Uri.parse("$BASE_API_URL/shopping_list"));
      print(response.body);
      return shoppingListFromJson(response.body);
    } catch (e) {
      print(e);
      return shoppingListFromJson("");
    }
  }
}
