import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:final_project/screen/authenticate/sign_up.dart';
import 'package:final_project/const_config/color_config.dart';
import 'package:final_project/src/features/welcome_screen/welcome_screen.dart';
import 'package:final_project/screen/recipe_screen.dart'; // Import RecipeScreen
import 'package:final_project/models/food.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Adding this line for fixing the app on portrait mode only.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Adding this line for disabling the system overlay color on top. so that our app scaffold color covers the hole screen
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a valid Food object
    Food defaultFood = Food(
      name: "Default Food",
      image: "assets/default_image.jpg",
      cal: 0,
      time: 0,
      rate: 0,
      reviews: 0,
      isLiked: false,
    );
    
    return MaterialApp(
      title: 'Food Cap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primary),
        useMaterial3: true,
      ),

      initialRoute: '/', // Define initial route
      routes: {
        '/': (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SignUp();
                } else {
                  return WelcomeScreen();
                }
              },
            ),
        '/recipe': (context) => RecipeScreen(food: defaultFood), // Add RecipeScreen route
      },

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const SignUp();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
