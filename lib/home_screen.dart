import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: cubeGrid,
              child: const Text(
                'CubeGrid Loader',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: hourGlass,
              child: const Text(
                'hourGlass Loader',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: chasingDots,
              child: Text(
                'chasingDots Loader',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: showToast,
              child: Text(
                'Toast',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: showError,
              child: Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: showInfo,
              child: Text(
                'Info',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: showSuccess,
              child: Text(
                'Success',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cubeGrid() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(status: 'Loading...');
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }

  void hourGlass() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.custom
      ..toastPosition = EasyLoadingToastPosition.top
      ..maskColor = Colors.amber
      ..indicatorType = EasyLoadingIndicatorType.pulse;
    EasyLoading.show(status: 'Loading...');
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }
}

void chasingDots() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.show(status: 'Loading...');
  Future.delayed(const Duration(seconds: 2), () {
    EasyLoading.dismiss();
  });
}

void showToast() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..toastPosition = EasyLoadingToastPosition.bottom;
  EasyLoading.showToast('This is a toast message',
      duration: const Duration(seconds: 2)); // Set the duration for the toast
}

void showError() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..errorWidget = Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              "Error",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  EasyLoading.showError('This is a error message',
      duration: const Duration(seconds: 2)); // Set the duration for the toast
}

void showInfo() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.showInfo('This is a Info message',
      duration: const Duration(seconds: 2)); // Set the duration for the toast
}

void showSuccess() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.showSuccess('This is a Success message',
      duration: const Duration(seconds: 2)); // Set the duration for the toast
}
