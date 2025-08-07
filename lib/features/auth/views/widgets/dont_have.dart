import 'package:flutter/material.dart';

import '../../../../app_color.dart';

class DontHave extends StatelessWidget {
  const DontHave({
    super.key,
    required this.quetion,
    required this.actionTitle,
    required this.pageName,
  });
  final String quetion;
  final String actionTitle;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(quetion),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(pageName);
            },
            child: Text(
              actionTitle,
              style: TextStyle(
                  color: AppColor.primary, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
