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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool isVisible = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                  const CustomAppbar(
                    title: "Back",
                    leftIcon: Icons.arrow_back_ios,
                  ),
                  60.0.spaceY,
                  const TitlePage(title: "Login"),
                  25.0.spaceY,
                  CustomInput(
                    hintText: "Enter Username/Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  15.0.spaceY,
                  CustomInput(
                      hintText: "Enter Password",
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isVisible,
                      suffixIcon: GradientIconButton(
                        icon: isVisible == true
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
                          end: Alignment.centerRight,
                        ),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      )),
                  25.0.spaceY,
                  CustomButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed('profile');
                      },
                      text: "Login",
                      textColor: ColorManager.white),
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
    );
  }
}
