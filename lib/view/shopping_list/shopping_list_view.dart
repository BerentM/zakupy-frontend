import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/shopping_list_cubit.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.shopping_list),
        ),
        body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            var display = "first";
            if (state is ShoppingListFirst) {
              display = "second";
            }
            return Column(
              children: [
                Text("Current state $state"),
                ElevatedButton(
                  onPressed: (() => state is ShoppingListFirst
                      ? context.read<ShoppingListCubit>().second()
                      : context.read<ShoppingListCubit>().first()),
                  child: Text(display),
                ),
              ],
            );
          },
        ));
  }
}
