import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'skin_analysis_result_screen.dart';

class SkinAnalysisScreen extends StatefulWidget {
  @override
  _SkinAnalysisScreenState createState() => _SkinAnalysisScreenState();
}

class _SkinAnalysisScreenState extends State<SkinAnalysisScreen> {
  File? _imageFile;
  bool _isButtonPressed = false;
  String _skinType = '';
  String _recommendation = '';
  String _brandRecommendation = '';

  Future<void> _pickImage() async {
    setState(() {
      _isButtonPressed = true;
    });
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _isButtonPressed = false;
      });
      // Analyze the image and set the skin type, recommendation, and brand recommendation
      _analyzeImage();
      // Navigate to the results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SkinAnalysisResultScreen(
            skinType: _skinType,
            recommendation: _recommendation,
            brandRecommendation: _brandRecommendation,
          ),
        ),
      );
    }
  }

  void _analyzeImage() {
    // TO DO: Implement image analysis logic here
    // For demonstration purposes, we'll use example values
    _skinType = 'Dry';
    _recommendation = 'Use a hydrating face wash.';
    _brandRecommendation = 'Use Cetaphil Moisturizing Cream';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 142, 184, 255),
                  Colors.purple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Click below to capture your skintype",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w100,
                        color: const Color.fromARGB(255, 250, 225, 255),
                      ),
                      textAlign:
                          TextAlign.center, // Ensures text stays centered
                    ),
                  ),
                  SizedBox(height: 30),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: _isButtonPressed
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Take a Photo",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 122, 170, 254),
                              ),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_imageFile != null)
                    Image.file(_imageFile!, height: 200, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
