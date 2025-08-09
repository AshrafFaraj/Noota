import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/get_direction_based_on_text.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
  });
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  TextDirection textDirection = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColor.grey2, borderRadius: BorderRadius.circular(50)),
      child: StatefulBuilder(builder: (context, setState) {
        return Directionality(
          textDirection: textDirection,
          child: TextField(
            autofocus: true,
            minLines: 3, // يبدأ من 3 أسطر
            maxLines: null, // يسمح بزيادة عدد الأسطر مع الكتابة
            keyboardType: TextInputType.multiline,
            controller: controller,
            onChanged: (value) {
              setState(() {
                textDirection = getDirectionBasedOnText(value);
              });
            },
            decoration: InputDecoration(
                hintTextDirection: TextDirection.rtl,
                hintText: hint ?? 'ادخل ملاحظتك',
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        );
      }),
    );
  }
}
