import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: AppColors.grey, borderRadius: BorderRadius.circular(100)),
        child: Image.asset(
          'assets/images/notes.png',
          height: 70,
        ),
      ),
    );
  }
}
