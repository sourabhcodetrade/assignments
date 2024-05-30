import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/contants/routes.dart';
import '../../../core/manager/app_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    appState.setInitialValue();
    Future.delayed(const Duration(seconds: 3),() {
      context.pushReplacementNamed(Routes.changePassword);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/firebase.svg",
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const Gap(10),
            const LoadingWidget(height: 100, width: 100),
          ],
        ),
      ),
    );
  }
}
