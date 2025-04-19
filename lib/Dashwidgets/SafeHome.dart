import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../OthersScreens/AccountScreen.dart';



class SafeHome extends StatefulWidget {
  const SafeHome({Key? key}) : super(key: key);

  @override
  _SafeHomeState createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  bool getHomeSafeActivated = false;
  List<String> numbers = [];

  checkGetHomeActivated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      getHomeSafeActivated = prefs.getBool("getHomeSafe") ?? false;
    });
  }

  changeStateOfHomeSafe(value) async {
    if (value) {
      Fluttertoast.showToast(msg: "Service Activated in Background!");
    } else {
      Fluttertoast.showToast(msg: "Service Disabled!");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      getHomeSafeActivated = value;
      prefs.setBool("getHomeSafe", value);
    });
  }

  @override
  void initState() {
    super.initState();

    checkGetHomeActivated();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: InkWell(
        onTap: () {
          showModelSafeHome(getHomeSafeActivated);
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 180,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        title: Text("Healthhive!"),
                        subtitle: Text("Search Your Symptoms"),
                      ),
                      Visibility(
                        visible: getHomeSafeActivated,
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                SpinKitDoubleBounce(
                                  color: Colors.red,
                                  size: 15,
                                ),
                                SizedBox(width: 15),
                                Text("Currently Running...",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 10)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/Legal.png",
                      height: 140,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  showModelSafeHome(bool processRunning) async {
    int selectedSymptomIndex = -1;
    bool getHomeActivated = processRunning;
    TextEditingController _symptomController = TextEditingController();
    List<String> userSymptoms = [];
    List<String> matchedDiseases = [];

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              Future<void> loadDiseasesAndMatchSymptoms() async {
                String jsonString = await rootBundle.loadString(
                    'assets/route.json');
                final jsonData = json.decode(jsonString);
                final List<dynamic> diseases = jsonData['diseases'];

                List<String> matches = [];

                for (var disease in diseases) {
                  final List<dynamic> symptoms = disease['symptoms'];
                  bool hasMatch = userSymptoms.any((symptom) =>
                      symptoms.map((s) => s.toLowerCase()).contains(
                          symptom.toLowerCase()));
                  if (hasMatch) {
                    matches.add(disease['name']);
                  }
                }

                setModalState(() {
                  matchedDiseases = matches;
                });
              }

              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(child: Divider(indent: 20, endIndent: 20)),
                          Text("Search Your Diseases!"),
                          Expanded(child: Divider(indent: 20, endIndent: 20)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF5F4F6)),
                      child: ListTile(
                        leading: Icon(
                            Icons.health_and_safety, color: Colors.blue),
                        title: TextField(
                          controller: _symptomController,
                          decoration: InputDecoration(
                            hintText: "Enter a symptom",
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            if (value
                                .trim()
                                .isNotEmpty) {
                              setModalState(() {
                                userSymptoms.add(value.trim());
                                _symptomController.clear();
                                loadDiseasesAndMatchSymptoms();
                              });
                            }
                          },
                        ),
                        subtitle: Text(
                            "Enter your symptoms to check for possible diseases"),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: userSymptoms.map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                    Expanded(
                        child: matchedDiseases.isNotEmpty
                            ? ListView.separated(
                            itemCount: matchedDiseases.length,
                            separatorBuilder: (context, index) =>
                                Divider(indent: 20, endIndent: 20),
                            itemBuilder: (context, index) {
                              String disease = matchedDiseases[index];
                              return ListTile(
                                leading: Icon(Icons.local_hospital),
                                title: Text(disease),
                                subtitle:
                                Text("Based on your entered symptoms"),
                              );
                            })
                            : Center(
                          child: Text(
                              "No disease matched yet. Add symptoms above."),
                        ))
                  ],
                ),
              );
            },
          );
        });
  }
}