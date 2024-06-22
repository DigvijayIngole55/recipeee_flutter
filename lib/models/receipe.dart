class Recipe {
  final String suggestion;

  Recipe(this.suggestion);

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(json['suggestion']);
  }

  Map<String, dynamic> toJson() {
    return {'suggestion': suggestion};
  }
}
