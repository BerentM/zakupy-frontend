import 'package:pocketbase/pocketbase.dart';

class ShoppingList {
  ShoppingList({
    required this.shoppingList,
    required this.count,
  });

  List<ShoppingListElement> shoppingList;
  int count;

  factory ShoppingList.fromRecords(List<RecordModel> records) => ShoppingList(
        shoppingList: List<ShoppingListElement>.from(
            records.map((x) => ShoppingListElement.fromRecord(x))),
        count: records.length,
      );
}

class ShoppingListElement {
  ShoppingListElement({
    required this.id,
    required this.product,
    required this.source,
    required this.category,
    required this.targetAmount,
    required this.currentAmount,
    required this.missingAmount,
  });

  String id;
  String product;
  String source;
  String category;
  int currentAmount;
  int targetAmount;
  int missingAmount;
  bool selected = false;
  int position = 1;

  factory ShoppingListElement.fromRecord(RecordModel record) =>
      ShoppingListElement(
        id: record.id,
        product: record.getStringValue("name"),
        source: record.getStringValue("shop"),
        category: record.getStringValue("category"),
        currentAmount: record.getIntValue("current_amount"),
        targetAmount: record.getIntValue("target_amount"),
        missingAmount: record.getIntValue("missing_amount"),
      );
}
