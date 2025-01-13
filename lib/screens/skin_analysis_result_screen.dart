import 'package:flutter/material.dart';
import 'home_screen.dart';

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
        title: Text(
          "Skin Health Result",
          style: TextStyle(
            color: Colors.black,
          ),
        ), // Change this to your desired color),

        backgroundColor: const Color.fromARGB(255, 142, 184, 255),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skin Type:",
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Add spacing between the label and the answer
                      Text(
                        "$skinType",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommendation:",
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Add spacing between the label and the answer
                      Text(
                        "$recommendation",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brands to Use:",
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Add spacing between the label and the answer
                      Text(
                        "$brandRecommendation",
                        style: TextStysle(
                          fontSize: 20,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Call-to-Action Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 122, 170, 254)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10)),
                    ),
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255)),
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
