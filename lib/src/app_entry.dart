import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/theme/cubit/theme_cubit.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

import 'features/cards/controller/controller.dart';

class QuizWizApp extends StatelessWidget {
  const QuizWizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CardsBloc>()..add(const GetCollectionsEvent()),
        ),
        BlocProvider(create: (_) => ThemeCubit())
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
