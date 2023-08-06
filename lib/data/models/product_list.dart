import 'package:pocketbase/pocketbase.dart';

class ProductList {
  ProductList({
    required this.productList,
    required this.count,
  });

  List<ProductListElement> productList;
  int count;

  factory ProductList.fromRecords(List<RecordModel> records) => ProductList(
        productList: List<ProductListElement>.from(
            records.map((e) => ProductListElement.fromRecord(e))),
        count: records.length,
      );
}

class ProductListElement {
  ProductListElement({
    this.id,
    this.product,
    this.source,
    this.category,
    this.targetAmount,
    this.currentAmount,
    this.missingAmount,
  });

  String? id;
  String? product;
  String? source;
  String? category;
  int? targetAmount;
  int? currentAmount;
  int? missingAmount;
  bool selected = false;
  int position = 1;

  Map<String, dynamic> toJson() {
    final map = {
      "product": product,
      "source": source,
      "category": category,
      "target_amount": targetAmount,
      "current_amount": currentAmount,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Map<String, dynamic> toRequestBody(String? shopId, String? categoryId) {
    final map = {
      "name": product,
      "shop_id": shopId,
      "category_id": categoryId,
      "target_amount": targetAmount,
      "current_amount": currentAmount,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory ProductListElement.fromRecord(RecordModel record) {
    // TODO: refactor it to more elegant solution
    var rawData = record.toJson();
    var expand = rawData["expand"] as Map<String, dynamic>;
    String? shop =
        expand.containsKey("shop_id") ? expand["shop_id"]["name"] : "";
    String? category =
        expand.containsKey("category_id") ? expand["category_id"]["name"] : "";
    return ProductListElement(
      id: record.id,
      product: record.getStringValue("name"),
      source: shop,
      category: category,
      currentAmount: record.getIntValue("current_amount"),
      targetAmount: record.getIntValue("target_amount"),
      missingAmount: record.getIntValue("missing_amount"),
    );
  }
}
