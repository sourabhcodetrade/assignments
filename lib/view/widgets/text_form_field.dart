import 'package:flutter/material.dart';

class ReusableTextFromField extends StatefulWidget {
  const ReusableTextFromField({
    super.key,
    required this.formKey1,
    required this.amountController,
    required this.isNumber,
    required this.text,
    required this.hint,
  });

  final GlobalKey<FormState> formKey1;
  final bool isNumber;
  final String text;
  final String hint;
  final TextEditingController amountController;

  @override
  State<ReusableTextFromField> createState() => _ReusableTextFromFieldState();
}

class _ReusableTextFromFieldState extends State<ReusableTextFromField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey1,
      child: TextFormField(
        controller: widget.amountController,
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          label: Text(widget.text),
          hintText: widget.hint,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
      ),
    );
  }
}