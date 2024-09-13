import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool light = false;

  @override
  void initState() {
    super.initState();
    fetchLight();
  }

  void fetchLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      light = prefs.getBool('light') ?? true;
    });
  }

  void updateLight(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('light', value);
  }

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
            const Text(
              "Dark Mode Switch",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Dark",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  width: 8,
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
                      updateLight(value);
                      light
                          ? themeProvider.setLightMode()
                          : themeProvider.setDarkMode();
                    });
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Light",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
