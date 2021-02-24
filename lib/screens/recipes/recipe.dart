class Recipe {
  Recipe(this.name, this.imageUrl, this.ingredients, this.instructions,
      this.notes, this.story);

  String name;
  String imageUrl;
  Map<dynamic, dynamic> ingredients;
  List<String> instructions;
  List<String> notes;
  String story;
}
