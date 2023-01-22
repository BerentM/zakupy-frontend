import 'package:flutter/material.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/view/home/home.dart';
import 'package:zakupy_frontend/view/shopping_list/shopping_list.dart';

import '../constants/strings.dart';
import '../data/repository.dart';

class AppRouter {
  Repository repository = Repository(ApiService());

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => Home());
      case SHOPPING_LIST:
        return MaterialPageRoute(builder: (_) => const ShoppingList());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text("dupa"),
            ),
          ),
        );
    }
  }
}
