import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizwiz/src/core/utils/strings.dart';

class NoResultScreen extends StatelessWidget {
  final String description;
  const NoResultScreen({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                AppStrings.notFoundAsset,
                height: 250,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
