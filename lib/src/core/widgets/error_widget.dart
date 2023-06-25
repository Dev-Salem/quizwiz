import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: CupertinoButton(
              child: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pushNamed('/'))),
      body: const Center(
        child: Text(AppStrings.errorMessage),
      ),
    );
  }
}
