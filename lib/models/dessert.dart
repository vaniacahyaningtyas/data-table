class Dessert {
  Dessert(
    this.name, // The name of the dessert
    this.calories, // The number of calories in the dessert
    this.fat, // The amount of fat in the dessert (in grams)
    this.carbs, // The number of carbohydrates in the dessert (in grams)
      );

  final String name; // The name of the dessert (immutable)
  final int calories; // The number of calories in the dessert (immutable)
  final double fat; // The amount of fat in the dessert (in grams) (immutable)
  final int
      carbs; // The number of carbohydrates in the dessert (in grams) (immutable)
  
  // The amount of protein in the dessert (in grams) (immutable)
  bool selected =
      false; // Whether the dessert is currently selected (default is false)
}
