import 'package:http/http.dart' as http;
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

class ApiService {
  // Future<ShoppingList> fetchShoppingList() async {
  Future<ProductList> fetchShoppingList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$BASE_API_URL/productList/all'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return productListFromJson(await response.stream.bytesToString());
    } else {
      return productListFromJson("");
    }
  }
}
