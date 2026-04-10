import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nak_electronics/models/product.dart';

class ProductService {
  static final _db = FirebaseFirestore.instance;
  static const _collection = 'products';

  static Future<List<Product>> getAllProducts() async {
    final snapshot = await _db.collection(_collection).get();
    return snapshot.docs.map(Product.fromFirestore).toList();
  }

  static Stream<List<Product>> getAllProductsStream() {
    return _db.collection(_collection).snapshots().map(
          (snapshot) => snapshot.docs.map(Product.fromFirestore).toList(),
        );
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    final snapshot = await _db
        .collection(_collection)
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs.map(Product.fromFirestore).toList();
  }

  static Future<List<Product>> getProductsByBrand(String brand) async {
    final snapshot = await _db
        .collection(_collection)
        .where('brand', isEqualTo: brand)
        .get();
    return snapshot.docs.map(Product.fromFirestore).toList();
  }

  static Future<List<Product>> getNewArrivals() async {
    final snapshot = await _db
        .collection(_collection)
        .where('isNew', isEqualTo: true)
        .get();
    return snapshot.docs.map(Product.fromFirestore).toList();
  }

  static Future<Product?> getProductById(String id) async {
    final doc = await _db.collection(_collection).doc(id).get();
    if (!doc.exists) return null;
    return Product.fromFirestore(doc);
  }
}

