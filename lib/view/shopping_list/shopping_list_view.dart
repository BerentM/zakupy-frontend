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
            if (state is ShoppingListInitial) {
              context.read<ShoppingListCubit>().loadData();
              return const CircularProgressIndicator();
            }
            if (state is ShoppingListLoaded) {
              return Column(
                children: [
                  Text("Current state $state"),
                  Text("Current data: ${state.currentData.value}"),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ShoppingListCubit>().reloadData(),
                    child: const Text("Reload"),
                  ),
                ],
              );
            }
            return const Scaffold();
          },
        ));
  }
}
