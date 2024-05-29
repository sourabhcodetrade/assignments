import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> action;
  final bool showLeading;
  const CustomAppBar(this.title,
      {super.key,
      this.leading,
      this.action = const [],
      this.showLeading = true});

  @override
  AppBar build(BuildContext context) => AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: action,
        backgroundColor: ColorConstants.primaryColor,
        leading: showLeading
            ? leading ??
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                )
            : null,
      );

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
