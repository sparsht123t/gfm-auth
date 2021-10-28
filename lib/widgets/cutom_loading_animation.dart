
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';





class CustomLoadingAnimation extends StatelessWidget {
  final screenSize;
  final height;

  const CustomLoadingAnimation({Key? key, this.screenSize, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/lottie/loading.json",
          height:
          height != null ? height * screenSize.height
              : 0.15 * screenSize.height,
          frameRate: FrameRate.max),
    );
  }
}
