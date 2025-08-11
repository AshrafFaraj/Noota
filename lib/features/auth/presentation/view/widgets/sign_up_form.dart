import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/classes/app_validator.dart';
import '../../manager/cubit_auth/auth_cubit.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';
import 'space_widget.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formState,
    required this.emailController,
    required this.passwordController,
    required this.cubit,
  });

  final GlobalKey<FormState> formState;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formState,
        child: Column(
          children: [
            CustomTextField(
              minLines: 1,
              hint: 'enter your Username',
              label: 'Username',
            ),
            Space(),
            CustomTextField(
              validator: AppValidator.email,
              minLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hint: 'enter your Email',
              label: 'Email',
            ),
            Space(),
            CustomTextField(
              validator: AppValidator.password,
              keyboardType: TextInputType.visiblePassword,
              minLines: 1,
              controller: passwordController,
              hint: 'enter your password',
              label: 'Password',
            ),
            Space(),
            CustomTextField(
              minLines: 1,
              hint: 'enter Confirm Password',
              label: 'Confirm Password',
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              onPressed: () {
                if (formState.currentState!.validate()) {
                  cubit.signUp(
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
              title: 'Register',
              color: AppColor.primary,
            ),
          ],
        ));
  }
}
