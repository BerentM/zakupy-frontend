import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zakupy_frontend/data/models/shopping_list.dart';

import '../../constants/strings.dart';
import 'cubit/shopping_list_cubit.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.shopping_list),
          actions: [
            IconButton(
              onPressed: () => print("TODO: add new product!"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            if (state is ShoppingListInitial) {
              context.read<ShoppingListCubit>().loadData();
              return const CircularProgressIndicator();
            }
            if (state is ShoppingListLoaded) {
              return DisplayView(
                currentData: state.currentData,
              );
            }
            return const Scaffold();
          },
        ));
  }
}

class DisplayView extends StatefulWidget {
  final ShoppingList currentData;
  const DisplayView({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  late List<ShoppingListElement> shoppingList = widget.currentData.shoppingList;
  int lastPos = 1;
  @override
  Widget build(BuildContext context) {
    shoppingList.sort(
      (a, b) => a.position.compareTo(b.position),
    );
    return ListView.builder(
        itemCount: widget.currentData.length(),
        itemBuilder: (context, index) {
          return ListTile(
            selected: shoppingList[index].checked,
            onTap: () => shoppingList[index].checked
                ? setState(() {
                    shoppingList[index].position = 1;
                    shoppingList[index].checked = false;
                  })
                : setState(() {
                    lastPos += 1;
                    shoppingList[index].position = lastPos;
                    shoppingList[index].checked = true;
                  }),
            onLongPress: () => Navigator.pushNamed(context, EDIT_SHOPPING_LIST),
            leading: SizedBox(
              height: double.infinity, // center icon
              child: Icon(
                Icons.shopping_cart,
                color: shoppingList[index].checked ? Colors.green : Colors.grey,
              ),
            ),
            title: Text(shoppingList[index].value),
            trailing: Text(shoppingList[index].count.toString()),
            subtitle: Text(shoppingList[index].market),
          );
        });
  }
}
