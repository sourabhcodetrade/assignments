import 'package:agora_ui_kit_integration/utils/color_constants.dart';
import 'package:agora_ui_kit_integration/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

import '../utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar("Agora UI KIT"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.videoCallScreen);
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorConstants.primaryColor)),
                child: const Text(
                  "Video Call",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
