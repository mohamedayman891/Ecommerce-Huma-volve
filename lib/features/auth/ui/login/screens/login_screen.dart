import 'package:ecommerce_app_huma_volve/core/di/di.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/helper_function.dart';
import 'package:ecommerce_app_huma_volve/features/auth/ui/login/cubit/login_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/ui/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/utils/theme.dart';
import '../../../../main_navigation/screens/main_navigation_screen.dart';
import '../../sign_up/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  LoginCubit cubit = getIt();
  @override
  void initState() {
    emailController = TextEditingController(text: "mohamed2810@gmail.com");
    passwordController = TextEditingController(text: "28102005");

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.loginApi.isSuccess) {
          showFlutterToast('success', AppTheme.green);
        } else if (state.loginApi.isError) {
          showFlutterToast(state.loginApi.errorMessage, AppTheme.accent);
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  Icon(Icons.shopping_bag, size: 80, color: AppTheme.primary),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome Back!',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to continue your shopping',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildLoginButton(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SignUpScreen(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: cubit,
      builder: (context, state) {
        return PrimaryButton(
          text: 'Login',
          isLoading: state.loginApi.isLoading,
          onPressed: () {
            cubit.login(emailController.text, passwordController.text);
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainNavigationScreen()),
              );
            }
          },
        );
      },
    );
  }
}
