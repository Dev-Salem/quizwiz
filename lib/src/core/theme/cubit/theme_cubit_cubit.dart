import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);
  void toggleTheme() {
    switch (state) {
      case ThemeMode.dark:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.dark);
      default:
        emit(ThemeMode.dark);
    }
  }
}
