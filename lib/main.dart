import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:medical_app/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heart Failure Prediction',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PredictionScreen(),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/images/SmallSquareLogoJpg.jpg',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  File? selectedFile;
  int? fileSize;

  Future<void> pickEHRFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'csv', 'json'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileSize = result.files.single.size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: const Drawer(),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       child: Icon(
      //         Icons.person_2,
      //       ),
      //     )
      //   ],
      //   backgroundColor: Colors.blue.shade900,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.blue.shade900,
              ),
              const Positioned(
                right: 20,
                top: 45,
                child: SizedBox(
                  child: Icon(
                    size: 25,
                    Icons.person_2,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  height: 200,
                  width: 320,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CHECK YOUR MEDICAL  ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Predict your Heart failure \n  with AI  ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text(
                    'Upload Your Electronic Health Record (EHR)',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: pickEHRFile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.upload_file,
                              color: Colors.blue, size: 24),
                          const SizedBox(width: 10),
                          Expanded(
                            child: selectedFile != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedFile!.path.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${(fileSize! / 1024).toStringAsFixed(2)} KB",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Tap to select a file",
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                          if (selectedFile != null)
                            IconButton(
                              icon: Icon(Icons.close,
                                  color: Colors.blue.shade900),
                              onPressed: () {
                                setState(() {
                                  selectedFile = null;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    selectedFile != null
                        ? "File Type: ${selectedFile!.path.split('.').last.toUpperCase()}"
                        : "No file chosen",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 14,
                      color: selectedFile != null
                          ? Colors.black
                          : Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            bool needsReadmission = DateTime.now().second % 2 == 0;

            // Navigate to ResultScreen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  readmissionRequired: needsReadmission,
                ),
              ),
            );
          },
          label: Text(
            "Predict",
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          icon: const Icon(
            Icons.analytics,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue.shade900,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
