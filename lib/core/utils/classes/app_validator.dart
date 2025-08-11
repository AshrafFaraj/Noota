class AppValidator {
  /// تحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  /// تحقق من كلمة المرور
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر';
    }
    return null;
  }

  /// تحقق من الحقول العامة (مثل اسم التصنيف)
  static String? requiredField(String? value, {String fieldName = 'الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال $fieldName';
    }
    return null;
  }
}
