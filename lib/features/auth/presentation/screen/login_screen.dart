import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_button.dart';
import 'package:reqres/common_widget/custom_input.dart';
import 'package:reqres/common_widget/custom_loading_button.dart';
import 'package:reqres/common_widget/gradient_icon_button.dart';
import 'package:reqres/features/auth/presentation/cubit/login_cubit.dart';
import 'package:reqres/features/auth/widget/bottom_text.dart';
import 'package:reqres/features/auth/widget/title_page.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:reqres/theme_manager/value_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
late TextEditingController _mainController;
late TextEditingController _emailController;
late TextEditingController _usernameController;
late TextEditingController _passwordController;

late LoginCubit _loginCubit;

bool isVisible = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _mainController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _loginCubit = sl<LoginCubit>();

    _mainController.addListener(_updateController);
  }

  void _updateController() {
    final text = _mainController.text;

    if (text.contains('@')) {
      _emailController.value = _mainController.value;
    } else {
      _usernameController.value = _mainController.value;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _mainController.dispose();
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => _loginCubit,
            )
          ],
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is LoginFailed) {
                String message = state.message;

                if (message.isNotEmpty) {
                  // message.replaceAll(RegExp('\W+'), '[]');
                  // for (var item in messages) {
                  ValueManager.customToast(message);
                  // }
                }
              } else if (state is LoginSuccess) {
                String message = state.message;

                if (message.contains("Incorrect password")) {
                  ValueManager.customToast(message);
                } else {
                  GoRouter.of(context).pushReplacementNamed('profile');
                }
              }
            },
            child: CustomBackgroundPage(
              isPrimary: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 81, left: 23, right: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomAppbar(
                          title: "Back",
                          leftIcon: Icons.arrow_back_ios,
                        ),
                        60.0.spaceY,
                        const TitlePage(title: "Login"),
                        25.0.spaceY,
                        CustomInput(
                          hintText: "Enter Username/Email",
                          controller: _mainController,
                          // textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }

                            if (value.isEmpty) {
                              return '*Enter your email / username';
                            }

                            return null;
                          },
                        ),
                        15.0.spaceY,
                        CustomInput(
                            hintText: "Enter Password",
                            controller: _passwordController,
                            // textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !isVisible,
                            validator: (value) {
                              if (value == null) {
                                return null;
                              }

                              if (value.isEmpty) {
                                return '*Enter your password';
                              }

                              return null;
                            },
                            suffixIcon: GradientIconButton(
                              icon: isVisible == true
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 30,
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.golden1,
                                  ColorManager.golden2,
                                  ColorManager.golden3,
                                  ColorManager.golden4,
                                  ColorManager.golden5,
                                  ColorManager.golden6,
                                  ColorManager.golden7,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            )),
                        25.0.spaceY,
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const CustomLoadingButton();
                            }

                            return CustomButton(
                                onPressed: () {
                                  // if (_emailController.text.isEmpty ||
                                  //     _passwordController.text.isEmpty) {
                                  //   return;
                                  // }

                                  if ((_formKey.currentState ?? FormState())
                                      .validate()) {
                                    _loginCubit.startLogin(
                                        _emailController.text,
                                        _usernameController.text,
                                        _passwordController.text);
                                  }
                                },
                                text: "Login",
                                textColor: ColorManager.white);
                          },
                        ),
                        52.0.spaceY,
                        BottomText(
                            txtPrimary: "No Account?",
                            txtSecondary: "Register here",
                            onPressed: () {
                              GoRouter.of(context).goNamed("register");
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
