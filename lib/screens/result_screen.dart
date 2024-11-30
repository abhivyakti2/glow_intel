import 'package:flutter/material.dart';

class SkinAnalysisResultScreen extends StatelessWidget {
  final String skinType;
  final String recommendation;
  final String brandRecommendation;

  SkinAnalysisResultScreen({
    required this.skinType,
    required this.recommendation,
    required this.brandRecommendation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text('Skin Health Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Your Skin Type: $skinType', style: TextStyle(fontSize: 28)),
            SizedBox(height: 20),
            Text('Recommendation: $recommendation', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            Text('Brand Recommendation: $brandRecommendation', style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
