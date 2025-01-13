import 'package:flutter/material.dart';
import 'skin_analysis_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background with vibrant colors
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.orangeAccent],
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
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome to\n",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "Skin Health Analyzer",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                      height: 45), // Adds space between the text and the button
                  AnimatedButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: _isHovered
            ? Colors.pinkAccent
            : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: _isHovered
                ? Colors.pinkAccent.withOpacity(0.5)
                : const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SkinAnalysisScreen()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
        ),
        onHover: (hovering) {
          setState(() {
            _isHovered = hovering;
          });
        },
        child: Text(
          "Start Skin Analysis",
          style: TextStyle(
            fontSize: 20,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
