import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());
  final themeKey = "theme_key";

  /// check previos selected theme
  /// by default is ThemeMode.light
  void checkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(themeKey) ?? "light";

    if (theme == ThemeMode.light.name) {
      emit(state.copyWith(ThemeMode.light));
    } else {
      emit(state.copyWith(ThemeMode.dark));
    }
  }

  /// chage theme base on selected Theme
  /// [ThemeMode.light] or [ThemeMode.dark]
  void changeTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themeKey, theme.name);
    emit(state.copyWith(theme));
  }
}
