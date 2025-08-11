import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({this.height, super.key});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 10,
    );
  }
}
