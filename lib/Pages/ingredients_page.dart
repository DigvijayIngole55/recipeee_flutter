import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipeee/providers/ingredient_provider.dart';
import 'package:receipeee/providers/recipe_provider.dart';
import 'package:receipeee/theme.dart';
import 'package:receipeee/widgets/common_background.dart';
import 'package:receipeee/widgets/common_card_widget.dart';
import 'package:receipeee/widgets/common_elevated_button.dart';
import 'package:receipeee/widgets/loading_widget.dart';

class IngredientsPage extends StatefulWidget {
  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final TextEditingController _ingredientController = TextEditingController();
  bool _isLoading = false;
  bool _isButtonLoading = false;

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
            child: CommonCard(
              child: _isLoading
                  ? LoadingRobotWidget(
                      height: mediaQuery.size.height - horizontalPadding,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Ingredients',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: horizontalPadding),
                          child: Column(
                            children: [
                              Text(
                                'Upload your grocery bills to automatically scan and add ingredients, or manually input ingredients for a more personalized experience.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 20),
                              CommonElevatedButton(
                                text: _isButtonLoading ? '' : 'Upload Image',
                                onPressed: () async {
                                  setState(() {
                                    _isButtonLoading = true;
                                  });
                                  Provider.of<IngredientProvider>(context,
                                          listen: false)
                                      .pickImage(context);
                                  setState(() {
                                    _isButtonLoading = false;
                                  });
                                },
                                isLoading: _isButtonLoading,
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: _ingredientController,
                                decoration: InputDecoration(
                                    labelText: 'Add Ingredient',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: AppTheme
                                            .darkPurple, // Purple color border
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: AppTheme
                                            .darkPurple, // Purple color border
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: AppTheme
                                            .darkPurple, // Purple color border
                                      ),
                                    ),
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyLarge),
                                onSubmitted: (value) {
                                  Provider.of<IngredientProvider>(context,
                                          listen: false)
                                      .addIngredient(value);
                                  _ingredientController.clear();
                                },
                              ),
                              SizedBox(height: 20),
                              Consumer<IngredientProvider>(
                                builder: (context, ingredientProvider, child) {
                                  return Wrap(
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: ingredientProvider.ingredients
                                        .map((ingredient) {
                                      return Chip(
                                        label: Text(ingredient.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Colors.white)),
                                        backgroundColor: AppTheme.purple,
                                        deleteIcon: Icon(Icons.close,
                                            color: Colors.white),
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                            color: AppTheme
                                                .darkPurple, // Dark color border
                                          ),
                                        ),
                                        onDeleted: () {
                                          Provider.of<IngredientProvider>(
                                                  context,
                                                  listen: false)
                                              .removeIngredient(
                                                  ingredientProvider.ingredients
                                                      .indexOf(ingredient));
                                        },
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: CommonElevatedButton(
                            text: 'Next Step',
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                // Fetch recipes and navigate to the results page
                                final ingredientProvider =
                                    Provider.of<IngredientProvider>(context,
                                        listen: false);
                                final recipeProvider =
                                    Provider.of<RecipeProvider>(context,
                                        listen: false);

                                await recipeProvider.fetchRecipes(
                                    ingredientProvider.ingredients
                                        .map((e) => e.name)
                                        .toList());

                                Navigator.pushNamed(context, '/results');
                              } catch (e) {
                                print(e);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
