import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:receipeee/models/receipe.dart';

class RecipeProvider with ChangeNotifier {
  Recipe? _recipe;

  Recipe? get recipe => _recipe;

  Future<void> suggestRecipe(List<String> ingredients) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/recipes/suggest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ingredients': ingredients}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _recipe = Recipe.fromJson(data);
      notifyListeners();
    }
  }
}
