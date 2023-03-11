import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/view/shopping_list/widgets/shopping_list_view.dart';

import 'cubit/shopping_list_cubit.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingListCubit(),
      child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.shopping_list),
        actions: [
          BlocBuilder<ShoppingListCubit, ShoppingListState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is ShoppingListLoaded) {
                    context.read<ShoppingListCubit>().fillUp(state.currentData);
                  }
                },
                icon: const Icon(Icons.save),
              );
            },
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, ADD_PRODUCT),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
        builder: (context, state) {
          if (state is ShoppingListInitial) {
            context.read<ShoppingListCubit>().loadData();
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ShoppingListLoaded) {
            return ShoppingListView(
              currentData: state.currentData,
            );
          }
          return const Scaffold();
        },
      ),
    ),
    );
  }
}
