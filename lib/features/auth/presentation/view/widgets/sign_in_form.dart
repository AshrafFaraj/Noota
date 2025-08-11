import 'package:flutter/material.dart';
import 'package:note_app/features/auth/presentation/view/widgets/custom_button.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/classes/app_validator.dart';
import '../../manager/cubit_auth/auth_cubit.dart';
import 'custom_text_field.dart';
import 'space_widget.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
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
            validator: AppValidator.email,
            // height: 80,
            minLines: 1,
            controller: emailController,
            hint: 'ادخل بريدك الالكتروني',
            label: 'Email',
          ),
          const Space(),
          CustomTextField(
            validator: AppValidator.password,
            // height: 80,
            minLines: 1,
            controller: passwordController,
            hint: 'اكتب كلمة السر',
            label: 'Password',
          ),
          Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  cubit.forgetPassword(email: emailController.text);
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )),
          Space(),
          CustomButton(
            onPressed: () {
              if (formState.currentState!.validate()) {
                cubit.signIn(
                    email: emailController.text,
                    password: passwordController.text);
              }
            },
            title: 'Login',
            color: AppColor.primary,
          ),
          SizedBox(
            height: 30,
          ),
          LoginWithGoogle(
              color: AppColor.secondColor, title: 'Login With Google'),
        ],
      ),
    );
  }
}
