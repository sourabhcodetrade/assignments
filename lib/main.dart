import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package info',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PackageInfo packageInfo = PackageInfo(
      appName: 'unknown',
      packageName: 'unknown',
      version: 'unknown',
      buildNumber: 'unknown');
  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  void getPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AppName ${packageInfo.appName}'),
            Text('buildNumber ${packageInfo.buildNumber}'),
            Text('buildSignature ${packageInfo.buildSignature}'),
            Text('packageName ${packageInfo.packageName}'),
            Text('version ${packageInfo.version}'),
            Text('installerStore ${packageInfo.installerStore}'),
          ],
        ),
      ),
    );
  }
}
