import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipeee/screens/homeScreen.dart';
import 'providers/ingredient_provider.dart';
import 'providers/recipe_provider.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IngredientProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          // '/ingredients': (context) => IngredientsPage(),
          // '/recipe_suggestions': (context) => RecipeSuggestionsPage(),
        },
      ),
    );
  }
}
