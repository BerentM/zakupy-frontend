import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zakupy_frontend/constants/strings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Home"),
          ElevatedButton(
              onPressed: (() => Navigator.pushNamed(context, SHOPPING_LIST)),
              child: Center(child: Text("Go to shopping list")))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
