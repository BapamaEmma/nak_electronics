import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/features/product/product_detail_page.dart';

class FeaturedProductsSection extends StatefulWidget {
  const FeaturedProductsSection({super.key});

  @override
  State<FeaturedProductsSection> createState() =>
      _FeaturedProductsSectionState();
}

class _FeaturedProductsSectionState extends State<FeaturedProductsSection> {
  final ScrollController _scrollController = ScrollController();
  List<FeaturedProduct> _featuredProducts = [];
  bool _isLoading = true;
  StreamSubscription? _subscription;
  DateTime? _loadingStart;

  @override
  void initState() {
    super.initState();
    _loadingStart = DateTime.now();
    _subscription = FirebaseFirestore.instance
        .collection('featured_products')
        .orderBy('order')
        .snapshots()
        .listen((snap) {
      final elapsed = DateTime.now().difference(_loadingStart!).inMilliseconds;
      final remaining = 1500 - elapsed;
      void applyData() {
        if (mounted) setState(() {
          _featuredProducts = snap.docs.map(FeaturedProduct.fromFirestore).toList();
          _isLoading = false;
        });
      }
      if (remaining > 0) {
        Future.delayed(Duration(milliseconds: remaining), applyData);
      } else {
        applyData();
      }
    }, onError: (_) => setState(() => _isLoading = false));
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          const Text(
            'Featured Products',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Discover our most popular and highly-rated musical instruments',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          if (_isLoading)
            SizedBox(
              height: 420,
              child: Shimmer.fromColors(
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: Colors.white,
                period: const Duration(milliseconds: 2500),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => _ShimmerFeaturedCard(),
                ),
              ),
            )
          else if (_featuredProducts.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No featured products yet.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            Container(
              height: 420,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    itemCount: _featuredProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 20),
                        child: FeaturedProductCard(
                          product: _featuredProducts[index],
                        ),
                      );
                    },
                  ),
                  // Left arrow
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: _scrollLeft,
                        ),
                      ),
                    ),
                  ),
                  // Right arrow
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 20),
                          onPressed: _scrollRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class FeaturedProduct {
  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isBestSeller;
  final int order;

  FeaturedProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.isBestSeller,
    required this.order,
  });

  factory FeaturedProduct.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return FeaturedProduct(
      id: doc.id,
      name: data['name']?.toString() ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (data['originalPrice'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl']?.toString() ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
      isBestSeller: data['isBestSeller'] == true,
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }

  Product toProduct() {
    final discount = originalPrice > 0
        ? (originalPrice - price) / originalPrice
        : 0.0;
    return Product(
      id: id,
      name: name,
      price: originalPrice,
      image: imageUrl,
      category: 'Featured',
      brand: 'Premium',
      description: 'Featured product with $rating star rating',
      isNew: isBestSeller,
      discount: discount > 0 ? discount : null,
      type: 'Instrument',
    );
  }
}

class _ShimmerFeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 70, color: const Color(0xFFE0E0E0)),
                const SizedBox(height: 8),
                Container(height: 13, color: const Color(0xFFE0E0E0)),
                const SizedBox(height: 4),
                Container(height: 13, width: 140, color: const Color(0xFFE0E0E0)),
                const SizedBox(height: 10),
                Container(height: 16, width: 90, color: const Color(0xFFE0E0E0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedProductCard extends StatefulWidget {
  final FeaturedProduct product;

  const FeaturedProductCard({super.key, required this.product});

  @override
  State<FeaturedProductCard> createState() => _FeaturedProductCardState();
}

class _FeaturedProductCardState extends State<FeaturedProductCard> {
  bool _isHovered = false;

  void _openProductDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: widget.product.toProduct()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openProductDetails(context),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openProductDetails(context),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: widget.product.imageUrl.isNotEmpty
                        ? Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFFF5F5F5),
                              child: const Icon(Icons.music_note, size: 36, color: Colors.grey),
                            ),
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: const Color(0xFFF5F5F5),
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              );
                            },
                          )
                        : Container(
                            color: const Color(0xFFF5F5F5),
                            child: const Icon(Icons.music_note, size: 36, color: Colors.grey),
                          ),
                  ),
                ),
              ),
              // Product details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Fixed height for product name (2 lines max)
                      SizedBox(
                        height: 48,
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Fixed height for rating
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < widget.product.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${widget.product.rating} (${widget.product.reviewCount})',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Price section - fixed at bottom
                      Row(
                        children: [
                          Text(
                            'GH₵${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'GH₵${widget.product.originalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Add to Cart button - always at bottom
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final cart = Provider.of<CartService>(context, listen: false);
                            final product = widget.product.toProduct();
                            cart.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${widget.product.name} added to cart'),
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.shopping_cart, size: 16),
                          label: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}



