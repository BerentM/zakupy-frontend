import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var component = "home screen";

  List<Widget> buildChildren(BuildContext context) {
    var builder = [
      const Text("Home"),
      ElevatedButton(
        onPressed: (() => Navigator.pushNamed(context, SHOPPING_LIST)),
        child: Text(AppLocalizations.of(context)!.shopping_list),
      ),
      Center(
        child: ElevatedButton(
          onPressed: (() => Navigator.pushNamed(context, PRODUCT_LIST)),
          child: Text(AppLocalizations.of(context)!.product_list),
        ),
      ),
    ];
    storage.read(key: "jwt").then((token) {
      logger.d("jwt token: $token", component);
      if (token == null) {
        builder.add(
          Center(
            child: ElevatedButton(
              onPressed: (() => Navigator.pushNamed(context, LOGIN)),
              child: Text(AppLocalizations.of(context)!.login),
            ),
          ),
        );
      }
    });

    return builder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildChildren(context)),
    );
  }
}
