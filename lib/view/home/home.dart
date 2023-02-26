import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Center(
            child: ElevatedButton(
              onPressed: (() => Navigator.pushNamed(context, LOGIN)),
              child: Text(AppLocalizations.of(context)!.login),
            ),
          )
        ],
      ),
    );
  }
}
