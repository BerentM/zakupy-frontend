import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/view/shopping_list/shopping_list_view.dart';

import 'cubit/shopping_list_cubit.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingListCubit(),
      child: ShoppingListView(),
    );
  }
}
