import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  const CustomErrorWidget(
      {super.key, this.errorMessage = AppStrings.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error:$errorMessage"),
            TextButton(
                onPressed: () {
                  context.read<CardsBloc>().add(GetCollectionsEvent());
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: Text(errorMessage))
          ],
        ),
      ),
    );
  }
}
