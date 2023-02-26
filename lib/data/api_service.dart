import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zakupy_frontend/data/models/auth.dart';
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

  Future<ProductList> fetchProductList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$BASE_API_URL/productList/all'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return productListFromJson(await response.stream.bytesToString());
    } else {
      logger.i("empty productList/all response", component);
      return productListFromJson("");
    }
  }

  Future<void> fillUp(List<int> ids) async {
    var request = http.Request(
      'PATCH',
      Uri.parse('$BASE_API_URL/shoppingList/fill_up'),
    );
    logger.i("ids inside fillUp: $ids", component);
    request.body = json.encode(ids);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i(await response.stream.bytesToString(), component);
    } else {
      logger.e(response.reasonPhrase, component);
    }
  }

  Future<JwtLogin> login(String username, password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request =
        http.Request('POST', Uri.parse('$BASE_API_URL/auth/jwt/login'));
    request.bodyFields = {'username': username, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return jwtLoginFromJson(await response.stream.bytesToString());
    } else {
      logger.e(response.reasonPhrase, component);
      throw Exception(response.reasonPhrase);
    }
  }
}
