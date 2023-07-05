import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

import 'features/cards/controller/controller.dart';

class QuizWizApp extends StatelessWidget {
  const QuizWizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CardsBloc>()..add(GetCollectionsEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          home: const HomeScreen()),
    );
  }
}
