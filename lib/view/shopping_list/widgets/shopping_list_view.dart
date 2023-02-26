import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';

import '../cubit/shopping_list_cubit.dart';
import 'main_shopping_list_view.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.shopping_list),
          actions: [
            IconButton(
              //TODO: implement
              onPressed: () => {},
              icon: const Icon(Icons.save),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, ADD_PRODUCT_LIST),
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
              return MainShoppingListView(
                currentData: state.currentData,
              );
            }
            return const Scaffold();
          },
        ));
  }
}
