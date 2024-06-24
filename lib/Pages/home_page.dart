import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:receipeee/providers/ingredient_provider.dart';
import 'package:receipeee/widgets/common_background.dart';
import 'package:receipeee/widgets/common_elevated_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      _extractTextFromImage(imageFile);
    }
  }

  Future<void> _extractTextFromImage(File imageFile) async {
    // Simulate OCR extraction
    final ingredientProvider =
        Provider.of<IngredientProvider>(context, listen: false);
    ingredientProvider
        .addIngredient("Simulated OCR result: Extracted ingredient");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Recipeee!',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CommonElevatedButton(
                  text: 'Let\'s Get Started',
                  onPressed: () {
                    Navigator.pushNamed(context, '/ingredients');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
