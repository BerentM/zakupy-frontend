import 'package:flutter/material.dart';
import 'package:zakupy_frontend/view/home/home.dart';
import 'package:zakupy_frontend/view/shopping_list/shopping_list.dart';

import '../constants/strings.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const Home());
      case SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const ShoppingList());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
