import 'package:flutter/material.dart';
import 'package:nak_electronics/core/services/product_service.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/features/product/product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  final String filterType; // 'category' or 'brand'
  final String filterValue;

  const ProductListPage({
    super.key,
    required this.filterType,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> products;
    if (filterType == 'category') {
      products = ProductService.getProductsByCategory(filterValue);
    } else if (filterType == 'brand') {
      products = ProductService.getProductsByBrand(filterValue);
    } else {
      products = ProductService.getAllProducts();
    }

    // Group by type if category
    Map<String, List<Product>> groupedProducts = {};
    if (filterType == 'category') {
      for (var product in products) {
        groupedProducts.putIfAbsent(product.type, () => []).add(product);
      }
    } else {
      groupedProducts['All'] = products;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$filterValue Products'),
        backgroundColor: Colors.red,
      ),
      body: groupedProducts.isEmpty
          ? const Center(child: Text('No products found'))
          : ListView(
              children: groupedProducts.entries.map((entry) {
                String type = entry.key;
                List<Product> typeProducts = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filterType == 'category')
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: typeProducts.length,
                      itemBuilder: (context, index) {
                        Product product = typeProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(product: product),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    product.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.broken_image,
                                              ),
                                            ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${product.discountedPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: product.discount != null
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      if (product.discount != null)
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
