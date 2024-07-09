import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_button.dart';
import 'package:reqres/common_widget/custom_input.dart';
import 'package:reqres/common_widget/gradient_icon_button.dart';
import 'package:reqres/features/auth/widget/bottom_text.dart';
import 'package:reqres/features/auth/widget/title_page.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordConfirmController = TextEditingController();

bool isVisible1 = false;
bool isVisible2 = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomBackgroundPage(
          isPrimary: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 81, left: 23, right: 25),
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  15.0.spaceY,
                  CustomInput(
                    hintText: "Create Username",
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                  ),
                  15.0.spaceY,
                  CustomInput(
                    hintText: "Create Password",
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isVisible1,
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
                    controller: passwordConfirmController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isVisible2,
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
                  CustomButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed("profile");
                      },
                      text: "Register",
                      textColor: ColorManager.white),
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
    );
  }
}
