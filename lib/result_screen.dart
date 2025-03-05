import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  final bool readmissionRequired;

  const ResultScreen({super.key, required this.readmissionRequired});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, String> patientDetails;

  @override
  void initState() {
    super.initState();
    patientDetails = generatePatientDetails();
  }

  Map<String, String> generatePatientDetails() {
    Random random = Random();
    return {
      "Blood Urea Nitrogen": "${random.nextInt(30) + 10} mg/dL",
      "Creatinine":
          "${(random.nextDouble() * 1.5 + 0.5).toStringAsFixed(2)} mg/dL",
      "Sodium": "${random.nextInt(10) + 135} mmol/L",
      "BNP": "${random.nextInt(300) + 100} pg/mL",
      "Heart Rate": "${random.nextInt(40) + 60} bpm",
      "Blood Pressure":
          "${random.nextInt(20) + 110}/${random.nextInt(20) + 70} mmHg",
      "Oxygen Saturation": "${random.nextInt(5) + 94}%",
      "Medication History":
          random.nextBool() ? "Aspirin, Beta-blockers" : "None",
    };
  }

  void showFlagDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Flag Report?",
            style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold),
          ),
          content: Text("Do you really want to flag this report?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No", style: TextStyle(color: Colors.blue.shade900)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blue.shade900,
                    content: Text(
                      "Report flagged",
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                      ),
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Prediction Result",
          style: GoogleFonts.robotoCondensed(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    widget.readmissionRequired
                        ? Icons.warning
                        : Icons.check_circle,
                    size: 100,
                    color:
                        widget.readmissionRequired ? Colors.red : Colors.green,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.readmissionRequired
                        ? "You may need readmission. \n Consult your doctor."
                        : "No readmission required. \n Stay healthy!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: patientDetails.entries.map((entry) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          entry.value,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: showFlagDialog,
                child: Text(
                  "Flag",
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
