import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:nak_electronics/core/services/product_service.dart';
import 'package:nak_electronics/features/home/sections/cart_drawer.dart';
import 'package:nak_electronics/core/utils/image_widget.dart';

/// SHEIN-style product details page.
///
/// Usage:
///   ProductDetailPage(product: product);
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> _relatedProducts = [];
  bool _isLoadingRelated = true;
  bool _isPageLoading = true;
  int _selectedImageIndex = 0;
  int? _selectedColorIndex; // null = no colour selected yet
  late final DateTime _loadingStart;

  @override
  void initState() {
    super.initState();
    _loadingStart = DateTime.now();
    // Show page shimmer for 1.5s then reveal content
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isPageLoading = false);
    });
    _loadRelatedProducts();
  }

  Future<void> _loadRelatedProducts() async {
    try {
      final products = await ProductService.getProductsByCategory(
        widget.product.category,
      );
      final filtered = products
          .where((p) => p.id != widget.product.id)
          .take(6)
          .toList();
      final elapsed = DateTime.now().difference(_loadingStart).inMilliseconds;
      final remaining = 1500 - elapsed;
      if (remaining > 0) {
        await Future.delayed(Duration(milliseconds: remaining));
      }
      if (mounted) {
        setState(() {
          _relatedProducts = filtered;
          _isLoadingRelated = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingRelated = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const CartDrawer(),
      body: SafeArea(
        child: _isPageLoading
            ? _buildPageShimmer(context)
            : _buildResolvedBody(context, widget.product),
      ),
    );
  }

  Widget _buildPageShimmer(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(context),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              child: Shimmer.fromColors(
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: Colors.white,
                period: const Duration(milliseconds: 2500),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: image panel skeleton
                    SizedBox(
                      width: 420,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Thumbnail row skeleton
                          SizedBox(
                            height: 84,
                            child: Row(
                              children: List.generate(
                                4,
                                (_) => Container(
                                  width: 84,
                                  height: 84,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Right: text detail skeleton
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            width: 80,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 12),
                          Container(height: 22, color: const Color(0xFFE0E0E0)),
                          const SizedBox(height: 6),
                          Container(
                            height: 22,
                            width: 280,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 30,
                            width: 150,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 16,
                            width: 120,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 36,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 36,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            height: 16,
                            width: 100,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 10),
                          Container(height: 12, color: const Color(0xFFE0E0E0)),
                          const SizedBox(height: 6),
                          Container(height: 12, color: const Color(0xFFE0E0E0)),
                          const SizedBox(height: 6),
                          Container(
                            height: 12,
                            width: 260,
                            color: const Color(0xFFE0E0E0),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the full detail view given a resolved product.
  Widget _buildResolvedBody(
    BuildContext context,
    Product resolved, {
    String? error,
  }) {
    return Column(
      children: [
        _buildAppBar(context),
        if (error != null)
          Container(
            width: double.infinity,
            color: Colors.amber.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(error, style: const TextStyle(color: Colors.black87)),
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
                  if (_isLoadingRelated)
                    _RelatedProductsShimmer()
                  else if (_relatedProducts.isNotEmpty)
                    _RelatedProductsRow(products: _relatedProducts),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
        // Product image panel on the left
        SizedBox(
          width: 420,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main image
              AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.grey[100],
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ProductImage(
                          key: ValueKey(
                            _selectedColorIndex != null &&
                                    product
                                        .colorVariants[_selectedColorIndex!]
                                        .image
                                        .isNotEmpty
                                ? product
                                      .colorVariants[_selectedColorIndex!]
                                      .image
                                : (product.allImages.isNotEmpty
                                      ? product.allImages[_selectedImageIndex]
                                      : product.image),
                          ),
                          imagePath:
                              _selectedColorIndex != null &&
                                  product
                                      .colorVariants[_selectedColorIndex!]
                                      .image
                                      .isNotEmpty
                              ? product
                                    .colorVariants[_selectedColorIndex!]
                                    .image
                              : (product.allImages.isNotEmpty
                                    ? product.allImages[_selectedImageIndex]
                                    : product.image),
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        // Stock status badge on image
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: product.inStock
                                  ? Colors.green.withOpacity(0.9)
                                  : Colors.red.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  product.inStock
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  product.stockStatus,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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
              // Thumbnail row
              if (product.allImages.length > 1) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.allImages.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = index == _selectedImageIndex;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedImageIndex = index;
                          _selectedColorIndex = null;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.redAccent
                                  : Colors.grey.shade300,
                              width: isSelected ? 2.5 : 1.5,
                            ),
                            color: Colors.grey[100],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.5),
                            child: ProductImage(
                              imagePath: product.allImages[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Product details on the right
        Expanded(
          flex: 2,
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
                    'GH₵${product.discountedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  if (product.discount != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      'GH₵${product.price.toStringAsFixed(2)}',
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
              // Item ID (document ID always present)
              Row(
                children: [
                  const Text(
                    'Item ID: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    product.id,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Item Number (optional extra field)
              if (product.itemNumber != null) ...[
                Row(
                  children: [
                    const Text(
                      'Item #: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      product.itemNumber!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              // Availability/Stock Status
              // Stock badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: product.inStock
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: product.inStock ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      product.inStock ? Icons.check_circle : Icons.cancel,
                      size: 16,
                      color: product.inStock ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      product.stockStatus,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: product.inStock ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // Colour variants swatches
              if (product.colorVariants.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Colours',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(product.colorVariants.length, (i) {
                    final v = product.colorVariants[i];
                    final selected = _selectedColorIndex == i;
                    // Parse hex string like "#8B4513" → Color
                    Color swatchColor = Colors.grey;
                    try {
                      final hex = v.hex.replaceAll('#', '');
                      swatchColor = Color(int.parse('FF$hex', radix: 16));
                    } catch (_) {}
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedColorIndex = selected ? null : i;
                        _selectedImageIndex = 0;
                      }),
                      child: Tooltip(
                        message: v.name,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? Colors.redAccent
                                  : Colors.grey.shade300,
                              width: selected ? 2.0 : 1.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: swatchColor,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (_selectedColorIndex != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      product.colorVariants[_selectedColorIndex!].name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ] else if (product.colours != null &&
                  product.colours!.isNotEmpty) ...[
                // Fallback plain badge for old-style colours text
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Text(
                    product.colours!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                        Provider.of<CartService>(
                          context,
                          listen: false,
                        ).addToCart(product);
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

class _RelatedProductsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "You may also like" title placeholder
        Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: Colors.white,
          period: const Duration(milliseconds: 2500),
          child: Container(
            height: 20,
            width: 180,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        const SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: Colors.white,
          period: const Duration(milliseconds: 2500),
          child: SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) => SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: const Color(0xFFE0E0E0),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 120,
                      color: const Color(0xFFE0E0E0),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 14,
                      width: 80,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ],
                ),
              ),
            ),
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                        child: ProductImage(
                          imagePath: p.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                      'GH₵${p.discountedPrice.toStringAsFixed(2)}',
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
