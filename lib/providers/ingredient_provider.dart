import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
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
    final url = Uri.parse('http://localhost:8080/ocr/upload');
    final reader = html.FileReader();
    reader.readAsArrayBuffer(imageFile);
    reader.onLoadEnd.listen((event) async {
      final formData = html.FormData();
      formData.appendBlob('image', html.Blob([reader.result]), imageFile.name);

      final request = html.HttpRequest();
      request.open('POST', url.toString(), async: true);
      request.setRequestHeader('Accept', 'application/json');
      request.onLoadEnd.listen((event) {
        if (request.status == 200) {
          try {
            final extractedData = json.decode(request.responseText!);
            final ingredients = List<String>.from(extractedData['ingredients']);
            print(ingredients);
            Provider.of<IngredientProvider>(context, listen: false)
                .setIngredients(ingredients
                    .map((ingredient) => Ingredient(ingredient))
                    .toList());
            print('Image uploaded successfully and ingredients updated.');
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
}

class Ingredient {
  final String name;

  Ingredient(this.name);
}
