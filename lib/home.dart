import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    var text = MediaQuery.of(context).textScaler;
    var d = MediaQuery.of(context).disableAnimations;
    var brightness = MediaQuery.of(context).platformBrightness;
    // print('Orientation $orientation');
    print('scaler $text');
    print('anime $d');
    print('brightness $brightness');
    print(Theme.of(context).platform);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 100,
                color: Colors.red,
                child: AspectRatio(
                  aspectRatio: 3 / 1,
                  child: Container(
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  height: 100,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                color: Colors.blue,
                height: h * 0.2,
                width: w * 0.2,
              ),
              SizedBox(
                height: 24,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 300) {
                    return Container(
                      height: 100,
                      color: Colors.brown,
                    );
                  } else {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    );
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.purple,
                      child: const Text("Portrait"),
                    );
                  } else {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.purpleAccent,
                      child: const Text("Landscape"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
