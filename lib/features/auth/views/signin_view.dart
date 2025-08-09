import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/utils/app_color.dart';

import 'widgets/auth_subtitle.dart';
import 'widgets/auth_title.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/dont_have.dart';
import 'widgets/logo.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (credential.user!.emailVerified) {
        Navigator.of(context).pushReplacementNamed('home');
      } else {
        showDialog(
            barrierLabel: 'No',
            context: context,
            builder: (context) {
              return AlertDialog(title: Text('Verfiy your email to contitue'));
            });
      }
      print('تم تسجيل الدخول: ${credential.user?.email}');
    } on FirebaseAuthException catch (e) {
      print('**********خطأ: ${e.code} - ${e.message}');
    }
  }

  Future<void> forgetPassword() async {
    if (emailController.text.isEmpty) {
      showDialog(
          barrierLabel: 'No',
          context: context,
          builder: (context) {
            return AlertDialog(title: Text('قم بكتابة بريدك الالكتروني'));
          });
    }
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      showDialog(
          barrierLabel: 'No',
          context: context,
          builder: (context) {
            return AlertDialog(title: Text('تم ارسال رابط اعادة التعيين'));
          });
    } on FirebaseException catch (_) {
      showDialog(
          barrierLabel: 'No',
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text('حدث خطأ لم يتم ارسال رابط اعادة التعيين'));
          });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(children: [
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
              AuthTitle(title: 'Login'),
              SizedBox(
                height: 15,
              ),
              AuthSubTitle(
                subTitle: "login to continue using the app",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                hint: 'enter your email',
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
                height: 15,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: forgetPassword,
                    child: Text(
                      'Forget Password?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                onPressed: _signIn,
                title: 'Login',
                color: AppColor.primary,
              ),
              SizedBox(
                height: 30,
              ),
              LoginWithGoogle(
                  color: AppColor.secondColor, title: 'Login With Google'),
              SizedBox(
                height: 40,
              ),
              DontHave(
                pageName: 'signup',
                quetion: "Don't Have account?",
                actionTitle: 'register',
              )
            ],
          ),
        ]),
      ),
    );
  }
}
