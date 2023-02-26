import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';

import '../cubit/product_list_cubit.dart';
import 'main_product_list_view.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.product_list),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, ADD_PRODUCT),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListInitial) {
            context.read<ProductListCubit>().loadData();
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductListLoaded) {
            return MainProductListView(
              currentData: state.currentData,
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}
