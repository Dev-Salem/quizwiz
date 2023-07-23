// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

import 'features/cards/controller/controller.dart';

class QuizWizApp extends StatelessWidget {
  final CardsBloc cardsBloc;
  final ThemeCubit themeCubit;
  const QuizWizApp({
    Key? key,
    required this.cardsBloc,
    required this.themeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => cardsBloc,
        ),
        BlocProvider(create: (_) => themeCubit)
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: context.watch<ThemeCubit>().state,
            onGenerateRoute: (settings) =>
                RouteGenerator.generateRoute(settings),
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            home: const HomeScreen());
      }),
    );
  }
}
