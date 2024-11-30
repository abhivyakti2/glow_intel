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
        title: Text("Skin Health Result"),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated Text for Skin Type
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Skin Type: $skinType",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                
                // Add a divider for styling
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                
                // Animated Text for Recommendations
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Recommendation: $recommendation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                
                // Add a divider for styling
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                
                // Animated Text for Brand Recommendations
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Brands to Use: $brandRecommendation",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Call-to-Action Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // You can add any action here like navigating to another screen
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                    ),
                    child: Text(
                      "Back to Home",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
