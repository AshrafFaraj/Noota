import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.title,
    this.onPressed,
  });
  final Color color;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 5),
        height: 50,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: color,
        child: Text(
          title,
          style: TextStyle(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({
    super.key,
    required this.color,
    required this.title,
    this.onPressed,
  });
  final Color color;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.secondColor, borderRadius: BorderRadius.circular(50)),
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 5),
        height: 50,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/google.png',
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
