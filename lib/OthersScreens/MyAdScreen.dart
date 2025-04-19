import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAdScreen extends StatefulWidget {
  static const String id = 'ads-screen';

  @override
  _MyAdScreenState createState() => _MyAdScreenState();
}

class _MyAdScreenState extends State<MyAdScreen> {
  TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? diseaseData;

  Future<void> loadDiseaseInfo(String diseaseName) async {
    final String response =
    await rootBundle.loadString('assets/diet_plan.json');
    final data = await json.decode(response);

    final diseases = data['diseases'] as List<dynamic>;

    final matched = diseases.firstWhere(
          (d) => d['name'].toLowerCase() == diseaseName.toLowerCase(),
      orElse: () => null,
    );

    setState(() {
      diseaseData = matched;
    });
  }

  // Extracts the average treatment time in months from a string like "3-6 months"
  double? getAverageTreatmentMonths(String timeText) {
    final match = RegExp(r'(\d+)-(\d+)').firstMatch(timeText);
    if (match != null) {
      final min = int.tryParse(match.group(1)!);
      final max = int.tryParse(match.group(2)!);
      if (min != null && max != null) {
        return (min + max) / 2;
      }
    }
    return null; // If not in a parseable range format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Disease Diet Planner")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  labelText: "Enter a disease",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        loadDiseaseInfo(_controller.text.trim());
                      })),
            ),
            SizedBox(height: 20),
            diseaseData != null
                ? Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Disease: ${diseaseData!['name']}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Estimated Treatment Time:"),
                    Text(diseaseData!['treatment_time']),
                    SizedBox(height: 10),
                    if (getAverageTreatmentMonths(
                        diseaseData!['treatment_time']) !=
                        null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Visual Representation:"),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: getAverageTreatmentMonths(
                                diseaseData!['treatment_time'])! /
                                12, // assuming 12 months max scale
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent),
                          ),
                          SizedBox(height: 5),
                          Text(
                              "${getAverageTreatmentMonths(diseaseData!['treatment_time'])!.toStringAsFixed(1)} months out of 12"),
                        ],
                      )
                    else
                      Text(
                          "No graphical data available for variable duration."),
                    SizedBox(height: 20),
                    Text("Diet Recommendations:"),
                    ...List.generate(
                        diseaseData!['diet'].length,
                            (i) =>
                            Text("- ${diseaseData!['diet'][i]}")),
                    SizedBox(height: 10),
                    Text("Prescribed Medicines:"),
                    ...List.generate(
                        diseaseData!['medicine'].length,
                            (i) =>
                            Text("• ${diseaseData!['medicine'][i]}")),
                  ],
                ),
              ),
            )
                : Text("Enter a disease name to see details."),
          ],
        ),
      ),
    );
  }
}
