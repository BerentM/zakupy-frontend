import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    Key? key,
    required this.textController,
    this.label,
  }) : super(key: key);

  final TextEditingController textController;
  final String? label;

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
            counterText: '',
            border: const UnderlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    required this.textController,
    this.label,
  }) : super(key: key);

  final TextEditingController textController;
  final String? label;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.textController,
        validator: (value) {
          if (value != null) {
            return null;
          } else {
            return "Please enter a value";
          }
        },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: widget.label,
        ),
      ),
    );
  }
}

class DropdownField extends StatefulWidget {
  const DropdownField({
    super.key,
    required this.textController,
    required this.label,
    required this.options,
  });
  final TextEditingController textController;
  final String label;
  final List<String> options;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(labelText: widget.label),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: widget.textController.text.isNotEmpty
                ? widget.textController.text
                : null,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            onChanged: (String? value) {
              setState(() {
                widget.textController.text = value!;
              });
            },
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class DropdownPopup extends StatelessWidget {
  const DropdownPopup({Key? key, required this.popupName}) : super(key: key);
  final String popupName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24.0,
      color: Colors.grey,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: popupName,
                    icon: const Icon(Icons.category),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.save),
                    onPressed: () {
                      // TODO: API cal
                    })
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
