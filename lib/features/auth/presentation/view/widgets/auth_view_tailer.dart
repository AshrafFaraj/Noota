import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

class AuthViewTailer extends StatelessWidget {
  const AuthViewTailer({
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
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}
