class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String brand;
  final String description;
  final bool isNew;
  final double? discount;
  final String type; // 'Instrument' or 'Accessory'

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.brand,
    required this.description,
    this.isNew = false,
    this.discount,
    this.type = 'Instrument',
  });

  double get discountedPrice =>
      discount != null ? price * (1 - discount!) : price;
}
