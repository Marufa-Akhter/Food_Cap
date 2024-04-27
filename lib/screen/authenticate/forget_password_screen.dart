import 'package:flutter/material.dart';
import 'package:final_project/const_config/color_config.dart';
import 'package:final_project/const_config/text_config.dart';
import 'package:final_project/widgets/custom_buttons/round_action_button.dart';
import 'error_screen.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Forgot Password?",
                    style: TextDesign().dashboardWidgetTitle,
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
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        RoundedActionButton(
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              // Process forget password logic here
                              // For example, send a reset password link to the provided email

                              // For demonstration, assume email is invalid
                              String errorMessage = "Invalid email address provided";
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ErrorScreen(errorMessage: errorMessage),
                              ));
                            }
                          },
                          width: size.width * 0.8,
                          label: "Submit",
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
