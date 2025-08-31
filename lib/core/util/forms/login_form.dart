import 'package:flutter/material.dart';

class LoginForm {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }
}
