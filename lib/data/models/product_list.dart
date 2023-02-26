// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';

ProductList productListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.productList,
    required this.count,
  });

  List<ProductListElement> productList;
  int count;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productList: List<ProductListElement>.from(
            json["product_list"].map((x) => ProductListElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
        "count": count,
      };
}

class ProductListElement {
  ProductListElement({
    required this.id,
    required this.product,
    required this.source,
    required this.category,
    required this.targetAmount,
    required this.currentAmount,
    required this.missingAmount,
  });

  int id;
  String product;
  String source;
  String category;
  int targetAmount;
  int currentAmount;
  int missingAmount;
  bool selected = false;
  int position = 1;

  factory ProductListElement.fromJson(Map<String, dynamic> json) =>
      ProductListElement(
        id: json["id"],
        product: json["product"],
        source: json["source"],
        category: json["category"],
        targetAmount: json["target_amount"],
        currentAmount: json["current_amount"],
        missingAmount: json["missing_amount"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "source": source,
        "category": category,
        "target_amount": targetAmount,
        "current_amount": currentAmount,
      };
}
