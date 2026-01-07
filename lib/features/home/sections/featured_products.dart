import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/models/product.dart';

class FeaturedProductsSection extends StatefulWidget {
  const FeaturedProductsSection({super.key});

  @override
  State<FeaturedProductsSection> createState() =>
      _FeaturedProductsSectionState();
}

class _FeaturedProductsSectionState extends State<FeaturedProductsSection> {
  final ScrollController _scrollController = ScrollController();

  final List<FeaturedProduct> _featuredProducts = [
    FeaturedProduct(
      id: '1',
      name: 'Professional Studio Headphones',
      price: 450.00,
      originalPrice: 550.00,
      imagePath: 'assets/images/headphone.png',
      rating: 4.8,
      reviewCount: 124,
      isBestSeller: true,
    ),
    FeaturedProduct(
      id: '2',
      name: 'Electric Guitar Amplifier 50W',
      price: 1200.00,
      originalPrice: 1400.00,
      imagePath: 'assets/images/electricguitar.png',
      rating: 4.6,
      reviewCount: 89,
      isBestSeller: false,
    ),
    FeaturedProduct(
      id: '3',
      name: 'Professional Condenser Microphone',
      price: 320.00,
      originalPrice: 380.00,
      imagePath: 'assets/images/condenser.png',
      rating: 4.9,
      reviewCount: 156,
      isBestSeller: true,
    ),
    FeaturedProduct(
      id: '4',
      name: 'Digital Audio Interface',
      price: 680.00,
      originalPrice: 800.00,
      imagePath: 'assets/images/card.png',
      rating: 4.7,
      reviewCount: 73,
      isBestSeller: false,
    ),
    FeaturedProduct(
      id: '5',
      name: 'Acoustic Guitar Premium',
      price: 1800.00,
      originalPrice: 2200.00,
      imagePath: 'assets/images/acoustic.png',
      rating: 4.8,
      reviewCount: 92,
      isBestSeller: true,
    ),
    FeaturedProduct(
      id: '6',
      name: 'Tama Drum kit',
      price: 2500.00,
      originalPrice: 3000.00,
      imagePath: 'assets/images/Tamadrum.png',
      rating: 4.5,
      reviewCount: 67,
      isBestSeller: false,
    ),
  ];

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          Container(
            height: 480,
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
  final String imagePath;
  final double rating;
  final int reviewCount;
  final bool isBestSeller;

  FeaturedProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.isBestSeller,
  });

  /// Converts FeaturedProduct to Product for cart functionality
  Product toProduct() {
    final discount = (originalPrice - price) / originalPrice;
    return Product(
      id: id,
      name: name,
      price: originalPrice,
      image: imagePath,
      category: 'Featured',
      brand: 'Premium',
      description: 'Featured product with $rating star rating',
      isNew: isBestSeller,
      discount: discount > 0 ? discount : null,
      type: 'Instrument',
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

  @override
  Widget build(BuildContext context) {
    final discountPercentage =
        ((widget.product.originalPrice - widget.product.price) /
                widget.product.originalPrice *
                100)
            .round();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
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
              // Product image with badges
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          widget.product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.music_note,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    ),
                    // Best Seller badge
                    if (widget.product.isBestSeller)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'BEST SELLER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    // Discount badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '-$discountPercentage%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Product details
              Expanded(
                flex: 2,
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
                            '₵${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '₵${widget.product.originalPrice.toStringAsFixed(0)}',
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
    );
  }
}



