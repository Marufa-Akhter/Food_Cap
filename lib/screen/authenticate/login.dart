import 'package:flutter/material.dart';
import 'package:final_project/const_config/color_config.dart';
import 'package:final_project/const_config/text_config.dart';
import 'package:final_project/services/validators.dart';
import 'package:final_project/widgets/custom_buttons/round_action_button.dart';
import 'package:final_project/widgets/input_widget/password_input_field.dart';
import 'package:final_project/widgets/input_widget/simple_input_field.dart';
import '../main_screen.dart';
import 'forget_password_screen.dart';
import '../authenticate/sign_up.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Welcome to",
                    style: TextDesign().dashboardWidgetTitle,
                  ),
                  Text(
                    "Food Cap",
                    style: TextDesign().popHead.copyWith(
                      color: MyColor.primary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SimpleInputField(
                          controller: emailController,
                          backgroundColor: MyColor.scaffoldColor,
                          hintText: "Enter email",
                          needValidation: true,
                          errorMessage: "",
                          validatorClass: ValidatorClass().validateEmail,
                          fieldTitle: "Email",
                        ),
                        const SizedBox(height: 5),
                        PasswordInputField(
                          password: passwordController,
                          backgroundColor: MyColor.scaffoldColor,
                          fieldTitle: "Password",
                          hintText: "*******",
                        ),
                        const SizedBox(height: 20),
                        RoundedActionButton(
                          onClick: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            }
                          },
                          width: size.width * 0.8,
                          label: "Login Now",
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot your password?",
                              style: TextDesign().bodyTextSmall.copyWith(
                                color: MyColor.disabled,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgetPasswordPage(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  "Reset it now!",
                                  style: TextDesign().pageTitle.copyWith(
                                    color: MyColor.primary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
