import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Articles - SafeCarousel/AllArticles.dart';
import '../Articles - SafeCarousel/SafeCarousel.dart';
import '../Dashwidgets/DashAppbar.dart';
import '../Dashwidgets/Emergencybar.dart';
import '../Dashwidgets/LiveSafe.dart';
import '../Dashwidgets/SafeHome.dart';
import 'BannerScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class HomeScreen extends StatefulWidget {
  static const String id = 'Home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
String address = "Bihar";
class _HomeScreenState extends State<HomeScreen> {



  int quoteIndex = 0;
  @override

  double? lat;
  double? long;
  String address = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude,value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  getAddress(lat,long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
    setState(() {
      address = placemarks[0].locality! + " " + placemarks[0].subLocality! + " " + placemarks[0].administrativeArea!  + " " + placemarks[0].postalCode! + " " + placemarks[0].country!;
    });

    for(int i = 0 ; i < placemarks.length; i++) {
      print ("INDEX $i ${placemarks[i]}");
    }
  }

  void initState() {
    super.initState();
    getRandomInt(false);
  }

  getRandomInt(fromClick) {
    Random rnd = Random();

    quoteIndex = rnd.nextInt(4);
    if (mounted && fromClick) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20,),
          child: DashAppbar(
            getRandomInt: getRandomInt,
            quoteIndex: quoteIndex,
          ),
        ),
        SizedBox(height: 0,),
        InkWell(
          onTap: () {
            getLatLong();
          },
          splashColor: Colors.blue, // Customize the splash color if desired
          highlightColor: Colors.blue,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5,left:10),
              child: Row(
                children: [
                  Icon(CupertinoIcons.location_solid, color: Colors.redAccent, size: 25,),
                  Text(
                    '$address...',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.green, size: 16,),
                ],
              ),
            ),
          ),
          // Add a hint text for the InkWell
        ),


        Expanded(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                  child: BannerWidget(),

                ),



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
                SafeCarousel(),

                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
                  child: Text(
                    "Search Your Symptoms!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SafeHome()
              ],
            ),
          ),
        ),
      ],
    );
  }
}



