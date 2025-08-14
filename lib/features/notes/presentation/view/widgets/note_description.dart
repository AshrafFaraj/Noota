import 'package:flutter/material.dart';

class NoteDescreption extends StatelessWidget {
  const NoteDescreption({
    super.key,
    required this.desc,
  });
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      desc,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }
}
