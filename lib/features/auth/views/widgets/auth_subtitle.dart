import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class AuthSubTitle extends StatelessWidget {
  const AuthSubTitle({
    super.key,
    required this.subTitle,
  });
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, color: AppColor.grey),
    );
  }
}
