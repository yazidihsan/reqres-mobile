import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_button.dart';
import 'package:reqres/common_widget/custom_input.dart';
import 'package:reqres/common_widget/custom_loading_button.dart';
import 'package:reqres/common_widget/gradient_icon_button.dart';
import 'package:reqres/features/auth/presentation/cubit/register_cubit.dart';
import 'package:reqres/features/auth/widget/bottom_text.dart';
import 'package:reqres/features/auth/widget/title_page.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:reqres/theme_manager/value_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();
late RegisterCubit _registerCubit;

late TextEditingController _emailController;
late TextEditingController _usernameController;
late TextEditingController _passwordController;
late TextEditingController _passwordConfirmController;

bool isVisible1 = false;
bool isVisible2 = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();

    _registerCubit = sl<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => _registerCubit,
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterFailed) {
                String message = state.message;

                if (message.isNotEmpty) {
                  ValueManager.customToast(message);
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
                        CustomAppbar(
                          title: "Back",
                          leftIcon: Icons.arrow_back_ios,
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                        ),
                        60.0.spaceY,
                        const TitlePage(title: "Register"),
                        25.0.spaceY,
                        CustomInput(
                          hintText: "Enter Email",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }
                            if (value.isEmpty) {
                              return "*Enter your email address";
                            }
                            return null;
                          },
                        ),
                        15.0.spaceY,
                        CustomInput(
                          hintText: "Create Username",
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }
                            if (value.isEmpty) {
                              return "*Create your username";
                            }
                            return null;
                          },
                        ),
                        15.0.spaceY,
                        CustomInput(
                          hintText: "Create Password",
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !isVisible1,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }
                            if (value.isEmpty) {
                              return "*Create your password";
                            }
                            return null;
                          },
                          suffixIcon: GradientIconButton(
                              icon: isVisible1 == true
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 30,
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    ColorManager.golden1,
                                    ColorManager.golden2,
                                    ColorManager.golden3,
                                    ColorManager.golden4,
                                    ColorManager.golden5,
                                    ColorManager.golden6,
                                    ColorManager.golden7,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              onPressed: () {
                                setState(() {
                                  isVisible1 = !isVisible1;
                                });
                              }),
                        ),
                        15.0.spaceY,
                        CustomInput(
                          hintText: "Confirm Password",
                          controller: _passwordConfirmController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !isVisible2,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }
                            if (value.isEmpty) {
                              return "*Create your confirmation password";
                            }
                            return null;
                          },
                          suffixIcon: GradientIconButton(
                              icon: isVisible2 == true
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 30,
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    ColorManager.golden1,
                                    ColorManager.golden2,
                                    ColorManager.golden3,
                                    ColorManager.golden4,
                                    ColorManager.golden5,
                                    ColorManager.golden6,
                                    ColorManager.golden7,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              onPressed: () {
                                setState(() {
                                  isVisible2 = !isVisible2;
                                });
                              }),
                        ),
                        25.0.spaceY,
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return const CustomLoadingButton();
                            }
                            return CustomButton(
                                onPressed: () {
                                  if ((_formKey.currentState ?? FormState())
                                      .validate()) {
                                    if (_passwordController.text ==
                                        _passwordConfirmController.text) {
                                      _registerCubit.startRegister(
                                          _emailController.text,
                                          _usernameController.text,
                                          _passwordController.text);
                                    } else {
                                      ValueManager.customToast(
                                          "Password Confirmation has not match yet");
                                    }
                                  }
                                  if (state is RegisterSuccess) {
                                    String message = state.message;
                                    if (message.isNotEmpty) {
                                      if (message == "User already exists") {
                                        return;
                                      }
                                      ValueManager.customToast(message);
                                    }
                                  }
                                },
                                text: "Register",
                                textColor: ColorManager.white);
                          },
                        ),
                        52.0.spaceY,
                        BottomText(
                            txtPrimary: "Have an account?",
                            txtSecondary: "Login here",
                            onPressed: () {
                              GoRouter.of(context).goNamed("login");
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
