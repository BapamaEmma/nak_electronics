import 'package:flutter/material.dart';
import 'package:nak_electronics/core/services/product_service.dart';
import 'package:nak_electronics/models/product.dart';
import 'package:nak_electronics/core/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:nak_electronics/features/product/product_detail_page.dart';

/// SHEIN-style explore section: search, filters, and a responsive product grid.
class ExploreProductsSection extends StatefulWidget {
  const ExploreProductsSection({super.key});

  @override
  State<ExploreProductsSection> createState() => _ExploreProductsSectionState();
}

class _ExploreProductsSectionState extends State<ExploreProductsSection> {
  late List<Product> _allProducts;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedSort = 'Popular';
  int _itemsToShow = 12; // Initial number of products to display
  static const int _itemsPerPage = 12; // Products to load per "Load More" click

  @override
  void initState() {
    super.initState();
    _allProducts = ProductService.getAllProducts();
  }

  List<String> get _categories {
    final set = <String>{};
    for (final p in _allProducts) {
      set.add(p.category);
    }
    return ['All', ...set.toList()..sort()];
  }

  List<Product> get _filteredProducts {
    Iterable<Product> products = _allProducts;

    if (_selectedCategory != 'All') {
      products =
          products.where((p) => p.category.toLowerCase() == _selectedCategory.toLowerCase());
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      products = products.where(
        (p) =>
            p.name.toLowerCase().contains(q) ||
            p.brand.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q),
      );
    }

    final list = products.toList();

    switch (_selectedSort) {
      case 'Price: Low to High':
        list.sort((a, b) => a.discountedPrice.compareTo(b.discountedPrice));
        break;
      case 'Price: High to Low':
        list.sort((a, b) => b.discountedPrice.compareTo(a.discountedPrice));
        break;
      case 'New Arrivals':
        list.sort((a, b) {
          if (a.isNew == b.isNew) return 0;
          return a.isNew ? -1 : 1;
        });
        break;
      case 'Popular':
      default:
        break;
    }

    return list;
  }

  void _resetPagination() {
    setState(() {
      _itemsToShow = _itemsPerPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allFilteredProducts = _filteredProducts;
    final productsToShow = allFilteredProducts.take(_itemsToShow).toList();
    final hasMore = _itemsToShow < allFilteredProducts.length;

    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Explore Products',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Browse and filter instruments just like a modern fashion store',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                _buildFiltersRow(),
                const SizedBox(height: 24),
                if (allFilteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'No products found. Try changing your filters.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else ...[
                  _buildGrid(productsToShow),
                  if (hasMore) ...[
                    const SizedBox(height: 32),
                    _buildLoadMoreButton(allFilteredProducts.length),
                  ],
                  if (!hasMore && allFilteredProducts.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Showing all ${allFilteredProducts.length} products',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadMore() {
    setState(() {
      _itemsToShow += _itemsPerPage;
    });
  }

  void _showAll() {
    setState(() {
      _itemsToShow = _filteredProducts.length;
    });
  }

  Widget _buildLoadMoreButton(int totalProducts) {
    final remaining = totalProducts - _itemsToShow;
    final showViewAll = remaining > _itemsPerPage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showViewAll)
          ElevatedButton.icon(
            onPressed: _showAll,
            icon: const Icon(Icons.grid_view),
            label: Text('View All ($totalProducts products)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          )
        else
          OutlinedButton.icon(
            onPressed: _loadMore,
            icon: const Icon(Icons.expand_more),
            label: Text('Load More ($remaining more)'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFiltersRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        final children = <Widget>[
          // Search field
          Expanded(
            flex: 3,
              child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _resetPagination();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, brand, category',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Category dropdown
          Expanded(
            flex: 2,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: _categories
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                        _resetPagination();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Sort dropdown
          Expanded(
            flex: 2,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSort,
                  icon: const Icon(Icons.sort),
                  items: const [
                    'Popular',
                    'Price: Low to High',
                    'Price: High to Low',
                    'New Arrivals',
                  ].map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSort = value;
                        _resetPagination();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ];

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              children[0],
              const SizedBox(height: 12),
              children[2],
              const SizedBox(height: 12),
              children[4],
            ],
          );
        }

        return Row(
          children: children,
        );
      },
    );
  }

  Widget _buildGrid(List<Product> products) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          'No products found. Try changing your filters.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1000) {
          crossAxisCount = 3;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.70,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final p = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: p),
                  ),
                );
              },
              child: _ProductGridCard(product: p),
            );
          },
        );
      },
    );
  }
}

class _ProductGridCard extends StatefulWidget {
  final Product product;

  const _ProductGridCard({required this.product});

  @override
  State<_ProductGridCard> createState() => _ProductGridCardState();
}

class _ProductGridCardState extends State<_ProductGridCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cart = Provider.of<CartService>(context, listen: false);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.05),
              blurRadius: _isHovered ? 14 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + badges
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  if (product.isNew)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (product.discount != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '-${(product.discount! * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Details
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brand,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '₵${product.discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        if (product.discount != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            '₵${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          foregroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () {
                          cart.addToCart(product);
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
                        icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 12),
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
    );
  }
}

