import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/app_color.dart';
import 'widgets/auth_subtitle.dart';
import 'widgets/auth_title.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/dont_have.dart';
import 'widgets/logo.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey();

  Future<void> _signUp() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      credential.user!.sendEmailVerification();
      Navigator.of(context).pushReplacementNamed('signin');
      print('==========تم إنشاء حساب: ${credential.user?.email}');
    } on FirebaseAuthException catch (e) {
      print('==========خطأ: ${e.code} - ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Logo(),
                SizedBox(
                  height: 30,
                ),
                AuthTitle(title: 'Register'),
                SizedBox(
                  height: 15,
                ),
                AuthSubTitle(
                  subTitle: "Enter your personal information",
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: formState,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'enter your Username',
                          label: 'Username',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hint: 'enter your Email',
                          label: 'Email',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hint: 'enter your password',
                          label: 'Password',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          hint: 'enter Confirm Password',
                          label: 'Confirm Password',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          onPressed: _signUp,
                          title: 'Register',
                          color: AppColor.primary,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                DontHave(
                  pageName: 'signin',
                  quetion: "Have an account?",
                  actionTitle: 'Login',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
