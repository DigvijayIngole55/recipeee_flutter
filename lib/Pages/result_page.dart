import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipeee/models/receipe.dart';
import 'package:receipeee/providers/recipe_provider.dart';
import 'package:receipeee/widgets/common_background.dart';
import 'package:receipeee/widgets/common_elevated_button.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isVertical = screenHeight > screenWidth;

    final horizontalPadding =
        screenWidth > 600 ? screenWidth * 0.1 : screenWidth * 0.05;
    final verticalPadding =
        screenHeight > 800 ? screenHeight * 0.05 : screenHeight * 0.03;

    return Scaffold(
      body: CommonBackground(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<RecipeProvider>(
                    builder: (context, recipeProvider, child) {
                      if (recipeProvider.recipes.isEmpty) {
                        return Center(
                          child: Text(
                            'No recipes found.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: recipeProvider.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipeProvider.recipes[index];
                          return buildRecipeCard(context, recipe, isVertical);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                CommonElevatedButton(
                  text: 'Download Recipes',
                  onPressed: () => downloadRecipesAsHtml(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecipeCard(BuildContext context, Recipe recipe, bool isVertical) {
    final imageSize = isVertical ? 200.0 : 512.0; // Adjust image size

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isVertical
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildImage(context, recipe, imageSize),
                    SizedBox(height: 16),
                    buildRecipeDetails(context, recipe),
                    SizedBox(height: 16),
                    buildInstructions(context, recipe),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildImage(context, recipe, imageSize),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRecipeDetails(context, recipe),
                          SizedBox(height: 16),
                          buildInstructions(context, recipe),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context, Recipe recipe, double imageSize) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: recipe.image == null || recipe.image.isEmpty
          ? Container(
              height: imageSize,
              width: imageSize,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  'No Image Found',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
          : Image.memory(
              base64Decode(recipe.image.split(',')[1]),
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  height: imageSize,
                  width: imageSize,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      'Image Error',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget buildRecipeDetails(BuildContext context, Recipe recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText(context, recipe.name, true, Colors.black87),
        SizedBox(height: 4),
        buildText(context, 'Type: ${recipe.type}', false),
        buildText(context, 'Cuisine: ${recipe.cuisine.join(', ')}', false),
        buildText(
            context,
            'Missing Ingredients: ${recipe.missingIngredients.join(', ')}',
            false,
            Colors.red),
        buildText(context, 'Allergen Type: ${recipe.allergenType.join(', ')}',
            false, Colors.red),
        buildText(
            context, 'Dietary Type: ${recipe.dietaryType.join(', ')}', false),
        buildText(context, 'Cooking Level: ${recipe.cookingLevel}', false),
      ],
    );
  }

  Widget buildInstructions(BuildContext context, Recipe recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText(context, 'Instructions:', true, Colors.black87),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recipe.instruction.map<Widget>((step) {
            int index = recipe.instruction.indexOf(step);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: buildText(
                  context, '${index + 1}. $step', false, Colors.black54),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildText(BuildContext context, String text, bool isBold,
      [Color? color]) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color ?? Colors.black87,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
    );
  }

  void downloadRecipesAsHtml(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    final recipes = recipeProvider.recipes;
    StringBuffer htmlContent = StringBuffer();

    htmlContent.write('''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recipes</title>
        <style>
          body { font-family: Arial, sans-serif; padding: 20px; }
          .recipe-card { border: 1px solid #ccc; border-radius: 15px; margin-bottom: 20px; padding: 20px; }
          .recipe-card img { max-width: 100%; border-radius: 10px; }
          .recipe-card h2 { margin-top: 0; }
          .recipe-card p { margin: 5px 0; }
          .instructions { margin-top: 10px; }
          .instructions li { margin-bottom: 5px; }
        </style>
      </head>
      <body>
    ''');

    for (var recipe in recipes) {
      htmlContent.write('''
        <div class="recipe-card">
          <img src="${recipe.image}" alt="${recipe.name}">
          <h2>${recipe.name}</h2>
          <p><strong>Type:</strong> ${recipe.type}</p>
          <p><strong>Cuisine:</strong> ${recipe.cuisine.join(', ')}</p>
          <p><strong>Missing Ingredients:</strong> ${recipe.missingIngredients.join(', ')}</p>
          <p><strong>Allergen Type:</strong> ${recipe.allergenType.join(', ')}</p>
          <p><strong>Dietary Type:</strong> ${recipe.dietaryType.join(', ')}</p>
          <p><strong>Cooking Level:</strong> ${recipe.cookingLevel}</p>
          <div class="instructions">
            <h3>Instructions:</h3>
            <ul>
      ''');

      for (var instruction in recipe.instruction) {
        htmlContent.write('<li>${instruction}</li>');
      }

      htmlContent.write('''
            </ul>
          </div>
        </div>
      ''');
    }

    htmlContent.write('''
      </body>
      </html>
    ''');

    final bytes = utf8.encode(htmlContent.toString());
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'recipes.html')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
