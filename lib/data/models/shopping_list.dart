// To parse this JSON data, do
//
//     final shoppingList = shoppingListFromJson(jsonString);

import 'dart:convert';

ShoppingListModel shoppingListFromJson(String str) =>
    ShoppingListModel.fromJson(json.decode(str));

String shoppingListToJson(ShoppingListModel data) => json.encode(data.toJson());

class ShoppingListModel {
  ShoppingListModel({
    required this.shoppingList,
  });

  List<ShoppingListElement> shoppingList;

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) =>
      ShoppingListModel(
        shoppingList: List<ShoppingListElement>.from(
            json["shopping_list"].map((x) => ShoppingListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shopping_list":
            List<dynamic>.from(shoppingList.map((x) => x.toJson())),
      };

  int length() {
    return shoppingList.length;
  }
}

class ShoppingListElement {
  ShoppingListElement({
    required this.id,
    required this.count,
    required this.value,
    required this.market,
  });

  int id;
  int count;
  String value;
  String market;
  bool selected = false;
  int position = 1;

  factory ShoppingListElement.fromJson(Map<String, dynamic> json) =>
      ShoppingListElement(
        id: json["id"],
        count: json["count"],
        value: json["value"],
        market: json["market"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "value": value,
        "market": market,
      };
}
