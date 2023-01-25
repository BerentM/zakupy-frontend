import 'package:flutter/material.dart';
import 'package:zakupy_frontend/view/home/home.dart';
import 'package:zakupy_frontend/view/shopping_list/shopping_list.dart';
import 'package:zakupy_frontend/view/shopping_list/widgets/shopping_list_add_view.dart';

import '../constants/strings.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const Home());
      case SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const ShoppingList());
      case ADD_SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const ShoppingListAddView());
      case EDIT_SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const Scaffold());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
