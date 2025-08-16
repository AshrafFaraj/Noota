import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sign_in_form.dart';
import '/core/constants/app_route_name.dart';
import '../widgets/auth_view_header.dart';
import '/features/auth/presentation/manager/cubit_auth/auth_cubit.dart';
import '/core/utils/app_color.dart';
import '../widgets/auth_view_tailer.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccess) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.home, (route) => false);
      } else if (state is AuthFailure) {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: state.errMessage)
            .show();
      }
    }, builder: (context, state) {
      var cubit = BlocProvider.of<AuthCubit>(context);
      return Stack(children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthViewHeader(
                      title: 'Login',
                      subTitle: "login to continue using the app"),
                  SignInForm(
                      formState: formState,
                      emailController: emailController,
                      passwordController: passwordController,
                      cubit: cubit),
                  SizedBox(
                    height: 40,
                  ),
                  AuthViewTailer(
                    pageName: 'signup',
                    quetion: "Don't Have account?",
                    actionTitle: 'Register',
                  )
                ],
              ),
            ]),
          ),
        ),
        state is AuthLoading
            ? Positioned(
                child: Container(
                color: AppColors.black.withValues(alpha: 0.5),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : SizedBox(),
      ]);
    }));
  }
}
