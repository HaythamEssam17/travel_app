import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/app/router/app_router.dart';
import 'package:travel_app/app/router/route_names.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/helper_methods.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';
import 'package:travel_app/core/widgets/alerts/custom_snack_bar.dart';
import 'package:travel_app/core/widgets/common_global_button.dart';
import 'package:travel_app/core/widgets/common_title_text.dart';
import 'package:travel_app/core/widgets/form_input_widgets/email_form_widget.dart';
import 'package:travel_app/core/widgets/form_input_widgets/password_form_widget.dart';
import 'package:travel_app/features/auth/presentation/blocs/login_cubit/login_cubit.dart';

import '../../../../core/helpers/icon_paths.dart';
import '../../../../core/widgets/image_widgets/common_asset_image_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => getIt<LoginCubit>(),

      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          final cubit = context.watch<LoginCubit>();

          return AppScaffoldPage(
            body: SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: Form(
                key: cubit.globalKey,
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
                            textKey: 'Login',
                            textStyle: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      getSpaceHeight(16),
                      EmailFormWidget(
                        emailController: cubit.loginForm.emailController,
                        emailOnChanged: (value) {
                          cubit.validateForm(
                            value!,
                            cubit.loginForm.passwordController.text,
                          );
                          return value;
                        },
                      ),
                      getSpaceHeight(16),
                      PasswordFormWidget(
                        passwordController: cubit.loginForm.passwordController,
                        passwordOnChanged: (value) {
                          cubit.validateForm(
                            cubit.loginForm.emailController.text,
                            value!,
                          );
                          return value;
                        },
                      ),
                      getSpaceHeight(16),
                      CommonGlobalButton(
                        buttonText: 'Login',
                        onPressedFunction: () {
                          if (cubit.globalKey.currentState!.validate()) {
                            cubit.loginMockData();
                          }
                        },
                        // isEnable: state is LoginButtonEnabled,
                        // isLoading: state is LoginLoading,
                      ),

                      getSpaceHeight(30),
                      CommonTitleText.rich(
                        TextSpan(
                          text: 'Sign up now',
                          style: TextStyle(
                            color: context.appColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.go(RouteNames.signup);
                            },
                        ),
                        textKey: 'Don\'t have an account? ',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (SharedText.user?.role == 'B2C') {
              router.pushReplacementNamed(RouteNames.consumerHomePage);
            } else {
              router.pushReplacementNamed(RouteNames.consumerHomePage);
            }
          } else if (state is LoginError) {
            showSnackBar(context: context, title: state.message);
          }
        },
      ),
    );
  }
}
