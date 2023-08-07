import 'package:flutter/foundation.dart';

import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/auth.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/data/models/shopping_list.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';
import 'package:pocketbase/pocketbase.dart';

class ApiService {
  // singleton pattern
  // every instance of the ApiService will be the same isntance
  static ApiService? _instance;
  factory ApiService() {
    _instance ??= ApiService._();
    return _instance!;
  }
  ApiService._();

  final component = "ApiService";
  var pb = PocketBase(kDebugMode ? LOCAL_API_URL : REMOTE_API_URL);

  Future<Map<String, String>> getHeaders() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: "jwt")}'
    };
    logger.d(headers, component);

    return headers;
  }

  Future<RecordModel> fetchCategory(String? categoryName) async {
    if (categoryName == "" || categoryName == null) {
      return RecordModel();
    }
    return await pb
        .collection('categories')
        .getFirstListItem('name="$categoryName"')
        .catchError((error) {
      logger.e(error, component);
      throw Exception("Couldn't fetch category.");
    });
  }

  Future<RecordModel> fetchShop(String? shopName) async {
    if (shopName == "" || shopName == null) {
      return RecordModel();
    }
    return await pb
        .collection('shops')
        .getFirstListItem('name="$shopName"')
        .catchError((error) {
      logger.e(error, component);
      throw Exception("Couldn't fetch shop.");
    });
  }

  Future<ShoppingList> fetchShoppingList() async {
    // TODO: add pagination
    final records =
        await pb.collection('shopping_list').getFullList().catchError((error) {
      logger.e(error, component);
      throw Exception("Couldn't fetch shopping list.");
    });
    return ShoppingList.fromRecords(records);
  }

  Future<ProductList> fetchProductList() async {
    // TODO: add pagination
    final records = await pb
        .collection('products')
        .getFullList(expand: 'shop_id,category_id')
        .catchError((error) {
      logger.e(error, component);
      throw Exception("Couldn't fetch product list.");
    });
    var data = ProductList.fromRecords(records);
    return data;
  }

  Future<void> fillUp(Map<String, int> ids) async {
    for (var key in ids.keys) {
      final body = <String, dynamic>{"current_amount": ids[key]};
      await pb
          .collection('products')
          .update(key, body: body)
          .catchError((error) {
        logger.e(error, component);
        throw Exception("Unsucesfull fill up");
      });
    }
  }

  Future<JwtLogin> login(String username, password) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(username, password)
        .catchError((error) {
      logger.e(error, component);
      throw Exception("Unsucesfull login");
    });

    return JwtLogin(accessToken: authData.token, tokenType: "tmp");
  }

  Future<void> logout() async {
    pb.authStore.clear();
  }

  Future<ProductListElement> addProduct(ProductListElement data) async {
    var newCategory = await fetchCategory(data.category);
    var newSource = await fetchShop(data.source);
    var body = data.toRequestBody(
      newSource.id == "" ? null : newSource.id,
      newCategory.id == "" ? null : newCategory.id,
    );

    final _ =
        await pb.collection('products').create(body: body).catchError((error) {
      logger.e(error);
      throw Exception("Couldn't add new product.");
    });
    return data;
  }

  Future<ProductListElement> updateProduct(
    String id,
    ProductListElement data,
  ) async {
    var newCategory = await fetchCategory(data.category);
    var newSource = await fetchShop(data.source);
    var body = data.toRequestBody(
      newSource.id == "" ? null : newSource.id,
      newCategory.id == "" ? null : newCategory.id,
    );

    final _ = await pb
        .collection('products')
        .update(id, body: body)
        .catchError((error) {
      logger.e(error);
      throw Exception("Couldn't update product.");
    });

    return data;
  }

  void deleteProduct(String id) async {
    await pb.collection('products').delete(id).catchError((error) {
      logger.e(error, component);
      throw Exception("Couldn't delete product.");
    });
    logger.d("Product with id=$id deleted.", component);
  }

  Future<List<String>> fetchCollectionNames(String collection) async {
    final records = await pb.collection(collection).getFullList();
    return records.map((e) => e.getStringValue("name")).toList();
  }
}
