import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
