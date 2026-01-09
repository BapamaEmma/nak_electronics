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
