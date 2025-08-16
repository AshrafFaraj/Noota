import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData myTheme = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w500)));
