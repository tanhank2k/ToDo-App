import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/image_assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Lottie.asset(AnimationAssets.loading, height: 150),
    );
  }
}
