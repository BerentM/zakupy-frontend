import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

class ProductListView extends StatefulWidget {
  final ProductList currentData;
  const ProductListView({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<ProductListElement> productList = widget.currentData.productList;
  int lastPos = 1;
  @override
  Widget build(BuildContext context) {
    productList.sort(
      (a, b) => a.position.compareTo(b.position),
    );
    return ListView.builder(
      itemCount: widget.currentData.count,
      itemBuilder: (context, index) {
        return ListTile(
          selected: productList[index].selected,
          onLongPress: () => Navigator.pushNamed(context, EDIT_PRODUCT,
              arguments: productList[index]),
          leading: const SizedBox(
            height: double.infinity, // center icon
            child: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
          ),
          title: Text(productList[index].product!),
          trailing: Text(
              "${productList[index].currentAmount.toString()}/${productList[index].targetAmount.toString()}"),
          subtitle: Text(productList[index].source!),
        );
      },
    );
  }
}
