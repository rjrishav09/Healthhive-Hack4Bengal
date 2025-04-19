import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbh/Screens/GeminiChatScreen.dart';

import '../Forms/Form.dart';
import '../OthersScreens/AccountScreen.dart';
import '../OthersScreens/ChatScreen.dart';
import '../OthersScreens/MyAdScreen.dart';
import '../Setting Page/setting_screen.dart';
import 'ChatGPTScreen.dart';
import 'HomeScreen.dart';


class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget _currentScreen = HomeScreen();
  int _index = 0;
  final PageStorageBucket _bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {

    Color color = Theme.of(context).primaryColor;

    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: _bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: (){
          //this button is to make add products for seller
          //so it will open first category screen to select the screen,
          //where item belongs to
          Navigator.pushNamed(context, SellerBookForm.id);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 0;
                        _currentScreen = HomeScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==0 ? Icons.home: Icons.home_outlined),
                        Text('Home',style: TextStyle(color: _index == 0 ? color: Colors.black,
                          fontWeight: _index == 0? FontWeight.bold:FontWeight.normal,
                          fontSize: 12,

                        )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 1;
                        _currentScreen = ChatScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==1 ? CupertinoIcons.search_circle_fill:CupertinoIcons.search_circle),
                        Text('Search',style: TextStyle(color: _index == 1 ? color: Colors.black,
                          fontWeight: _index == 1? FontWeight.bold:FontWeight.normal,
                          fontSize: 12,

                        )),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 2;
                        _currentScreen = ChatGptScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==2 ? CupertinoIcons.question_circle_fill:CupertinoIcons.question_circle),
                        Text('AI Bot',style: TextStyle(color: _index == 2 ? color: Colors.black,
                          fontWeight: _index == 2? FontWeight.bold:FontWeight.normal,
                          fontSize: 12,

                        )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 3;
                        _currentScreen =MyAdScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==3 ? CupertinoIcons.person_fill:CupertinoIcons.person),
                        Text('Plan',style: TextStyle(color: _index == 3 ? color: Colors.black,
                          fontWeight: _index == 3? FontWeight.bold:FontWeight.normal,
                          fontSize: 12,

                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
