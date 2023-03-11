import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/view/common/buttons.dart';
import 'package:zakupy_frontend/view/common/input_fields.dart';

class ProductListEditView extends StatefulWidget {
  final ProductListElement productData;

  const ProductListEditView({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  State<ProductListEditView> createState() => _ProductListEditViewState();
}

class _ProductListEditViewState extends State<ProductListEditView> {
  final categoryController = TextEditingController(),
      productController = TextEditingController(),
      sourceController = TextEditingController(),
      currentAmountController = TextEditingController(),
      targetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productData = widget.productData;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_product),
        actions: [
          IconButton(
            onPressed: () {
              ApiService().deleteProduct(productData.id!);
              Navigator.popAndPushNamed(
                context,
                PRODUCT_LIST,
              );
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: ListView(
        children: [
          TextInput(
            textController: categoryController,
            label: productData.category!,
          ),
          TextInput(
            textController: productController,
            label: productData.product!,
          ),
          TextInput(
            textController: sourceController,
            label: productData.source!,
          ),
          Row(children: [
            NumberInput(
              textController: currentAmountController,
              label: "${productData.currentAmount!}",
            ),
            NumberInput(
              textController: targetAmountController,
              label: "${productData.targetAmount!}",
            ),
            _SaveButton(
              id: productData.id!,
              categoryController: categoryController,
              productController: productController,
              shopController: sourceController,
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
    required this.id,
    required this.categoryController,
    required this.productController,
    required this.shopController,
    required this.currentAmountController,
    required this.targetAmountController,
  }) : super(key: key);

  final int id;
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
          categoryController.clear(),
          productController.clear(),
          shopController.clear(),
          currentAmountController.clear(),
          targetAmountController.clear(),
          Navigator.popAndPushNamed(
            context,
            PRODUCT_LIST,
          )
        },
      ),
    );
  }
}
