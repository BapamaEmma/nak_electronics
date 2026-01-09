import 'package:nak_electronics/models/product.dart';

class ProductService {
  // Dummy product data
  static final List<Product> _dummyProducts = [
    Product(
      id: '1',
      name: 'Professional Studio Headphones',
      price: 450.00,
      image: 'assets/images/headphone.png',
      category: 'Headphones',
      brand: 'Generic',
      description: 'High-quality studio headphones for professional audio work',
      isNew: true,
      discount: 0.15,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'HP-001',
    ),
    Product(
      id: '2',
      name: 'Electric Guitar Amplifier 50W',
      price: 1200.00,
      image: 'assets/images/amp.png',
      category: 'Amplifiers',
      brand: 'Generic',
      description: 'Powerful 50W electric guitar amplifier',
      isNew: false,
      discount: 0.10,
      type: 'Instrument',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'AMP-002',
    ),
    Product(
      id: '3',
      name: 'Professional Condenser Microphone',
      price: 320.00,
      image: 'assets/images/condenser.png',
      category: 'Microphones',
      brand: 'Generic',
      description: 'Professional condenser microphone for studio recording',
      isNew: true,
      discount: 0.12,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Silver',
      itemNumber: 'MIC-003',
    ),
    Product(
      id: '4',
      name: 'Digital Audio Interface',
      price: 680.00,
      image: 'assets/images/card.png',
      category: 'Recording Gear',
      brand: 'Generic',
      description: 'Professional digital audio interface',
      isNew: false,
      discount: 0.08,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'AUD-004',
    ),
    Product(
      id: '5',
      name: 'Acoustic Guitar Premium',
      price: 1800.00,
      image: 'assets/images/acoustic.png',
      category: 'Guitars & Bass',
      brand: 'Generic',
      description: 'Premium acoustic guitar with beautiful sound',
      isNew: true,
      discount: 0.20,
      type: 'Instrument',
      availability: 'In Stock',
      colours: 'Natural',
      itemNumber: 'GUIT-005',
    ),
    Product(
      id: '6',
      name: 'Tama Drum Kit',
      price: 9000.00,
      image: 'assets/images/tamadrum.png',
      category: 'Drums & Percussion',
      brand: 'TAMA',
      description: 'Professional drum kit',
      isNew: false,
      discount: 0.15,
      type: 'Instrument',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'DRUM-006',
    ),
    Product(
      id: '7',
      name: 'Fender Player Stratocaster',
      price: 2800.00,
      image: 'assets/images/fender player.png',
      category: 'Guitars & Bass',
      brand: 'Fender',
      description: 'Classic Fender Stratocaster electric guitar',
      isNew: true,
      discount: 0.13,
      type: 'Instrument',
      availability: 'In Stock',
      colours: 'Sunburst',
      itemNumber: 'FEN-007',
    ),
    Product(
      id: '8',
      name: 'Gibson SG Standard',
      price: 2500.00,
      image: 'assets/images/gibsonsg.png',
      category: 'Guitars & Bass',
      brand: 'Gibson',
      description: 'Gibson SG Standard electric guitar',
      isNew: true,
      discount: 0.17,
      type: 'Instrument',
      availability: 'In Stock',
      colours: 'Cherry Red',
      itemNumber: 'GIB-008',
    ),
    Product(
      id: '9',
      name: 'MG 16-Channel Mixer',
      price: 1500.00,
      image: 'assets/images/MG mixer.png',
      category: 'Mixers',
      brand: 'Yamaha',
      description: 'Professional 16-channel audio mixer',
      isNew: true,
      discount: 0.17,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'MIX-009',
    ),
    Product(
      id: '10',
      name: 'JBL SRX828SP Subwoofer',
      price: 15000.00,
      image: 'assets/images/jblsub.png',
      category: 'PA System & Live Sound',
      brand: 'JBL',
      description: 'Professional subwoofer speaker system',
      isNew: true,
      discount: 0.16,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'JBL-010',
    ),
    Product(
      id: '11',
      name: 'Studio Headphones Pro',
      price: 750.00,
      image: 'assets/images/headset.png',
      category: 'Headphones',
      brand: 'Generic',
      description: 'Professional studio monitoring headphones',
      isNew: true,
      discount: 0.17,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Black',
      itemNumber: 'HP-011',
    ),
    Product(
      id: '12',
      name: 'Condenser Microphone with XLR',
      price: 980.00,
      image: 'assets/images/microphone.png',
      category: 'Microphones',
      brand: 'Generic',
      description: 'Professional condenser microphone',
      isNew: true,
      discount: 0.18,
      type: 'Accessory',
      availability: 'In Stock',
      colours: 'Silver',
      itemNumber: 'MIC-012',
    ),
  ];

  // Fetch all products
  static Future<List<Product>> getAllProducts() async {
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_dummyProducts);
  }

  // Fetch products by category
  static Future<List<Product>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _dummyProducts.where((p) => 
      p.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  // Fetch products by brand
  static Future<List<Product>> getProductsByBrand(String brand) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _dummyProducts.where((p) => 
      p.brand.toLowerCase() == brand.toLowerCase()
    ).toList();
  }

  // Fetch new arrivals
  static Future<List<Product>> getNewArrivals() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _dummyProducts.where((p) => p.isNew).toList();
  }

  // Fetch a single product by ID
  static Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _dummyProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Stream products for real-time updates (returns dummy stream)
  static Stream<List<Product>> getAllProductsStream() {
    return Stream.value(_dummyProducts);
  }
}
