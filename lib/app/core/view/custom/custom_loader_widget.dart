import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final double height, width;
  final Color color;
  const LoadingWidget({super.key, required this.height, required this.width,  this.color = ColorConstants.primaryColor});

  @override
  SizedBox build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child:  SpinKitFadingCircle(
          color: color,
          size: 80.0,
        ),
      );
}

class RoundedRectangleBorderLoadingWidget extends StatelessWidget {
  final double height, width;
  const RoundedRectangleBorderLoadingWidget(
      {super.key, required this.height, required this.width});

  @override
  Card build(BuildContext context) => Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: ColorConstants.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Change 30.0 to your desired radius
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: const SpinKitChasingDots(
            color: ColorConstants.primaryColor,
            size: 50.0,
          ),
        ),
      );
}
