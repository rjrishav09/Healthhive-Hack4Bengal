import 'package:flutter/material.dart';

import 'Forms/Form.dart';
import 'Login Page/LoginForm.dart';
import 'OthersScreens/AccountScreen.dart';
import 'Screens/ChatGPTScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/MainScreen.dart';
import 'Screens/SplashScreen.dart';
import 'Setting Page/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthhive',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          LoginScreen.id:(context) =>LoginScreen(),
          HomeScreen.id: (context) =>HomeScreen(),
          ChatGptScreen.id: (context) => ChatGptScreen(),
          MainScreen.id: (context) => MainScreen(),
          Home.id:(context) => Home(),
          SellerBookForm.id:(context) => SellerBookForm(),
          SettingsScreen.id:(context) => SettingsScreen(),

        }
    );
  }
}
