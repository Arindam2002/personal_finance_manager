import 'package:flutter/material.dart';
import 'package:personal_finance_manager/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.formController,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  final TextEditingController formController;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: formController,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      style: TextStyle(color: kPrimaryTextColor, fontSize: 14),
      cursorColor: kPrimaryTextColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF7f8180), fontSize: 14),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGreyColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}