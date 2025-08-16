import 'package:flutter/material.dart';

abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState(this.themeData);
}

class LightThemeState extends ThemeState {
  const LightThemeState(ThemeData theme) : super(theme);
}

class DarkThemeState extends ThemeState {
  const DarkThemeState(ThemeData theme) : super(theme);
}
