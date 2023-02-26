import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

class ApiService {
  // Future<ShoppingList> fetchShoppingList() async {
  Future<ProductList> fetchShoppingList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$BASE_API_URL/shoppingList/all?missing_percent=0.1'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return productListFromJson(await response.stream.bytesToString());
    } else {
      return productListFromJson("");
    }
  }

  Future<void> fillUp(List<int> ids) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'PATCH',
      Uri.parse('$BASE_API_URL/shoppingList/fill_up'),
    );
    print("ids inside fillUp: $ids");
    request.body = json.encode(ids);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
