import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/thems/app_thems.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'isDark';

  ThemeCubit() : super(LightThemeState(AppThemes.lightTheme)) {
    _loadTheme();
  }

  void toggleTheme() async {
    final isDark = state is DarkThemeState;
    final newTheme = isDark
        ? LightThemeState(AppThemes.lightTheme)
        : DarkThemeState(AppThemes.darkTheme);

    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, !isDark);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;

    if (isDark) {
      emit(DarkThemeState(AppThemes.darkTheme));
    } else {
      emit(LightThemeState(AppThemes.lightTheme));
    }
  }
}
