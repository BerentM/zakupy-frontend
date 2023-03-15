import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingListView extends StatefulWidget {
  final ProductList currentData;
  const ShoppingListView({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  late List<ProductListElement> shoppingList = widget.currentData.productList;
  int lastPos = 1;

  void _runFilter(String searchedString) {
    List<ProductListElement> output;
    if (searchedString.isEmpty) {
      output = widget.currentData.productList;
    } else {
      var productOutput = widget.currentData.productList
          .where((value) => value.product!
              .toLowerCase()
              .contains(searchedString.toLowerCase()))
          .toList();
      var sourceOutput = widget.currentData.productList
          .where((value) => value.source!
              .toLowerCase()
              .contains(searchedString.toLowerCase()))
          .toList();
      output = [...productOutput, ...sourceOutput];
    }
    setState(() {
      shoppingList = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    shoppingList.sort(
      (a, b) => a.product!.toLowerCase().compareTo(b.product!.toLowerCase()),
    );
    shoppingList.sort(
      (a, b) => a.position.compareTo(b.position),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.search,
                suffixIcon: const Icon(Icons.search)),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shoppingList.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: shoppingList[index].selected,
                onTap: () => shoppingList[index].selected
                    ? setState(() {
                        shoppingList[index].position = 0;
                        shoppingList[index].selected = false;
                      })
                    : setState(() {
                        lastPos += 1;
                        shoppingList[index].position = lastPos;
                        shoppingList[index].selected = true;
                      }),
                onLongPress: () => Navigator.pushNamed(context, EDIT_SHOPPING,
                    arguments: shoppingList[index]),
                leading: SizedBox(
                  height: double.infinity, // center icon
                  child: Icon(
                    Icons.shopping_cart,
                    color: shoppingList[index].selected
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
                title: Text(shoppingList[index].product!),
                trailing: Text(shoppingList[index].missingAmount.toString()),
                subtitle: Text(shoppingList[index].source!),
              );
            },
          ),
        ),
      ],
    );
  }
}
