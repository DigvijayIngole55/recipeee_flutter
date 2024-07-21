import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:receipeee/Pages/home_page.dart';
import 'package:receipeee/Pages/ingredients_page.dart';
import 'package:receipeee/Pages/result_page.dart';
import 'providers/ingredient_provider.dart';
import 'providers/recipe_provider.dart';
import 'theme.dart';
  
void main() async {
  await dotenv.load(fileName: ".env");
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
          '/ingredients': (context) => IngredientsPage(),
          '/results': (context) => ResultsPage(),
          // '/recipe_suggestions': (context) => RecipeSuggestionsPage(),
        },
      ),
    );
  }
}
