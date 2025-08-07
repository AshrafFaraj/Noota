import 'package:flutter/material.dart';

import '../../../../app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
  });
  final String label;
  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 2),
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
            color: AppColor.grey2, borderRadius: BorderRadius.circular(50)),
        child: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
              label: Text(
                label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              hintText: hint,
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ));
  }
}
