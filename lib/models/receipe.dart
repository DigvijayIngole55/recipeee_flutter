class Recipe {
  final String name;
  final String description;
  final String type;
  final List<String> cuisine;
  final List<String> missingIngredients;
  final List<String> allergenType;
  final List<String> dietaryType;
  final String cookingLevel;
  final List<String> instruction;
  final String image;

  Recipe({
    required this.name,
    required this.description,
    required this.type,
    required this.cuisine,
    required this.missingIngredients,
    required this.allergenType,
    required this.dietaryType,
    required this.cookingLevel,
    required this.instruction,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print("Parsing Recipe from JSON: $json");

    return Recipe(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      cuisine: List<String>.from(json['cuisine'] ?? []),
      missingIngredients:
          List<String>.from(json['missing_ingredients_major'] ?? []),
      allergenType: List<String>.from(json['allergen_type'] ?? []),
      dietaryType: List<String>.from(json['dietary_type'] ?? []),
      cookingLevel: json['cooking_level'] ?? '',
      instruction: List<String>.from(json['instruction'] ?? []),
      image: json['image'] ?? '',
    );
  }
}
