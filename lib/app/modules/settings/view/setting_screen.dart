import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dark Mode Switch",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Switch(
              value: light,
              activeColor: Colors.white,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                  light
                      ? themeProvider.setLightMode()
                      : themeProvider.setDarkmode();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
