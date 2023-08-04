import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);
  void toggleTheme() {
    return switch (state) {
      ThemeMode.dark => emit(ThemeMode.light),
      ThemeMode.light => emit(ThemeMode.dark),
      _ => emit(ThemeMode.dark)
    };
  }
}
