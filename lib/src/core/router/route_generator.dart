import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/create_flashcards.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/create_flashcards':
        return MaterialPageRoute(
            builder: (context) => const CreateFlashcardsScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
