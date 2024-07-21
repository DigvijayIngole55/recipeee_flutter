import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:receipeee/models/ingredient.dart';

class IngredientProvider with ChangeNotifier {
  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients => _ingredients;

  void addIngredient(String name) {
    _ingredients.add(Ingredient(name));
    notifyListeners();
  }

  void removeIngredient(int index) {
    _ingredients.removeAt(index);
    notifyListeners();
  }

  void setIngredients(List<Ingredient> ingredients) {
    _ingredients = ingredients;
    notifyListeners();
  }

  Future<void> uploadImage(html.File imageFile, BuildContext context) async {
    final url = Uri.parse('http://localhost:8080/api/upload');
    final reader = html.FileReader();
    reader.readAsArrayBuffer(imageFile);
    reader.onLoadEnd.listen((event) async {
      final formData = html.FormData();
      formData.appendBlob('image', html.Blob([reader.result]), imageFile.name);

      final request = html.HttpRequest();
      request.open('POST', url.toString(), async: true);
      request.setRequestHeader('Accept', 'application/json');
      request.onLoadEnd.listen((event) {
        print(request.response.toString());
        if (request.status == 200) {
          try {
            final extractedData = json.decode(request.responseText!);
            if (extractedData.containsKey('ingredients')) {
              final ingredients =
                  List<String>.from(extractedData['ingredients']);
              Provider.of<IngredientProvider>(context, listen: false)
                  .setIngredients(ingredients
                      .map((ingredient) => Ingredient(ingredient))
                      .toList());
              print('Image uploaded successfully and ingredients updated.');
            } else {
              print('No ingredients key found in the response.');
            }
          } catch (e) {
            print('Failed to decode response: $e');
          }
        } else {
          print('Failed to upload image. Status: ${request.status}');
          print('Response: ${request.responseText}');
        }
      });
      request.onError.listen((event) {
        print('An error occurred during the upload.');
      });
      request.send(formData);
    });
  }

  void pickImage(BuildContext context) async {
    final pickedFile = await ImagePickerWeb.getImageAsFile();
    if (pickedFile != null) {
      uploadImage(pickedFile, context);
    }
  }

  // Future<void> fetchRecipes(BuildContext context) async {
  //   final url = Uri.parse('http://localhost:8080/recipes/get-recipes');
  //   final ingredientNames =
  //       _ingredients.map((ingredient) => ingredient.name).toList();

  //   try {
  //     print('Fetching recipes with ingredients: $ingredientNames');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'ingredients': ingredientNames}),
  //     );

  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Recipes fetched successfully: ${data['recipes']}');
  //       Navigator.pushNamed(context, '/results', arguments: data['recipes']);
  //     } else {
  //       print('Failed to load recipes. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       throw Exception('Failed to load recipes');
  //     }
  //   } catch (error) {
  //     print('Error occurred while fetching recipes: $error');
  //     throw error;
  //   }
  // }
}

class Ingredient {
  final String name;

  Ingredient(this.name);
}
