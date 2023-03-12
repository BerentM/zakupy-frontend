import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/auth.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';

class ApiService {
  final component = "ApiService";
  final url = kDebugMode ? LOCAL_API_URL : REMOTE_API_URL;

  Future<Map<String, String>> getHeaders() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: "jwt")}'
    };
    logger.d(headers, component);

    return headers;
  }

  Future<ProductList> fetchShoppingList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$url/shoppingList/all?missing_percent=0.1'),
    );
    request.headers.addAll(await getHeaders());

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
      Uri.parse('$url/productList/all'),
    );
    request.headers.addAll(await getHeaders());

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
      Uri.parse('$url/shoppingList/fill_up'),
    );
    request.headers.addAll(await getHeaders());
    logger.i("ids inside fillUp: $ids", component);
    request.body = json.encode(ids);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i(await response.stream.bytesToString(), component);
    } else {
      logger.e(
          "$request\n${request.body}\n${response.reasonPhrase}", component);
    }
  }

  Future<JwtLogin> login(String username, password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
      'POST',
      Uri.parse('$url/auth/jwt/login'),
    );
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

  Future<ProductListElement> addProduct(ProductListElement data) async {
    var request = http.Request(
      'POST',
      Uri.parse('$url/productList/create_item'),
    );
    request.body = productListElementToJson(data);
    request.headers.addAll(await getHeaders());

    logger.d(request.body, component);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return productListElementFromJson(await response.stream.bytesToString());
    } else {
      logger.e(response.reasonPhrase, component);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ProductListElement> updateProduct(
    int id,
    ProductListElement data,
  ) async {
    var request =
        http.Request('PATCH', Uri.parse('$url/productList/update_item?id=$id'));
    request.body = productListElementToJson(data);
    request.headers.addAll(await getHeaders());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return productListElementFromJson(await response.stream.bytesToString());
    } else {
      logger.e(response.reasonPhrase, component);
      throw Exception(response.reasonPhrase);
    }
  }

  void deleteProduct(int id) async {
    var request = http.Request(
      'DELETE',
      Uri.parse('$url/productList/delete_item?id=$id'),
    );
    request.headers.addAll(await getHeaders());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.d("Product with id=$id deleted.", component);
    } else {
      logger.e(response.reasonPhrase, component);
      throw Exception(response.reasonPhrase);
    }
  }
}
