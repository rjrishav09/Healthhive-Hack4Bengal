
import 'package:flutter/material.dart';


import '../Screens/MainScreen.dart';
import 'MyTrxtView.dart';
import 'SquareTitle.dart';
import 'TextButton.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'Login-screen';
  LoginScreen({Key? key}) : super(key: key);

  // text editting controller
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //logo
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: const Icon(
              Icons.lock,
              size: 100,
            ),
          ),
          SizedBox(height:35,),
          //welcome Back
          Text("Welcome back, you've been missed!",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),),
          const SizedBox(height: 15,),

          // UserNAme
          MyTextField(
            controller: usernamecontroller,
            hintText: 'Username',
            obscureText: false,
          ),
          SizedBox(height: 10,),
          // Password
          MyTextField(
            controller: passwordcontroller,
            hintText: 'password',
            obscureText: true,
          ),
          const SizedBox(height: 10,),
          //forget password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forget Password?"),
              ],
            ),
          ),
          const SizedBox(height: 25,),

          //sign in
          MyButton(onTap: () { Navigator.pushReplacementNamed(context, MainScreen.id); },),
          // orcontinue
          const SizedBox(height: 50,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Or continue with",
                  style: TextStyle(color: Colors.grey[700]),),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),)
            ],),
          ),

          const SizedBox(height: 10,),
          //google = apple sign in button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //google button
              SquareTile(imagePath: 'lib/images/google.png',),

              const SizedBox(width: 10,),
              //apple button
              SquareTile(imagePath: 'lib/images/apple.png')
            ],),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Not a member',style: TextStyle(color: Colors.grey[700]),),
              const SizedBox(width: 4,),
              Text('Register now',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            ],)

        ],),
    );
  }
}