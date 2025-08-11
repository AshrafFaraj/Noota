import 'package:flutter/material.dart';

import 'auth_subtitle.dart';
import 'auth_title.dart';
import 'logo.dart';

class AuthViewHeader extends StatelessWidget {
  const AuthViewHeader(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Logo(),
        SizedBox(
          height: 30,
        ),
        AuthTitle(title: title),
        SizedBox(
          height: 15,
        ),
        AuthSubTitle(
          subTitle: subTitle,
        ),
      ],
    );
  }
}
