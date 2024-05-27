import 'package:flutter/material.dart';

import 'color_constants.dart';

final class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool showLeading;

  const CustomAppBar(
    this.title, {
    super.key,
    this.leading,
    this.actions = const [],
    this.showLeading = true,
  });

  @override
  AppBar build(BuildContext context) => AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.colorGreen,
        leading: showLeading
            ? leading ??
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                )
            : null,
        actions: actions,
      );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
