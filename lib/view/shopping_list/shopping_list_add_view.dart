import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingListAddView extends StatelessWidget {
  const ShoppingListAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.add_product),
      ),
      body: Column(
        children: [
          stringInputField(context, AppLocalizations.of(context)!.product),
          stringInputField(context, AppLocalizations.of(context)!.shop),
          Row(children: [
            numberInputField(context, AppLocalizations.of(context)!.count),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // TODO: implement
                onPressed: () => {},
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                  overlayColor: MaterialStateProperty.all(Colors.red[300]),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            )
          ])
        ],
      ),
    );
  }

  Padding stringInputField(BuildContext context, String label) {
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

  Padding numberInputField(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(200, 100)),
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
