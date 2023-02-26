import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart' as m;
import 'package:zakupy_frontend/view/home/home.dart';
import 'package:zakupy_frontend/view/shopping_list/shopping_list.dart';
import 'package:zakupy_frontend/view/product_list/product_list.dart';
import 'package:zakupy_frontend/view/product_list/widgets/product_list_add_view.dart';
import 'package:zakupy_frontend/view/product_list/widgets/product_list_edit_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const Home());
      case SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const ShoppingList());
      case PRODUCT_LIST:
        return MaterialPageRoute(builder: (_) => const ProductList());
      case ADD_PRODUCT:
        return MaterialPageRoute(builder: (_) => const ProductListAddView());
      case EDIT_PRODUCT:
        return MaterialPageRoute(
          builder: (_) => ProductListEditView(
            productData: settings.arguments as m.ProductListElement,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
