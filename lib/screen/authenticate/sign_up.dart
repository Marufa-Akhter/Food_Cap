import 'package:final_project/const_config/color_config.dart';
import 'package:final_project/const_config/text_config.dart';
import 'package:final_project/screen/home_screen.dart';
import 'package:final_project/screen/main_screen.dart';
import 'package:final_project/services/validators.dart';
import 'package:final_project/widgets/custom_buttons/round_action_button.dart';
import 'package:final_project/widgets/input_widget/password_input_field.dart';
import 'package:final_project/widgets/input_widget/simple_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:final_project/screen/chat/dashbord.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final passwordController = TextEditingController();
  final List<Widget> randomAvatar = [];

  @override
  void initState() {
    super.initState();
    usernameController.text = "put your name";
    onUserNameChange();
  }

  void onUserNameChange() {
    randomAvatar.add(
      RandomAvatar(
        usernameController.text,
        trBackground: false,
        height: 100,
        width: 100,
      ),
    );
    setState(() {});
  }

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
            child: ListView(
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
                  height: size.height * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: randomAvatar.last,
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
                        controller: usernameController,
                        backgroundColor: MyColor.scaffoldColor,
                        hintText: "Enter your user name",
                        needValidation: true,
                        errorMessage: "Please enter an user name",
                        fieldTitle: "User name",
                        validatorClass: ValidatorClass().validateUserName,
                        onValueChange: (value) {
                          onUserNameChange();
                        },
                      ),
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 35),
                      RoundedActionButton(
                        onClick: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            auth
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              if (value.user != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        width: size.width * 0.8,
                        label: "Sign Up",
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextDesign().bodyTextSmall.copyWith(
                              color: MyColor.disabled,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                    (route) => false,
                              );
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                "Login Now!",
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
    );
  }
}
