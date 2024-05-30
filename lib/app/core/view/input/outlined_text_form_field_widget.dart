import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:firebase_auth_project/app/core/services/enum_input_type.dart';
import 'package:flutter/material.dart';

class OutLineTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines, minLines;
  final TextInputType textInputType;
  final String labelText;
  final int? maxLength;
  final AutovalidateMode autoValidateMode;
  final bool obscureText;
  final InputTypeEnum inputTypeEnum;

  final Icon prefixIcon;
  final IconButton? suffixIconButton;
  final bool showSuffixIcon;

  const OutLineTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType = TextInputType.text,
    this.labelText = "",
    this.maxLength,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.obscureText = false,
    required this.prefixIcon,
    this.showSuffixIcon = false,
    this.suffixIconButton,
    required this.inputTypeEnum,
  });

  @override
  Widget build(BuildContext context) {
    const focusedOutLinedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.primaryColor, width: 1.5),
    );
    const outLinedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.blackColor, width: 1),
    );
    const focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.redColor, width: 1.5),
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
        labelStyle: const TextStyle(color: ColorConstants.blackColor),
        errorBorder: focusedErrorBorder,
        focusedBorder: focusedOutLinedBorder,
        enabledBorder: outLinedBorder,
        focusedErrorBorder: focusedErrorBorder,
      ),
      validator: (value) {
        switch (inputTypeEnum) {
          case InputTypeEnum.email:
            RegExp regex = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
            if (value!.isEmpty) {
              return "Please enter email";
            } else {
              if (!regex.hasMatch(value)) {
                return "Enter valid email";
              } else {
                return null;
              }
            }
          case InputTypeEnum.password:
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
            if (value!.isEmpty) {
              return "Please enter password";
            } else {
              if (!regex.hasMatch(value)) {
                return "Enter valid password";
              } else {
                return null;
              }
            }
          case InputTypeEnum.otp:
            RegExp regex = RegExp(r'^[0-9]{6}$');
            if (value!.isEmpty) {
              return "Please enter otp";
            } else {
              if (!regex.hasMatch(value)) {
                return "OTP must contain 6 digits";
              } else {
                return null;
              }
            }
        }
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
