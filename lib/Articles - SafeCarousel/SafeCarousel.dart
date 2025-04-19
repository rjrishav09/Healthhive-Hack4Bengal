import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'ArticlesDesc.dart';
import 'SadeWebView.dart';


class SafeCarousel extends StatelessWidget {
  const SafeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: List.generate(
            imageSliders.length,
                (index) => Hero(
              tag: articleTitle[index],
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    // WebviewScaffold(
                    //   url: "https://www.google.com",
                    //   appBar: new AppBar(
                    //     title: new Text("Widget webview"),
                    //   ),
                    // ),
                    if (index == 0) {
                      navigateToRoute(
                          context,
                          SafeWebView(
                              index: index,
                              title:
                              "Innovation in Healthcare Practice",
                              url:
                              "https://www.bloodcenter.org/advancing-medicine/"));
                    } else if (index == 1) {
                      navigateToRoute(
                          context,
                          SafeWebView(
                              index: index,
                              title: "Medical Pioneers of Tomorrow",
                              url:
                              "https://www.bbc.co.uk/bitesize/articles/zr4fvwx#zdb76rd"));
                    } else if (index == 2) {
                      navigateToRoute(context, ArticleDesc(index: index, key: null!,));
                    } else {
                      navigateToRoute(
                          context,
                          SafeWebView(
                              index: index,
                              title: "Advancing Medicine for All",
                              url:
                              "https://corp.oup.com/news/advancing-medicine-and-healthcare-with-research-connections/"));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(imageSliders[index]),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            articleTitle[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery.of(context).size.width *
                                    0.05,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void navigateToRoute(
      BuildContext context,
      Widget route,
      ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }
}