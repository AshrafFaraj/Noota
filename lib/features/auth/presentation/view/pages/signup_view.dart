import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/sign_up_form.dart';
import '/features/auth/presentation/view/widgets/auth_view_header.dart';
import '../../../../../core/constants/app_route_name.dart';
import '../../../../../core/utils/app_color.dart';
import '../../manager/cubit_auth/auth_cubit.dart';
import '../widgets/auth_view_tailer.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccess) {
        Navigator.pushReplacementNamed(context, AppRouteName.signIn);
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
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthViewHeader(
                        title: 'Register',
                        subTitle: "Enter your personal information"),
                    SizedBox(
                      height: 20,
                    ),
                    SignUpForm(
                        formState: formState,
                        emailController: emailController,
                        passwordController: passwordController,
                        cubit: cubit),
                    SizedBox(
                      height: 20,
                    ),
                    AuthViewTailer(
                      pageName: 'signin',
                      quetion: "Have an account?",
                      actionTitle: 'Login',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        state is AuthLoading
            ? Positioned(
                child: Container(
                color: AppColor.black.withValues(alpha: 0.5),
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
