import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/auth.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/data/models/shopping_list.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';
import 'package:pocketbase/pocketbase.dart';

class ApiService {
  final component = "ApiService";
  final url = kDebugMode ? LOCAL_API_URL : REMOTE_API_URL;
  // TODO: deduplicate
  final pb = PocketBase(kDebugMode ? LOCAL_API_URL : REMOTE_API_URL);

  Future<Map<String, String>> getHeaders() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: "jwt")}'
    };
    logger.d(headers, component);

    return headers;
  }

  Future<ShoppingList> fetchShoppingList() async {
    final records = await pb.collection('shopping_list').getFullList();
    return ShoppingList.fromRecords(records);
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

  Future<void> fillUp(Map<String, int> ids) async {
    logger.i("filling up missing amount");
    for (var key in ids.keys) {
      final body = <String, dynamic>{"current_amount": ids[key]};
      await pb.collection('products').update(key, body: body);
    }
  }

  Future<JwtLogin> login(String username, password) async {
    final authData = await pb.collection('users').authWithPassword(
          username,
          password,
        );

    if (authData.token != null) {
      return JwtLogin(accessToken: authData.token, tokenType: "tmp");
    } else {
      logger.e("Unsucesfull login");
      throw Exception("Unsucesfull login");
    }
  }

  Future<void> logout() async {
    final request = http.Request(
      'POST',
      Uri.parse('$url/auth/jwt/logout'),
    );
    request.headers.addAll(await getHeaders());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.d(await response.stream.bytesToString(), component);
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
    String id,
    ProductListElement data,
  ) async {
    // TODO:
    return productListElementFromJson("{}");
    // var request =
    //     http.Request('PATCH', Uri.parse('$url/productList/update_item?id=$id'));
    // request.body = productListElementToJson(data);
    // request.headers.addAll(await getHeaders());

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   return productListElementFromJson(await response.stream.bytesToString());
    // } else {
    //   logger.e(response.reasonPhrase, component);
    //   throw Exception(response.reasonPhrase);
    // }
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
