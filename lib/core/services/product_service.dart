import 'package:nak_electronics/data/dummyData.dart';
import 'package:nak_electronics/models/product.dart';

class ProductService {
  static Future<List<Product>> getAllProducts() async => dummyProducts;

  static Stream<List<Product>> getAllProductsStream() =>
      Stream.value(dummyProducts);

  static Future<List<Product>> getProductsByCategory(String category) async =>
      dummyProducts
          .where(
            (p) => p.category.toLowerCase() == category.toLowerCase(),
          )
          .toList();

  static Future<List<Product>> getProductsByBrand(String brand) async =>
      dummyProducts
          .where((p) => p.brand.toLowerCase() == brand.toLowerCase())
          .toList();

  static Future<List<Product>> getNewArrivals() async =>
      dummyProducts.where((p) => p.isNew).toList();

  static Future<Product?> getProductById(String id) async =>
      dummyProducts.where((p) => p.id == id).firstOrNull;
}

