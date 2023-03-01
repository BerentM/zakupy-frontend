import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
