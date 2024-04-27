import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../screen/authenticate/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  int randomNum() {
    // Function to generate a random number
    return 1; // Change this to generate a random number between 1 and 9
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding/image${randomNum()}.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Logo and Text
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  // Logo Image
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/app_logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 10),
                  // Text
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Food',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Cap',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Text
            Positioned(
              top: 155,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  'Cook with Confidence',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ),
            // Sign up button
            Positioned(
              left: 20,
              right: 20,
              bottom: 150,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                label: Text(
                  'Sign up with email'.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            // Login button
            Positioned(
              left: 20,
              right: 20,
              bottom: 100,
              child: GestureDetector(
                onTap: () {
                  // Handle login button press
                },
                child: Text(
                  'Already have an account? Log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            // Terms of Use and Privacy Policy Text
            Positioned(
              left: 20,
              right: 20,
              bottom: 50,
              child: Text(
                'By using FoodCap, you agree to our Terms of Use and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
