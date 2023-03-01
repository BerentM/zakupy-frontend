import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';

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
          _TextInput(
            textController: categoryController,
            label: AppLocalizations.of(context)!.category,
          ),
          _TextInput(
            textController: productController,
            label: AppLocalizations.of(context)!.product,
          ),
          _TextInput(
            textController: shopController,
            label: AppLocalizations.of(context)!.shop,
          ),
          Row(children: [
            _NumberInput(
              textController: currentAmountController,
              label: AppLocalizations.of(context)!.current_amount,
            ),
            _NumberInput(
              textController: targetAmountController,
              label: AppLocalizations.of(context)!.target_amount,
            ),
            SaveButton(
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

class SaveButton extends StatelessWidget {
  const SaveButton({
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
          categoryController.clear(),
          productController.clear(),
          shopController.clear(),
          currentAmountController.clear(),
          targetAmountController.clear(),
          Navigator.pop(
            context,
          )
        },
      ),
    );
  }
}

class _NumberInput extends StatelessWidget {
  const _NumberInput({
    Key? key,
    required this.textController,
    required this.label,
  }) : super(key: key);

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(100, 100)),
        child: TextFormField(
          controller: textController,
          maxLength: 5,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    Key? key,
    required this.textController,
    required this.label,
  }) : super(key: key);

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red[600]),
        overlayColor: MaterialStateProperty.all(Colors.red[300]),
      ),
      onPressed: () => Navigator.pop(context),
      child: Text(AppLocalizations.of(context)!.cancel),
    );
  }
}
