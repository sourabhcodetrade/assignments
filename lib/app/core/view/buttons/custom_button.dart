import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height;

  const CustomButton(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.width,
      required this.height});

  @override
  ElevatedButton build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: Size(width, height),
        minimumSize: Size(width, height),
        foregroundColor: ColorConstants.whiteColor,
        backgroundColor: ColorConstants.primaryColor,
      ),
      onPressed: onPressed,
      child: child);
}
