import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/view/common/buttons.dart';
import 'package:zakupy_frontend/view/common/input_fields.dart';

class ProductListEditView extends StatefulWidget {
  const ProductListEditView({
    Key? key,
    required this.productData,
    required this.backOffRoute,
  }) : super(key: key);
  final dynamic productData;
  final String backOffRoute;

  @override
  State<ProductListEditView> createState() => _ProductListEditViewState();
}

class _ProductListEditViewState extends State<ProductListEditView> {
  @override
  Widget build(BuildContext context) {
    final productData = widget.productData;
    final categoryController = TextEditingController(
          text: productData.category!,
        ),
        productController = TextEditingController(
          text: productData.product!,
        ),
        sourceController = TextEditingController(
          text: productData.source!,
        ),
        currentAmountController = TextEditingController(
          text: productData.currentAmount!.toString(),
        ),
        targetAmountController = TextEditingController(
          text: productData.targetAmount!.toString(),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_product),
        actions: [
          IconButton(
            onPressed: () {
              ApiService().deleteProduct(productData.id!);
              Navigator.popAndPushNamed(
                context,
                widget.backOffRoute,
              );
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
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
                      textController: sourceController,
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
              id: productData.id!,
              categoryController: categoryController,
              productController: productController,
              shopController: sourceController,
              currentAmountController: currentAmountController,
              targetAmountController: targetAmountController,
              backOffRoute: widget.backOffRoute,
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
    required this.id,
    required this.categoryController,
    required this.productController,
    required this.shopController,
    required this.currentAmountController,
    required this.targetAmountController,
    required this.backOffRoute,
  }) : super(key: key);

  final String backOffRoute;
  final String id;
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
          ApiService().updateProduct(
            id,
            ProductListElement(
              category: categoryController.text.isNotEmpty
                  ? categoryController.text
                  : null,
              product: productController.text.isNotEmpty
                  ? productController.text
                  : null,
              source:
                  shopController.text.isNotEmpty ? shopController.text : null,
              currentAmount: currentAmountController.text.isNotEmpty
                  ? int.parse(currentAmountController.text)
                  : null,
              targetAmount: targetAmountController.text.isNotEmpty
                  ? int.parse(targetAmountController.text)
                  : null,
            ),
          ),
          Navigator.popAndPushNamed(
            context,
            backOffRoute,
          )
        },
      ),
    );
  }
}
