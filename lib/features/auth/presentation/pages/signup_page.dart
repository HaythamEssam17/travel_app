import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/widgets/alerts/common_waiting_dialog_widget.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/helpers/icon_paths.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/widgets/alerts/custom_snack_bar.dart';
import '../../../../core/widgets/common_global_button.dart';
import '../../../../core/widgets/common_title_text.dart';
import '../../../../core/widgets/form_input_widgets/email_form_widget.dart';
import '../../../../core/widgets/form_input_widgets/password_form_widget.dart';
import '../../../../core/widgets/image_widgets/common_asset_image_widget.dart';
import '../blocs/signup_cubit/signup_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (_) => getIt<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        builder: (context, state) {
          final cubit = context.watch<SignupCubit>();

          return AppScaffoldPage(
            body: SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonAssetImageWidget(
                        imageString: IconPaths.logoIconPNG,
                        height: 100,
                        width: 100,
                        radius: 12,
                      ),
                      getSpaceHeight(16),
                      CommonTitleText(textKey: 'Welcome to th app'),
                      getSpaceHeight(8),
                      Row(
                        children: [
                          CommonTitleText(
                            textKey: 'Sign Up',
                            textStyle: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      getSpaceHeight(16),
                      EmailFormWidget(
                        emailController: cubit.signupForm.emailController,
                        emailOnChanged: (value) {
                          cubit.validateForm(
                            value!,
                            cubit.signupForm.passwordController.text,
                          );
                          return value;
                        },
                      ),
                      getSpaceHeight(16),
                      PasswordFormWidget(
                        passwordController: cubit.signupForm.passwordController,
                        passwordOnChanged: (value) {
                          cubit.validateForm(
                            cubit.signupForm.emailController.text,
                            value!,
                          );
                          return value;
                        },
                      ),
                      getSpaceHeight(16),
                      CommonGlobalButton(
                        buttonText: 'Signup',
                        onPressedFunction: () {},
                        isEnable: state is SignupButtonEnabled,
                      ),

                      getSpaceHeight(30),
                      CommonTitleText.rich(
                        TextSpan(
                          text: 'Login here',
                          style: TextStyle(
                            color: context.appColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.go('/login');
                            },
                        ),
                        textKey: 'already have an account? ',
                      ),
                      getSpaceHeight(16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SignupLoading) {
            showWaitingDialog(context);
          } else if (state is SignupSuccess) {
            int count = 0;
            Navigator.of(context).popUntil((route) {
              return count++ == 1;
            });
          } else if (state is SignupError) {
            router.pop();
            showSnackBar(context: context, title: state.message);
          }
        },
      ),
    );
  }
}
