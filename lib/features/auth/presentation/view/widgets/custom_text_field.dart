import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/functions/get_direction_based_on_text.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.label = '',
    this.hint,
    this.controller,
    this.validator,
    this.minLines = 3,
    this.keyboardType,
  });
  final String label;
  final String? hint;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  TextDirection textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Directionality(
        textDirection: textDirection,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.grey2, borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            validator: validator,
            autofocus: true,
            minLines: minLines, // يبدأ من 3 أسطر
            maxLines: null, // يسمح بزيادة عدد الأسطر مع الكتابة
            keyboardType: keyboardType,
            controller: controller,
            onChanged: (value) {
              setState(() {
                textDirection = getDirectionBasedOnText(value);
              });
            },
            decoration: InputDecoration(
              label: Text(label),
              hintTextDirection: TextDirection.rtl,
              hintText: hint ?? 'ادخل ملاحظتك',
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
      );
    });
  }
}
