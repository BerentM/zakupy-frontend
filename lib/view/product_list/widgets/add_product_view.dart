import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/view/common/buttons.dart';
import 'package:zakupy_frontend/view/common/input_fields.dart';

class ProductListAddView extends StatefulWidget {
  const ProductListAddView({Key? key}) : super(key: key);

  @override
  State<ProductListAddView> createState() => _ProductListAddViewState();
}

class _ProductListAddViewState extends State<ProductListAddView> {
  final categoryController = TextEditingController(),
      productController = TextEditingController(),
      shopController = TextEditingController(),
      currentAmountController = TextEditingController(),
      targetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.add_product),
      ),
      body: ListView(
        children: [
          TextInput(
            textController: productController,
            label: AppLocalizations.of(context)!.product,
          ),
          Row(children: [
            Expanded(
              child: FutureBuilder(
                  future: ApiService().fetchCollectionNames("shops"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator
                      return const CircularProgressIndicator();
                    }
                    return DropdownField(
                      textController: shopController,
                      label: AppLocalizations.of(context)!.shop,
                      options: snapshot.data,
                    );
                  }),
            ),
            DropdownPopup(
              popupName: AppLocalizations.of(context)!.shop,
              collection: "shops",
            ),
          ]),
          Row(children: [
            Expanded(
              child: FutureBuilder(
                  future: ApiService().fetchCollectionNames("categories"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator
                      return const CircularProgressIndicator();
                    }
                    return DropdownField(
                      textController: categoryController,
                      label: AppLocalizations.of(context)!.category,
                      options: snapshot.data,
                    );
                  }),
            ),
            DropdownPopup(
              popupName: AppLocalizations.of(context)!.category,
              collection: "categories",
            ),
          ]),
          Row(children: [
            NumberInput(
              textController: currentAmountController,
              label: AppLocalizations.of(context)!.current_amount,
            ),
            NumberInput(
              textController: targetAmountController,
              label: AppLocalizations.of(context)!.target_amount,
            ),
            _SaveButton(
              categoryController: categoryController,
              productController: productController,
              shopController: shopController,
              currentAmountController: currentAmountController,
              targetAmountController: targetAmountController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CancelButton(context: context),
            ),
          ])
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
    required this.categoryController,
    required this.productController,
    required this.shopController,
    required this.currentAmountController,
    required this.targetAmountController,
  }) : super(key: key);

  final TextEditingController categoryController,
      productController,
      shopController,
      currentAmountController,
      targetAmountController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(AppLocalizations.of(context)!.save),
        onPressed: () => {
          ApiService().addProduct(
            ProductListElement(
              category: categoryController.text,
              product: productController.text,
              source: shopController.text,
              currentAmount: int.parse(currentAmountController.text),
              targetAmount: int.parse(targetAmountController.text),
            ),
          ),
          Navigator.popAndPushNamed(
            context,
            PRODUCT_LIST,
          )
        },
      ),
    );
  }
}
