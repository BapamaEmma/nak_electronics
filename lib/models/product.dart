import 'package:cloud_firestore/cloud_firestore.dart';

/// A single colour variant for a product (e.g. "Wooden Brown" with its own image).
class ColorVariant {
  final String name;
  final String hex; // e.g. "#8B4513"
  final String image; // URL or empty string

  const ColorVariant({required this.name, required this.hex, this.image = ''});

  factory ColorVariant.fromMap(Map<String, dynamic> m) => ColorVariant(
    name: m['name']?.toString() ?? '',
    hex: m['hex']?.toString() ?? '#000000',
    image: m['image']?.toString() ?? '',
  );

  Map<String, dynamic> toMap() => {'name': name, 'hex': hex, 'image': image};
}

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

  // Additional fields
  final String? availability;
  final String? stock;
  final String? colours;
  final String? style;
  final String? itemNumber;
  final List<String> images;
  final List<ColorVariant> colorVariants;

  Product({
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
    this.availability,
    this.stock,
    this.colours,
    this.style,
    this.itemNumber,
    this.images = const [],
    this.colorVariants = const [],
  });

  // Helper getter to check if product is in stock
  bool get inStock {
    if (availability == null) return false;
    return availability!.toLowerCase().contains('in stock');
  }

  // Helper getter for stock status text
  String get stockStatus {
    if (availability == null) return 'Unknown';
    final avail = availability!.toLowerCase();
    if (avail.contains('in stock')) return 'In Stock';
    if (avail.contains('out of stock')) return 'Out of Stock';
    if (avail.contains('low stock')) return 'Low Stock';
    return availability!; // Return as-is if no match
  }

  double get discountedPrice =>
      discount != null ? price * (1 - discount!) : price;

  /// All images to show in the gallery. Falls back to the single [image] field.
  List<String> get allImages {
    final list = <String>[];
    if (image.isNotEmpty) list.add(image);
    for (final img in images) {
      if (img.isNotEmpty && !list.contains(img)) list.add(img);
    }
    return list;
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final raw = doc.data();
    final data = (raw is Map<String, dynamic>) ? raw : <String, dynamic>{};
    return Product(
      id: doc.id,
      name: data['name']?.toString() ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      image: data['image']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      brand: data['brand']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      isNew: data['isNew'] == true,
      discount: (data['discount'] as num?)?.toDouble(),
      type: data['type']?.toString() ?? 'Instrument',
      availability: data['availability']?.toString(),
      stock: data['stock']?.toString(),
      colours: data['colours']?.toString(),
      style: data['style']?.toString(),
      itemNumber: (data['itemNumber'] ?? data['item#'])?.toString(),
      images:
          (data['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .where((s) => s.isNotEmpty)
              .toList() ??
          [],
      colorVariants:
          (data['colorVariants'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map(ColorVariant.fromMap)
              .toList() ??
          [],
    );
  }

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name']?.toString() ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      image: data['image']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      brand: data['brand']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      isNew: data['isNew'] == true,
      discount: (data['discount'] as num?)?.toDouble(),
      type: data['type']?.toString() ?? 'Instrument',
      availability: data['availability']?.toString(),
      stock: data['stock']?.toString(),
      colours: data['colours']?.toString(),
      style: data['style']?.toString(),
      itemNumber: (data['itemNumber'] ?? data['item#'])?.toString(),
      images:
          (data['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .where((s) => s.isNotEmpty)
              .toList() ??
          [],
      colorVariants:
          (data['colorVariants'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map(ColorVariant.fromMap)
              .toList() ??
          [],
    );
  }

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'category': category,
      'description': description,
      'availability': availability ?? 'In stock',
      'stock': stock,
      'colours': colours,
      'style': style,
      'itemNumber': itemNumber,
      'isNew': isNew,
      'discount': discount,
      'type': type,
      'brand': brand,
      'colorVariants': colorVariants.map((v) => v.toMap()).toList(),
    };
  }
}
