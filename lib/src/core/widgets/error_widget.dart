import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  const CustomErrorWidget(
      {super.key, this.errorMessage = AppStrings.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: CupertinoButton(
              child: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pushNamed('/'))),
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
