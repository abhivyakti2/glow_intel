import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart'; // TensorFlow Lite
import 'package:http/http.dart' as http; // For API requests

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Tflite.loadModel(
    model: 'assets/model.tflite', // Add your tflite model in assets folder
    labels: 'assets/labels.txt', // Add your label file in assets folder
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// User Profile Model
class UserProfile {
  String name;
  String skinType;
  List<String> recommendedProducts;

  UserProfile({required this.name, this.skinType = "Unknown", this.recommendedProducts = const []});
}

/// User Profile Provider
class UserProfileProvider extends ChangeNotifier {
  final UserProfile _userProfile = UserProfile(name: "");

  UserProfile get userProfile => _userProfile;

  void updateName(String name) {
    _userProfile.name = name;
    notifyListeners();
  }

  void updateSkinType(String skinType) {
    _userProfile.skinType = skinType;
    notifyListeners();
  }

  void updateRecommendedProducts(List<String> products) {
    _userProfile.recommendedProducts = products;
    notifyListeners();
  }
}

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin Type Analyzer',
      home: const AuthenticationScreen(),
      routes: {
        '/profile': (context) => const ProfileScreen(),
        '/skinAnalysis': (context) => const SkinTypeScreen(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}

/// Authentication Screen
class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          child: const Text('Login to Analyze Skin Type'),
        ),
      ),
    );
  }
}

/// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfileProvider>(context).userProfile;

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${userProfile.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/skinAnalysis'),
              child: const Text('Analyze Skin Type'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skin Type Analysis Screen
class SkinTypeScreen extends StatefulWidget {
  const SkinTypeScreen({super.key});

  @override
  _SkinTypeScreenState createState() => _SkinTypeScreenState();
}

class _SkinTypeScreenState extends State<SkinTypeScreen> {
  late XFile _image;
  bool _isImageSelected = false;

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _isImageSelected = true;
      });
      _analyzeSkinType(pickedFile);
    }
  }

  Future<void> _analyzeSkinType(XFile image) async {
    File imgFile = File(image.path);

    // Analyze using TensorFlow Lite
    var output = await Tflite.runModelOnImage(
      path: imgFile.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 3,
      threshold: 0.5,
    );

    // Extract Skin Type
    String skinTypeDetected = _getSkinTypeFromOutput(output);

    // Update Provider
    Provider.of<UserProfileProvider>(context, listen: false).updateSkinType(skinTypeDetected);

    // Fetch Recommendations
    await _fetchRecommendedProducts(skinTypeDetected);

    Navigator.pushNamed(context, '/result');
  }

  String _getSkinTypeFromOutput(List<dynamic>? output) {
    if (output == null || output.isEmpty) return 'Unknown';
    var result = output.first; // Assuming first result is most confident
    return result['label']; // Assuming label is in output structure
  }

  Future<void> _fetchRecommendedProducts(String skinType) async {
    const apiKey = 'YOUR_API_KEY';
    final apiUrl = 'https://api.example.com/products?skinType=$skinType&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<String> products = List<String>.from(data['products'].map((item) => item['name']));
        Provider.of<UserProfileProvider>(context, listen: false).updateRecommendedProducts(products);
      } else {
        print("Failed to fetch products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching recommended products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Skin Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _captureImage,
              child: const Text("Capture Skin Image"),
            ),
            if (_isImageSelected) Image.file(File(_image.path)),
          ],
        ),
      ),
    );
  }
}

/// Result Screen
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfileProvider>(context).userProfile;

    return Scaffold(
      appBar: AppBar(title: const Text("Skin Type Analysis Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Skin Type: ${userProfile.skinType}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Recommended Products:", style: TextStyle(fontSize: 18)),
            ...userProfile.recommendedProducts.map((product) => Text("- $product")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/profile')),
              child: const Text("Go Back to Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
