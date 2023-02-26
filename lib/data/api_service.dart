import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

class ApiService {
  final component = "ApiService";
  Future<ProductList> fetchShoppingList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$BASE_API_URL/shoppingList/all?missing_percent=0.1'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return productListFromJson(await response.stream.bytesToString());
    } else {
      logger.i("empty shoppingList/all response", component);
      return productListFromJson("");
    }
  }

  Future<void> fillUp(List<int> ids) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'PATCH',
      Uri.parse('$BASE_API_URL/shoppingList/fill_up'),
    );
    logger.i("ids inside fillUp: $ids", component);
    request.body = json.encode(ids);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i(await response.stream.bytesToString(), component);
    } else {
      logger.e(response.reasonPhrase, component);
    }
  }
}
