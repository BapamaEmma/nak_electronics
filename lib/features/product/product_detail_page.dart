import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/core/services/product_service.dart';
import 'package:nak_electronics/features/home/sections/cart_drawer.dart';

/// SHEIN-style product details page.
///
/// Usage (local data):
///   ProductDetailPage(product: product);
///
/// Usage (Firestore when you re-enable Firebase):
///   ProductDetailPage.fromId(productId: '123', preferFirestore: true);
class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const CartDrawer(),
      body: SafeArea(
        child: _buildResolvedBody(context, product),
      ),
    );
  }

  /// Builds the full detail view given a resolved product.
  Widget _buildResolvedBody(BuildContext context, Product resolved,
      {String? error}) {
    // For related products, use local data for now (can be enhanced later)
    final related = ProductService.getProductsByCategory(resolved.category)
        .where((p) => p.id != resolved.id)
        .take(6)
        .toList();

    return Column(
      children: [
        _buildAppBar(context),
        if (error != null)
          Container(
            width: double.infinity,
            color: Colors.amber.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              error,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              child: Column(
                children: [
                  _buildMainContent(context, resolved),
                  const SizedBox(height: 32),
                  if (related.isNotEmpty)
                    _RelatedProductsRow(products: related),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 8),
          const Text(
            'Product Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Consumer<CartService>(
            builder: (context, cart, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
                if (cart.totalQuantity > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          cart.totalQuantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, Product product) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: image gallery
        Expanded(
          flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.music_note,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (product.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (product.discount != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '-${(product.discount! * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Right: details + actions
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.brand,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
            Text(
              product.name,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
            Text(
              '₵${product.discountedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 26,
                fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
              ),
            ),
                  if (product.discount != null) ...[
                    const SizedBox(width: 8),
              Text(
                '₵${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                        fontSize: 16,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Chip(
                    label: Text(product.category),
                    backgroundColor: Colors.grey[100],
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(product.type),
                    backgroundColor: Colors.grey[100],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
            Text(
                product.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<CartService>(context, listen: false)
                            .addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} added to cart',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black87),
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RelatedProductsRow extends StatelessWidget {
  final List<Product> products;

  const _RelatedProductsRow({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You may also like',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
            ),
            const SizedBox(height: 16),
            SizedBox(
          height: 220,
          child: ListView.separated(
                scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
              final p = products[index];
              return SizedBox(
                width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          p.image,
                          width: double.infinity,
                                  fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            child: const Icon(Icons.music_note),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                      p.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                        fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    const SizedBox(height: 4),
                          Text(
                      '₵${p.discountedPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                            ),
                          ),
                        ],
                    ),
                  );
                },
              ),
            ),
          ],
    );
  }
}

