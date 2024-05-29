import 'package:flutter/material.dart';

final class UnderDevelopmentScreen extends StatelessWidget {
  final bool showLeading;
  const UnderDevelopmentScreen({super.key, this.showLeading = true});

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Under Development"),
        ),
        body: const Center(child: Text("Coming Soon")),
      );
}
