import 'package:flutter/material.dart';

TextDirection getDirectionBasedOnText(String text) {
  if (text.isEmpty) return TextDirection.ltr;
  final firstChar = text.codeUnitAt(0);
  // الأكواد العربية في يونيكود تبدأ من 0x0600 إلى 0x06FF
  return (firstChar >= 0x0600 && firstChar <= 0x06FF)
      ? TextDirection.rtl
      : TextDirection.ltr;
}
