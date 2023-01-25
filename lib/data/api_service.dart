import 'package:http/http.dart' as http;
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/shopping_list.dart';

class ApiService {
  // Future<ShoppingList> fetchShoppingList() async {
  Future<ShoppingListModel> fetchShoppingList() async {
    final request = http.Request(
      'GET',
      Uri.parse('$BASE_API_URL/shopping_list'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return shoppingListFromJson(await response.stream.bytesToString());
    } else {
      return shoppingListFromJson("");
    }
  }
}
