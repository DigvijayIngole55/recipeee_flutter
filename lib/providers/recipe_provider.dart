import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receipeee/models/receipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  Future<void> fetchRecipes(List<String> ingredients) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/recipes/generate-recipes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ingredients': ingredients}),
    );

    if (response.statusCode == 200) {
      print("*********** Response Body: " + response.body);
      final data = jsonDecode(response.body);

      if (data != null) {
        print("*********** Data: " + data.toString());
        print("*********** Type of 'recipes': " +
            data['recipes'].runtimeType.toString());
      }

      if (data != null && data['recipes'] != null && data['recipes'] is List) {
        final List<Recipe> recipes =
            (data['recipes'] as List).map((recipeData) {
          print("*********** Recipe Data: " + recipeData.toString());
          return Recipe.fromJson(recipeData);
        }).toList();

        _recipes = recipes;
        notifyListeners();
      } else {
        _recipes = [];
        print('No recipes found in the response or invalid data type.');
        notifyListeners();
      }
    } else {
      print('Failed to load recipes. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load recipes');
    }
  }
}
