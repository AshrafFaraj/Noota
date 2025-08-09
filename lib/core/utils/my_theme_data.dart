import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData myTheme = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColor.primary),
        titleTextStyle: TextStyle(
            color: AppColor.primary,
            fontSize: 18,
            fontWeight: FontWeight.w500)));
