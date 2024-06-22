class Ingredient {
  String name;

  Ingredient(this.name);

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
