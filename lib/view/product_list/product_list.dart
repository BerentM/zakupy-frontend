import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/view/product_list/widgets/product_view.dart';

import 'cubit/product_list_cubit.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.product_list),
        ),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, state) {
            if (state is ProductListInitial) {
              context.read<ProductListCubit>().loadData();
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductListLoaded) {
              return ProductListView(
                currentData: state.currentData,
              );
            }
            return const Scaffold();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ADD_PRODUCT),
          backgroundColor: Colors.blue.withOpacity(0.7),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
