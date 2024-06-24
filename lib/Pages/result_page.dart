import 'package:flutter/material.dart';
import 'package:receipeee/theme.dart';
import 'package:receipeee/widgets/common_background.dart';

class ResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Spaghetti Bolognese',
      'image': 'https://www.example.com/images/spaghetti-bolognese.jpg',
      'type': 'Non-Vegetarian',
      'missingIngredients': ['Tomatoes', 'Ground Beef']
    },
    {
      'name': 'Vegetable Stir Fry',
      'image': 'https://www.example.com/images/vegetable-stir-fry.jpg',
      'type': 'Vegan',
      'missingIngredients': ['Bell Pepper', 'Soy Sauce']
    },
    {
      'name': 'Chicken Salad',
      'image': 'https://www.example.com/images/chicken-salad.jpg',
      'type': 'Non-Vegetarian',
      'missingIngredients': ['Chicken Breast', 'Olive Oil']
    },
    {
      'name': 'Grilled Cheese Sandwich',
      'image': 'https://www.example.com/images/grilled-cheese-sandwich.jpg',
      'type': 'Vegetarian',
      'missingIngredients': ['Cheddar Cheese', 'Butter']
    },
    {
      'name': 'Mushroom Risotto',
      'image': 'https://www.example.com/images/mushroom-risotto.jpg',
      'type': 'Vegetarian',
      'missingIngredients': ['Arborio Rice', 'Parmesan Cheese']
    },
    {
      'name': 'Beef Tacos',
      'image': 'https://www.example.com/images/beef-tacos.jpg',
      'type': 'Non-Vegetarian',
      'missingIngredients': ['Ground Beef', 'Taco Shells']
    },
    {
      'name': 'Quinoa Salad',
      'image': 'https://www.example.com/images/quinoa-salad.jpg',
      'type': 'Vegan',
      'missingIngredients': ['Quinoa', 'Avocado']
    },
    {
      'name': 'Pancakes',
      'image': 'https://www.example.com/images/pancakes.jpg',
      'type': 'Vegetarian',
      'missingIngredients': ['Flour', 'Maple Syrup']
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

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
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Container(
                height: screenHeight,
                width: screenWidth,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Results',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth > 600 ? 4 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: recipe['image'] != null
                                        ? Image.network(
                                            recipe['image'],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey,
                                                child: Center(
                                                  child: Text(
                                                    'No Image Found',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            color: Colors.grey,
                                            child: Center(
                                              child: Text(
                                                'No Image Found',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    recipe['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Type: ${recipe['type']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    'Missing: ${recipe['missingIngredients'].join(', ')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
