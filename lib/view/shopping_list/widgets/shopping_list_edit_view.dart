import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zakupy_frontend/data/models/shopping_list.dart';

class ShoppingListEditView extends StatelessWidget {
  final ShoppingListElement productData;
  const ShoppingListEditView({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_product),
      ),
      body: Column(
        children: [
          StringInputField(context: context, label: productData.value),
          StringInputField(context: context, label: productData.market),
          Row(children: [
            NumberInputField(
                context: context, label: productData.count.toString()),
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(context: context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CancelButton(context: context),
            ),
            const Spacer(flex: 1),
          ])
        ],
      ),
    );
  }
}

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    Key? key,
    required this.context,
    required this.label,
  }) : super(key: key);

  final BuildContext context;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(100, 100)),
        child: TextFormField(
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

class StringInputField extends StatelessWidget {
  const StringInputField({
    Key? key,
    required this.context,
    required this.label,
  }) : super(key: key);

  final BuildContext context;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // TODO: implement
      onPressed: () => {},
      child: Text(AppLocalizations.of(context)!.save),
    );
  }
}
