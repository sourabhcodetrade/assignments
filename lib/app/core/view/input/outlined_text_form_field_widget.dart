import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:flutter/material.dart';

class OutLineTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines, minLines;
  final TextInputType textInputType;
  final void Function(BuildContext context)? onTap;
  final String labelText;
  final int? maxLength;
  final AutovalidateMode autoValidateMode;
  final bool obscureText;

  final Icon prefixIcon;
  final IconButton? suffixIconButton;
  final bool showSuffixIcon;

  const OutLineTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType = TextInputType.text,
    this.onTap,
    this.labelText = "",
    this.maxLength,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.obscureText = false,
    required this.prefixIcon,
    this.showSuffixIcon = false,
    this.suffixIconButton,
  });

  @override
  Widget build(BuildContext context) {
    const focusedOutLinedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.primaryColor, width: 1.5),
    );
    const outLinedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.blackColor, width: 1),
    );
    return TextFormField(
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      autovalidateMode: autoValidateMode,
      textInputAction: TextInputAction.next,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: ColorConstants.primaryColor,
        suffixIcon: showSuffixIcon ? suffixIconButton : null,
        suffixIconColor: ColorConstants.primaryColor,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: ColorConstants.blackColor
        ),
        errorBorder: outLinedBorder,
        focusedBorder: focusedOutLinedBorder,
        enabledBorder: outLinedBorder,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
