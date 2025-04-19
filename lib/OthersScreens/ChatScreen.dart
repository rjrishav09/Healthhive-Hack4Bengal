import 'package:flutter/material.dart';

import '../Dashwidgets/LiveSafe.dart';
import '../Dashwidgets/SafeHome.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: SafeArea(
              child: BottomAppBar())),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12,8,12,8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: 'Find NGO And Hospitals',
                            labelStyle: TextStyle(fontSize: 12,),
                            contentPadding: EdgeInsets.only(left: 10,right: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications_none),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [




                  /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emergency",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllArticles(),
                        ),
                      );
                    },
                    child: Text("See More"),
                  ),
                ],
              ),
            ),

            Emergency(),*/

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
                    child: Text(
                      "Healthhive!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),

                  LiveSafe(),
                  //  SafeHome(),
                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
                    child: Text(
                      "Search Your Symptoms",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SafeHome()
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
