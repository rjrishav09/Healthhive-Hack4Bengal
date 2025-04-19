import 'dart:math';
import 'package:flutter/material.dart';

import '../Articles - SafeCarousel/AllArticles.dart';
import '../Articles - SafeCarousel/SafeCarousel.dart';
import '../Dashwidgets/DashAppbar.dart';
import '../Dashwidgets/Emergencybar.dart';
import '../Dashwidgets/LiveSafe.dart';
import '../Dashwidgets/SafeHome.dart';
import '../Screens/BannerScreen.dart';


class Home extends StatefulWidget {
  static const String id = 'Home-screen';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(12,5,12,8),
        child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  BannerWidget(),
                  SizedBox(height: 20,),
                  Divider(height: 1,thickness: 2,),
                  SizedBox(height: 10,),
                  Text("Apna Kavach Is Always For Your Help"),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}