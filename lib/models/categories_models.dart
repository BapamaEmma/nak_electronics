class CategoryEntry {
  final String id;
  final String categories;
  final String name;
  final double price;
  final String image;
  final String availability;
  final String colours;
  final String descriptions;
  final String style;

  const CategoryEntry({
    required this.id,
    required this.categories,
    required this.name,
    required this.price,
    required this.image,
    required this.availability,
    required this.colours,
    required this.descriptions,
    required this.style,
  });

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categories': categories,
      'name': name,
      'price': price,
      'image': image,
      'availability': availability,
      'colours': colours,
      'descriptions': descriptions,
      'style': style,
    };
  }
}

