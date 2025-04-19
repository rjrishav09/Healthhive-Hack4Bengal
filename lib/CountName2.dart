import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CountName2 extends StatefulWidget {
  static const String id = 'CountName1-screen';
  const CountName2({Key? key}) : super(key: key);

  @override
  State<CountName2> createState() => _CountName2State();
}

class _CountName2State extends State<CountName2> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: 'https',
      host: 'whjr.co',
      path: '9yMr3',
    );
    if (!await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: WebViewConfiguration(enableJavaScript: true,enableDomStorage: true)
    ))
    {
      throw ('Could not launch $uri');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.white,
      child: ListView.builder(itemBuilder: (context,index)=>
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: ListTile(
              hoverColor: Colors.pink,
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              title: Text("Python"),
              subtitle: Text("Programming Language"),
              trailing:Icon(Icons.arrow_forward_ios,color: Colors.blue,),
              textColor: Colors.green,
              onTap: (){_launchUrl("www.code.whitehatjr.com");},
            ),
          ),
          itemCount:1,scrollDirection:Axis.vertical
      ),

    );
  }

  Widget buildIdicator(bool isSelected){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12:8,
        width: isSelected ? 12:8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
