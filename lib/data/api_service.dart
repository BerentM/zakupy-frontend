import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiService {
  final baseUrl = "http://10.0.2.2:3000";
  Future<List<dynamic>> fetchShoppingList() async {
    try {
      final response = await get(Uri.parse("$baseUrl/shopping_list"));
      if (kDebugMode) {
        print(response.body);
      }
      return jsonDecode(response.body) as List;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
