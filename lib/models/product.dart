import 'package:cloud_firestore/cloud_firestore.dart';

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
    };
  }
}
