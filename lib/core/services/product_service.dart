import 'package:nak_electronics/models/product.dart';

class ProductService {
  static final List<Product> _products = [
    // Keyboards
    Product(
      id: '1',
      name: 'Yamaha PSR-EW425',
      price: 450.0,
      image: 'assets/images/Keyboard1.png',
      category: 'Keyboard',
      brand: 'Yamaha',
      description: 'Portable keyboard with 76 keys',
      isNew: true,
    ),
    Product(
      id: '2',
      name: 'Casio CT-X3000',
      price: 350.0,
      image: 'assets/images/keyboard.png',
      category: 'Keyboard',
      brand: 'Casio',
      description: '61-key portable keyboard',
      isNew: false,
    ),
    // Guitars
    Product(
      id: '3',
      name: 'Fender Player Stratocaster',
      price: 650.0,
      image: 'assets/images/fender player.png',
      category: 'Guitars & Bass',
      brand: 'Fender',
      description: 'Electric guitar',
      isNew: true,
    ),
    Product(
      id: '4',
      name: 'Gibson Les Paul',
      price: 1200.0,
      image: 'assets/images/gibsonsg.png',
      category: 'Guitars & Bass',
      brand: 'Gibson',
      description: 'Classic electric guitar',
      isNew: false,
    ),
    // Drums
    Product(
      id: '5',
      name: 'Pearl Export',
      price: 800.0,
      image: 'assets/images/pearl.png',
      category: 'Drums & Percussion',
      brand: 'Pearl',
      description: '5-piece drum kit',
      isNew: false,
    ),
    Product(
      id: '6',
      name: 'TAMA Imperialstar',
      price: 950.0,
      image: 'assets/images/tamadrum.png',
      category: 'Drums & Percussion',
      brand: 'TAMA',
      description: '6-piece drum kit',
      isNew: true,
    ),
    // Headphones
    Product(
      id: '7',
      name: 'JBL T600',
      price: 50.0,
      image: 'assets/images/headphone.png',
      category: 'Headphones',
      brand: 'JBL',
      description: 'Wireless headphones',
      isNew: false,
    ),
    Product(
      id: '8',
      name: 'Sony WH-1000XM4',
      price: 250.0,
      image: 'assets/images/headset.png',
      category: 'Headphones',
      brand: 'Sony',
      description: 'Noise-cancelling headphones',
      isNew: true,
    ),
    // Microphones
    Product(
      id: '9',
      name: 'Shure SM58',
      price: 100.0,
      image: 'assets/images/shure.png',
      category: 'Microphones',
      brand: 'Shure',
      description: 'Dynamic microphone',
      isNew: false,
    ),
    Product(
      id: '10',
      name: 'AKG C214',
      price: 400.0,
      image: 'assets/images/microphone.png',
      category: 'Microphones',
      brand: 'AKG',
      description: 'Condenser microphone',
      isNew: false,
    ),
    // Amplifiers
    Product(
      id: '11',
      name: 'Fender Tone Master Deluxe',
      price: 300.0,
      image: 'assets/images/amp.png',
      category: 'Amplifiers',
      brand: 'Fender',
      description: 'Guitar amplifier',
      isNew: false,
    ),
    // Mixers
    Product(
      id: '12',
      name: 'Yamaha MG06X',
      price: 200.0,
      image: 'assets/images/mg_series.png',
      category: 'Mixers',
      brand: 'Yamaha',
      description: '6-channel mixer',
      isNew: false,
    ),
    // PA Systems
    Product(
      id: '13',
      name: 'JBL EON615',
      price: 500.0,
      image: 'assets/images/jbl.png',
      category: 'PA System & Live Sound',
      brand: 'JBL',
      description: '15" powered speaker',
      isNew: true,
    ),
    Product(
      id: '14',
      name: 'Electro-Voice ZLX-12P',
      price: 400.0,
      image: 'assets/images/ev.png',
      category: 'PA System & Live Sound',
      brand: 'EV',
      description: '12" powered speaker',
      isNew: false,
    ),
    // Accessories - let's add some
    Product(
      id: '15',
      name: 'Keyboard Stand',
      price: 30.0,
      image: 'assets/images/keyboard.png', // placeholder
      category: 'Keyboard',
      brand: 'Generic',
      description: 'Adjustable keyboard stand',
      isNew: false,
    ),
    Product(
      id: '16',
      name: 'Guitar Strings',
      price: 10.0,
      image: 'assets/images/guitar.png', // placeholder
      category: 'Guitars & Bass',
      brand: 'Generic',
      description: 'Set of guitar strings',
      isNew: false,
    ),
  ];

  static List<Product> getAllProducts() {
    return _products;
  }

  static List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  static List<Product> getProductsByBrand(String brand) {
    return _products.where((p) => p.brand == brand).toList();
  }

  static List<Product> getNewArrivals() {
    return _products.where((p) => p.isNew).toList();
  }

  static Product? getProductById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
