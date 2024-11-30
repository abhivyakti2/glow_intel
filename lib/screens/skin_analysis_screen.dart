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

  Future<void> _pickImage() async {
    setState(() {
      _isButtonPressed = true;
    });
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _isButtonPressed = false;
      });
      // Navigate to the results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SkinAnalysisResultScreen(
            skinType: "Dry", // Example values, you can dynamically set this
            recommendation: "Use a hydrating face wash.",
            brandRecommendation: "Use Cetaphil Moisturizing Cream",
          ),
        ),
      );
    }
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
                colors: [Colors.deepOrange, Colors.orangeAccent],
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
                  Text(
                    "Capture your skin image",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: _isButtonPressed
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Take a Photo",
                              style: TextStyle(fontSize: 18),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
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
