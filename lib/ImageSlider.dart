import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  static const String id = 'ImageSlider-screen';
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;
  List<String> images = [
    "https://1000logos.net/wp-content/uploads/2017/02/Instagram-Logo.png",
    "https://brandmark.io/logo-rank/random/pepsi.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI-h-e2hgz8mwGfCt4gvj4IgMG_wAUolVM6w&usqp=CAU"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Image"),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150,
              width: double.infinity,
              child: PageView.builder(
                  onPageChanged: (index){
                    setState(() {
                      currentIndex = index % images.length;
                    });
                  },
                  itemBuilder: (context ,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: CircleAvatar(
                          child: Image.network(images[index % images.length],
                            fit: BoxFit.cover,),
                        ),
                      ),
                    );
                  }
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i<images.length; i++)buildIdicator(currentIndex == i)
              ],
            ),
            Divider(height: 1,thickness: 1,)
          ],
        ),
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
